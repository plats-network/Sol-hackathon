import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/children/preview_photo/controller/preview_photo_controller.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';

part 'preview_photo_page_action.dart';

class PreviewPhotoPage extends StatefulWidget {
  const PreviewPhotoPage({Key? key}) : super(key: key);

  @override
  State<PreviewPhotoPage> createState() => _PreviewPhotoPageState();
}

class _PreviewPhotoPageState extends State<PreviewPhotoPage> {
  final PreviewPhotoController previewPhotoController = Get.find();
  final XFile imageFile = Get.arguments['image_file'];
  late Worker checkInLocationInTaskWorker;

  @override
  void initState() {
    super.initState();
    checkInLocationInTaskWorker = ever(
        previewPhotoController.checkInLocationInTask, (NetworkResource data) {
      if (data.isSuccess()) {
        Get.toNamed(Routes.taskReward, arguments: {
          'reward': previewPhotoController
              .checkInLocationInTask.value.data?.data?.reward
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final backButton = Padding(
      padding: const EdgeInsets.all(dimen32),
      child: AppBackButton(onTab: () {
        Get.back();
      }),
    );

    final photoPreview = Container(
      constraints: BoxConstraints(minHeight: Get.height / 2),
      child: ClipRRect(
          borderRadius: border24,
          child: Image.file(
            File(imageFile.path),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.75,
            fit: BoxFit.cover,
          )),
    );

    final retakeButton = Expanded(
      child: AppButton(
        title: 're_take'.tr,
        isPrimaryStyle: false,
        onTap: () {
          Get.back();
        },
      ),
    );

    final sendButton = Expanded(
      child: AppButton(
        title: 'send'.tr,
        onTap: () {
          previewPhotoController.postCheckInLocationInTask(imageFile);
        },
      ),
    );

    return Material(
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                  padding: EdgeInsets.all(dimen16),
                  child: Column(
                    children: [
                      photoPreview,
                      verticalSpace20,
                      Row(
                        children: [
                          retakeButton,
                          horizontalSpace16,
                          sendButton,
                        ],
                      )
                    ],
                  )),
              backButton,
              Obx(() => (previewPhotoController.isCheckingInLocationInTask())
                  ? FullScreenProgress()
                  : Container()),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    checkInLocationInTaskWorker.dispose();
    super.dispose();
  }
}
