import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/base/component/snackbar/getx_default_snack_bar.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:plat_app/main.dart';

part 'take_photo_page_action.dart';

class TakePhotoPage extends StatefulWidget {
  const TakePhotoPage({Key? key}) : super(key: key);

  @override
  State<TakePhotoPage> createState() => _TakePhotoPageState();
}

class _TakePhotoPageState extends State<TakePhotoPage> {
  late CameraController controller;
  int currentCamera = 0;
  XFile? imageFile;

  @override
  void initState() {
    super.initState();
    initCameraController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    final backButton = Padding(
      padding: const EdgeInsets.all(dimen32),
      child: AppBackButton(onTab: () {
        Get.back();
      }),
    );

    final cameraPreviewHeight = MediaQuery.of(context).size.width;
    final height = cameraPreviewHeight * controller.value.aspectRatio;
    final cameraPreview = SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
      child: ClipRRect(
        borderRadius: border24,
        child: OverflowBox(
          alignment: Alignment.center,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: SizedBox(
              width: cameraPreviewHeight,
              height: height,
              child: CameraPreview(controller), // this is my CameraPreview
            ),
          ),
        ),
      ),
    );

    final flashButton = InkWell(
      borderRadius: border30,
      child: Ink(
        width: dimen60,
        height: dimen60,
        child: Center(
          child: Image.asset(
            getAssetImage(AssetImagePath.ic_flash),
            width: dimen32,
            height: dimen32,
          ),
        ),
      ),
      onTap: () {
        onFlashButtonPressed();
      },
    );

    final takePhotoButton = InkWell(
      borderRadius: border80,
      child: Ink(
        width: dimen100,
        height: dimen100,
        child: Center(
          child: Image.asset(
            getAssetImage(AssetImagePath.ic_take_photo),
            width: dimen80,
            height: dimen80,
          ),
        ),
      ),
      onTap: () {
        onTakePictureButtonPressed();
      },
    );

    final reverseCameraButton = InkWell(
      borderRadius: border30,
      child: Ink(
        width: dimen60,
        height: dimen60,
        child: Center(
          child: Image.asset(
            getAssetImage(AssetImagePath.ic_refresh),
            width: dimen32,
            height: dimen32,
          ),
        ),
      ),
      onTap: () {
        if (currentCamera == 0) {
          if (cameras.length > 1) {
            currentCamera = 1;
            onNewCameraSelected(cameras[currentCamera]);
          }
        } else {
          currentCamera = 0;
          onNewCameraSelected(cameras[currentCamera]);
        }
      },
    );

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                  padding: const EdgeInsets.all(dimen16),
                  child: Column(
                    children: [
                      cameraPreview,
                      verticalSpace10,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          flashButton,
                          takePhotoButton,
                          reverseCameraButton,
                        ],
                      )
                    ],
                  )),
              backButton,
            ],
          ),
        ),
      ),
    );
  }
}
