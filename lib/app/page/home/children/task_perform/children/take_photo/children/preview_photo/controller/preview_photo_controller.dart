import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/children/preview_photo/provider/preview_photo_provider.dart';
import 'package:plat_app/app/page/home/children/task_perform/controller/task_perform_controller.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/children/preview_photo/model/checkin_location_in_task_response.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class PreviewPhotoController extends GetxController {
  final PreviewPhotoProvider previewPhotoProvider = Get.find();
  final TaskPerformController taskPerformController = Get.find();

  final checkInLocationInTask =
  Rx(NetworkResource<CheckinLocationInTaskResponse>.init());

  void postCheckInLocationInTask(XFile image) async {
    checkInLocationInTask.value =
    NetworkResource<CheckinLocationInTaskResponse>.loading();
    final body = FormData({
      'image': MultipartFile(File(image.path), filename: image.name),
    });
    final doingTask = taskPerformController.doingTask.value.data?.data;
    final result = await previewPhotoProvider.postCheckInLocationInTask(
        doingTask?.task?.id ?? '',
        doingTask?.taskLocations?.id?? '', body);
    NetworkResource.handleResponse(
        result, CheckinLocationInTaskResponse.fromJson, checkInLocationInTask,
        isShowError: true);
  }

  bool isCheckingInLocationInTask() => checkInLocationInTask.value.isLoading();

  bool isCheckInLocationTaskSuccess() =>
      checkInLocationInTask.value.isSuccess();

  bool isCheckInLocationInTaskError() => checkInLocationInTask.value.isError();
}