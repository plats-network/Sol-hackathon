import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plat_app/app/page/home/children/task_perform/model/cancel_task_response.dart';
import 'package:plat_app/app/page/home/children/task_perform/model/doing_task_response.dart';
import 'package:plat_app/app/page/home/children/task_perform/provider/task_perform_provider.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/development.dart';

class TaskPerformController extends GetxController {
  final TaskPerformProvider taskPerformProvider = Get.find();
  final AppNotificationController appNotificationController = Get.find();

  final doingTask = Rx(NetworkResource<DoingTaskResponse>.init());


  bool isFetchingDoingTask() => doingTask.value.isLoading();

  bool isFetchDoingTaskSuccess() => doingTask.value.isSuccess();

  bool isFetchDoingTaskError() => doingTask.value.isError();

  final cancelTask = Rx(NetworkResource<CancelTaskResponse>.init());

  Future<void> patchCancelTask() async {
    final taskId = doingTask.value.data?.data?.task?.id;
    // Log event TASK_CANCEL
    logEvent(eventName: 'TASK_CANCEL', eventParameters: {
      'task_id': taskId,
    });
    // Cancel countdown notification
    appNotificationController.cancelCountDownNotification();
    // Delete polylines
    final storage = GetStorage();
    await storage.remove(keySavedPolyLines);
    cancelTask.value = NetworkResource<CancelTaskResponse>.loading();
    if (taskId != null) {
      final result = await taskPerformProvider
          .patchCancelTask(doingTask.value.data?.data?.task?.id ?? '');
      NetworkResource.handleResponse(
          result, CancelTaskResponse.fromJson, cancelTask,
          isShowError: true);
    } else {
      cancelTask.value = NetworkResource<CancelTaskResponse>.success();
    }
  }

  Future<void> patchCancelOldPolyline() async {
    // Cancel countdown notification
    appNotificationController.cancelCountDownNotification();
    // Delete polylines
    final storage = GetStorage();
    await storage.remove(keySavedPolyLines);
  }

  bool isCancelingTask() => cancelTask.value.isLoading();

  bool isCancelTaskSuccess() => cancelTask.value.isSuccess();

  bool isCancelTaskError() => cancelTask.value.isError();

  bool isDoingTask() => doingTask.value.data?.data?.task?.id != null;
}
