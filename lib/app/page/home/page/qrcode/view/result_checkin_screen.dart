import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/qrcode/controller/qrcode_controller.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'dart:io' show Platform;

import 'package:plat_app/base/routes/base_pages.dart';

class ResultCheckinScreen extends StatefulWidget {
  const ResultCheckinScreen({Key? key}) : super(key: key);

  @override
  State<ResultCheckinScreen> createState() => _ResultCheckinScreenState();
}

class _ResultCheckinScreenState extends State<ResultCheckinScreen>
    with TickerProviderStateMixin {
  final QrCodeController qrCodeController = Get.find();
  ConfettiController? _confettiController;

  @override
  void initState() {
    super.initState();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 10),
    );
    Future.delayed(const Duration(seconds: 1), () {
      _confettiController?.play();
    });
  }

  @override
  void dispose() {
    _confettiController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          CommonAppBarPage(
            isHeader: false,
            title: ''.tr,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Image.asset('assets/images/done.gif'),
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: dimen30),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _confettiController?.play();
                              },
                              child: const Text(
                                'Check-in Successful!',
                                style: TextStyle(
                                  color: color1D93E3,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            verticalSpace10,
                            const Text(
                              'Thank you for joining our event, have a great time!',
                              style: TextStyle(
                                color: color1D93E3,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(flex: 2),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConfettiWidget(
                        confettiController:
                            _confettiController as ConfettiController,
                        blastDirectionality: BlastDirectionality.explosive,
                        shouldLoop: true,
                        numberOfParticles: 20,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: dimen0,
                  left: dimen16,
                  right: dimen16,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, Routes.home, (_) => false);
                    },
                    child: Container(
                      margin: Platform.isIOS &&
                              MediaQuery.of(context).size.height >= 812
                          ? const EdgeInsets.only(top: dimen10, bottom: dimen24)
                          : const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: color1D93E3,
                        borderRadius: BorderRadius.circular(dimen8),
                        boxShadow: [
                          BoxShadow(
                              color: colorPrimary.withOpacity(0.5),
                              blurRadius: dimen5,
                              offset: const Offset(0, 2)),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'View Event',
                          style: TextStyle(
                            color: colorWhite,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          qrCodeController.isFetchingResultQrCode()
              ? const FullScreenProgress()
              : Container()
        ],
      ),
    );
  }

  Text _display(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.white, fontSize: 20),
    );
  }
}
