part of 'take_photo_page.dart';

extension TakePhotoPageAction on _TakePhotoPageState {
  void initCameraController() {
    controller = CameraController(cameras[currentCamera], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  void onFlashButtonPressed() {
    controller.setFlashMode(controller.value.flashMode != FlashMode.torch
        ? FlashMode.torch
        : FlashMode.off);
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) async {
      if (mounted && file != null) {
        imageFile = await resizeImage(file);
        if (imageFile != null) {
          controller.setFlashMode(FlashMode.off);
          Get.toNamed(Routes.previewPhoto,
              arguments: {'image_file': imageFile});
        } else {
          GetXDefaultSnackBar.rawSnackBar(title: 'Shoot again');
        }
      }
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController cameraController = controller;
    if (!cameraController.value.isInitialized) {
      GetXDefaultSnackBar.rawSnackBar(title: 'Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      GetXDefaultSnackBar.rawSnackBar(
          title: 'Error: ${e.code}\n${e.description}');
      return null;
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    final CameraController oldController = controller;
    await oldController.dispose();

    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
    );

    controller = cameraController;

    // If the controller is updated then update the UI.
    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
      if (cameraController.value.hasError) {
        GetXDefaultSnackBar.rawSnackBar(
            title: 'Camera error ${cameraController.value.errorDescription}');
      }
    });

    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          GetXDefaultSnackBar.rawSnackBar(
              title: 'You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          GetXDefaultSnackBar.rawSnackBar(
              title: 'Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          GetXDefaultSnackBar.rawSnackBar(
              title: 'Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          GetXDefaultSnackBar.rawSnackBar(
              title: 'You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          GetXDefaultSnackBar.rawSnackBar(
              title: 'Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          GetXDefaultSnackBar.rawSnackBar(title: 'Audio access is restricted.');
          break;
        default:
          GetXDefaultSnackBar.rawSnackBar(
              title: 'Error: ${e.code}\n${e.description}');
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }
}
