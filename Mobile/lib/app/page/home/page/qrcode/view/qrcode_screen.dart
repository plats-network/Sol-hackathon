import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/home/page/index/view/ongoing_event_screen.dart';
import 'package:plat_app/app/page/home/page/qrcode/controller/qrcode_controller.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({Key? key}) : super(key: key);

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  final QrCodeController qrCodeController = Get.find();
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  Barcode? result;
  late MethodChannel _channel;
  late Worker even1;
  late Worker even2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onQRViewCreated;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    });
  }

  Future<void> updateDimensions() async {
    await QRViewController.updateDimensions(qrKey, _channel);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    even1.dispose();
    even2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: colorPrimary,
            title: Text(
              'Scan QR Code',
              style: GoogleFonts.quicksand(
                color: colorWhite,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
            leading: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.close,
                  color: colorWhite,
                  size: dimen22,
                )),
            actions: [
              buildControllerButtons(),
            ],
          ),
          body: Stack(
            children: [
              buildQrView(context),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: buildReslt(),
              // ),
              // Align(
              //   alignment: Alignment.topCenter,
              //   child: buildControllerButtons(),
              // ),
              // qrCodeController.isFetchingQrCode() ||
              qrCodeController.isFetchingResultQrCode()
                  ? const FullScreenProgress()
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRViewCreated,
        overlay: QrScannerOverlayShape(
          cutOutSize: MediaQuery.of(context).size.width * 0.7,
          borderColor: color30A1DB,
          borderRadius: 43,
          // borderLength: 20,
          borderWidth: 3,
          overlayColor: color32302D.withOpacity(0.95),
        ),
      );
  // Widget buildReslt() => GestureDetector(
  //       onTap: () {
  //         controller?.dispose();
  //         controller?.pauseCamera();
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => const ResultCheckinScreen(),
  //           ),
  //         );
  //       },
  //       child: Container(
  //         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
  //         margin: const EdgeInsets.only(bottom: 20),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(8),
  //           color: Colors.white24,
  //         ),
  //         child: const Text(
  //           'Scanning',
  //           style: TextStyle(
  //             color: colorWhite,
  //           ),
  //         ),
  //       ),
  //     );

  Widget buildControllerButtons() => Container(
        // padding: const EdgeInsets.only(top: 45),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () async {
                await controller?.toggleFlash();
                setState(() {});
              },
              icon: FutureBuilder<bool?>(
                future: controller?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(
                      snapshot.data! ? Icons.flash_on : Icons.flash_off,
                      color: colorWhite,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            IconButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              icon: FutureBuilder(
                future: controller?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return const Icon(
                      Icons.switch_camera,
                      color: colorWhite,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      );
  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((result) {
      setState(() => this.result = result);
      setState(() async {
        if (result.code.toString().contains('plats.network') == true) {
          try {
            await controller.pauseCamera();
            Uri uri = Uri.parse(result.code.toString());
            String typeValue = uri.queryParameters['type'] ?? '';
            String idValue = uri.queryParameters['id'] ?? '';
            qrCodeController.fetchScanQrCode(typeValue, idValue);
            setState(() {
              even1 =
                  ever(qrCodeController.submitQrCode, (NetworkResource data) {
                if (data.isSuccess()) {
                  if (typeValue == 'event') {
                    qrCodeController.fetchResultScanQrCode(
                      qrCodeController.submitQrCode.value.data?.data['task_id'],
                    );
                    even2 = ever(qrCodeController.resultQrCode,
                        (NetworkResource dataDetail) {
                      if (dataDetail.isSuccess()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OnGoingEventScreen(
                              eventId: qrCodeController
                                      .submitQrCode.value.data?.data['task_id']
                                      .toString() ??
                                  '',
                            ),
                          ),
                        );
                      } else if (dataDetail.isError()) {
                        print('.....................');
                      }
                    });
                  }
                }
                //  else if (data.isError()) {
                //   print('k4');
                //   OverlayState? state = Overlay.of(context);
                //   showTopSnackBar(
                //     state!,
                //     CustomSnackBar.info(
                //       message: "Incorrect QR code.",
                //       textStyle: GoogleFonts.quicksand(
                //         fontSize: 14,
                //         color: colorWhite,
                //         fontWeight: FontWeight.w600,
                //       ),
                //       icon: Image.asset(
                //         getAssetImage(
                //           AssetImagePath.plats_logo,
                //         ),
                //       ),
                //       backgroundColor: colorPrimary,
                //       iconRotationAngle: -30,
                //       iconPositionTop: 10,
                //       iconPositionLeft: -10,
                //     ),
                //   );
                //   Future.delayed(const Duration(seconds: 2), () {
                //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                //     controller.pauseCamera();
                //   });

                //   Future.delayed(const Duration(seconds: 3), () {
                //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                //     controller.resumeCamera();
                //   });
                // }
                // else {
                //   print('k3');
                //   OverlayState? state = Overlay.of(context);
                //   showTopSnackBar(
                //     state!,
                //     CustomSnackBar.info(
                //       message: "Incorrect QR code.",
                //       textStyle: GoogleFonts.quicksand(
                //         fontSize: 14,
                //         color: colorWhite,
                //         fontWeight: FontWeight.w600,
                //       ),
                //       icon: Image.asset(
                //         getAssetImage(
                //           AssetImagePath.plats_logo,
                //         ),
                //       ),
                //       backgroundColor: colorPrimary,
                //       iconRotationAngle: -30,
                //       iconPositionTop: 10,
                //       iconPositionLeft: -10,
                //     ),
                //   );
                //   Future.delayed(const Duration(seconds: 2), () {
                //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                //     controller.pauseCamera();
                //   });

                //   Future.delayed(const Duration(seconds: 3), () {
                //     ScaffoldMessenger.of(context).hideCurrentSnackBar();
                //     controller.resumeCamera();
                //   });
                // }
              });
            });
          } on FormatException {
            // OverlayState? state = Overlay.of(context);
            // showTopSnackBar(
            //   state!,
            //   CustomSnackBar.info(
            //     message: "Incorrect QR code.",
            //     textStyle: GoogleFonts.quicksand(
            //       fontSize: 14,
            //       color: colorWhite,
            //       fontWeight: FontWeight.w600,
            //     ),
            //     icon: Image.asset(
            //       getAssetImage(
            //         AssetImagePath.plats_logo,
            //       ),
            //     ),
            //     backgroundColor: colorPrimary,
            //     iconRotationAngle: -30,
            //     iconPositionTop: 10,
            //     iconPositionLeft: -10,
            //   ),
            // );
            // Future.delayed(const Duration(seconds: 2), () {
            //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
            //   controller.pauseCamera();
            // });

            // Future.delayed(const Duration(seconds: 3), () {
            //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
            //   controller.resumeCamera();
            // });
          }
        } else {
          OverlayState? state = Overlay.of(context);
          showTopSnackBar(
            state!,
            CustomSnackBar.info(
              message: "Incorrect QR code.",
              textStyle: GoogleFonts.quicksand(
                fontSize: 14,
                color: colorWhite,
                fontWeight: FontWeight.w600,
              ),
              icon: Image.asset(
                getAssetImage(
                  AssetImagePath.plats_logo,
                ),
              ),
              backgroundColor: colorPrimary,
              iconRotationAngle: -30,
              iconPositionTop: 10,
              iconPositionLeft: -10,
            ),
          );
          Future.delayed(const Duration(seconds: 2), () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            controller.pauseCamera();
          });

          Future.delayed(const Duration(seconds: 3), () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            controller.resumeCamera();
          });
        }
      });
      controller.scannedDataStream.listen((scanData) {
        setState(() {
          result = scanData;
        });
      });
    });

    controller.pauseCamera();
    controller.resumeCamera();
  }
}
