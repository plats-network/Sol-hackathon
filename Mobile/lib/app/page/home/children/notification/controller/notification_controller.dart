import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/notification/provider/notification_provider.dart';
import 'package:plat_app/app/page/home/children/task_detail/model/task_detail_response.dart';
import 'package:plat_app/app/page/home/children/task_detail/provider/task_detail_provider.dart';
import 'package:plat_app/app/page/home/model/Notification_detail_response.dart';
import 'package:plat_app/app/page/home/model/list_notifications_response.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class NotificationController extends GetxController {
  final notificationProvider = Get.find<NotificationProvider>();
  final TaskDetailProvider taskDetailProvider = Get.find();

  final Rx<NetworkResource<ListNotificationsResponse>> listNotificationsData =
      Rx(NetworkResource<ListNotificationsResponse>.init());

  final Rx<NetworkResource<ListNotificationsResponse>>
      listNewTaskNotificationsData =
      Rx(NetworkResource<ListNotificationsResponse>.init());

  final Rx<NetworkResource<ListNotificationsResponse>>
      listUnboxNotificationsData =
      Rx(NetworkResource<ListNotificationsResponse>.init());

  final Rx<NetworkResource<TaskDetailResponse>> _taskDetailData =
      Rx(NetworkResource<TaskDetailResponse>.init());

  final Rx<int> unreadNotificationCount = Rx(0);
  final Rx<int> unreadNewTaskNotificationCount = Rx(0);
  final Rx<int> unreadUnboxNotificationCount = Rx(0);

  /// - ko có type lấy all
  /// - type=0: New task
  /// - type=1: Unbox
  Future<void> fetchNotifications(
      {int? type,
      required Rx<NetworkResource<ListNotificationsResponse>> data}) async {
    data.value = NetworkResource<ListNotificationsResponse>.loading();
    Response result;
    result = await notificationProvider.fetchListNotifications(type);
    NetworkResource.handleResponse(
        result, ListNotificationsResponse.fromJson, data,
        isShowError: false);
  }

  Future<void> fetchListNotifications() async {
    await fetchNotifications(type: null, data: listNotificationsData);
    unreadNotificationCount.value = listNotificationsData.value.data?.data
            ?.where((element) => element.isRead != true)
            .length ??
        0;
  }

  Future<void> fetchNewTaskListNotifications() async {
    await fetchNotifications(type: 0, data: listNewTaskNotificationsData);
    unreadNewTaskNotificationCount.value = listNewTaskNotificationsData
            .value.data?.data
            ?.where((element) => element.isRead != true)
            .length ??
        0;
  }

  Future<void> fetchUnboxListNotifications() async {
    await fetchNotifications(type: 1, data: listUnboxNotificationsData);
    unreadUnboxNotificationCount.value = listUnboxNotificationsData
            .value.data?.data
            ?.where((element) => element.isRead != true)
            .length ??
        0;
  }

  bool isGettingListNotifications() {
    return listNotificationsData.value.isLoading();
  }

  bool isGetListNotificationsSuccess() {
    return listNotificationsData.value.isSuccess();
  }

  bool isGetListNotificationsError() {
    return listNotificationsData.value.isError();
  }

  bool isGettingListNewTaskNotifications() {
    return listNewTaskNotificationsData.value.isLoading();
  }

  bool isGettingListUnboxNotifications() {
    return listUnboxNotificationsData.value.isLoading();
  }

  final Rx<NetworkResource<NotificationDetailResponse>> notificationDetailData =
      Rx(NetworkResource<NotificationDetailResponse>.init());

  Future<void> fetchNotificationDetail(id) async {
    notificationDetailData.value =
        NetworkResource<NotificationDetailResponse>.loading();
    Response result;
    result = await notificationProvider.fetchNotificationDetail(id);
    NetworkResource.handleResponse(
        result, NotificationDetailResponse.fromJson, notificationDetailData,
        isShowError: false);
  }

  bool isGettingNotificationDetail() {
    return notificationDetailData.value.isLoading();
  }

  bool isGetNotificationDetailSuccess() {
    return notificationDetailData.value.isSuccess();
  }

  bool isGetNotificationDetailError() {
    return notificationDetailData.value.isError();
  }

  Future<String?> fetchTaskType(String taskId) async {
    _taskDetailData.value = NetworkResource<TaskDetailResponse>.loading();

    Response result = await taskDetailProvider.fetchTaskDetail(taskId);

    NetworkResource.handleResponse(
        result, TaskDetailResponse.fromJson, _taskDetailData,
        isShowError: false);

    if (result.hasError) {
      return null;
    }

    return result.body['data']['type'].toString();
  }

  bool isFetchingTaskType() {
    return _taskDetailData.value.isLoading();
  }
}
