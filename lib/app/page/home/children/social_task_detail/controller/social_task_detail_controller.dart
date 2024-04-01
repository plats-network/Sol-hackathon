import 'dart:math';

import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/model/social_task_detail_response.dart'
    as task_detail;
import 'package:plat_app/app/page/home/children/social_task_detail/model/social_network_reponse.dart'
    as like_or_pin;
import 'package:plat_app/app/page/home/children/social_task_detail/model/start_job_reponse.dart'
    as start_job;
import 'package:plat_app/app/page/home/children/social_task_detail/model/get_ticket_reponse.dart'
    as resultGetTicket;
import 'package:plat_app/app/page/home/children/social_task_detail/provider/social_account_provider.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/provider/social_task_detail_provider.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class SocialTaskDetailController extends GetxController {
  final SocialTaskDetailProvider socialTaskDetailProvider = Get.find();
  // final SocialAccountProvider socialAccountProvider = Get.find();
  final AuthController authController = Get.find();
  bool isLike = false;
  bool isPin = false;

  final taskDetailData =
      Rx(NetworkResource<task_detail.SocialTaskDetailResponse>.init());
  final submitLikeOrPin =
      Rx(NetworkResource<like_or_pin.JoinOrPinResponse>.init());
  final submitStartJob = Rx(NetworkResource<start_job.StartJobResponse>.init());
  final getTicket =
      Rx(NetworkResource<resultGetTicket.GetTicketResponse>.init());

  final startTaskData =
      Rx(NetworkResource<task_detail.SocialTaskDetailResponse>.init());
  // final connectTwitterData =
  //     Rx(NetworkResource<social_update_response.SocialUpdateResponse>.init());
  // final socialAccountData =
  //     Rx(NetworkResource<social_account_response.SocialAccountResponse>.init());
  // final submitSocialTaskData =
  //     Rx(NetworkResource<submit.SubmitSocialTaskResponse>.init());

  task_detail.Data? get taskDetail => taskDetailData.value.data?.data;

  void fetchTaskDetail(String taskId) async {
    taskDetailData.value =
        NetworkResource.loading(data: taskDetailData.value.data);

    final result = await socialTaskDetailProvider.fetchTaskTaskDetail(taskId);

    NetworkResource.handleResponse(
      result,
      task_detail.SocialTaskDetailResponse.fromJson,
      taskDetailData,
      isShowError: true,
    );
  }

  void fetchStartJob(String taskId, String jobId, String type) async {
    submitStartJob.value = NetworkResource.loading();

    final result =
        await socialTaskDetailProvider.postSubmitStartJob(taskId, jobId, type);

    NetworkResource.handleResponse(
      result,
      start_job.StartJobResponse.fromJson,
      submitStartJob,
      isShowError: true,
    );
  }

  Future<void> fetchLikeOrPin(String taskId, String type) async {
    submitLikeOrPin.value = NetworkResource.loading();

    final result = await socialTaskDetailProvider.LikeOrPinTask(taskId, type);
    NetworkResource.handleResponse(
      result,
      like_or_pin.JoinOrPinResponse.fromJson,
      submitLikeOrPin,
    );
  }

  bool isFetchingTaskDetail() {
    return taskDetailData.value.isLoading();
  }

  bool isTaskDetailFetchSuccess() {
    return taskDetailData.value.isSuccess();
  }

  void startTask(String taskId, String type) async {
    startTaskData.value = NetworkResource.loading();

    final result = await socialTaskDetailProvider.startSocialTask(taskId, type);

    NetworkResource.handleResponse(
      result,
      task_detail.SocialTaskDetailResponse.fromJson,
      startTaskData,
      isShowError: true,
    );
  }

  //get ticket

  void fetchGetTicket(String taskId) async {
    getTicket.value = NetworkResource.loading();

    final result = await socialTaskDetailProvider.getTicket(taskId);
    NetworkResource.handleResponse(
      result,
      resultGetTicket.GetTicketResponse.fromJson,
      getTicket,
    );
  }

  bool isFetchingGetTicket() {
    return getTicket.value.isLoading();
  }

  bool isGetTicketFetchSuccess() {
    return getTicket.value.isSuccess();
  }

  final _selectedLocationIndex = (-1).obs;

  get selectedLocationIndex => _selectedLocationIndex.value;
  final _distanceBetween = double.nan.obs;
  double get distanceBetween => _distanceBetween.value;
  RxBool isSortingLocation = true.obs;

  void setSelectedLocationIndex(int index) {
    _selectedLocationIndex.value = index;
  }

  double _calculateDistance(lat1, long1, lat2, long2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((long2 - long1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  bool isStartTaskLoading() {
    return startTaskData.value.isLoading();
  }
  // Future<double> _distanceFromUserToLocation(selectedLocationIndex) async {
  // final myLocation = await Location.instance.getLocation();

  // final distance = _calculateDistance(
  //   double.tryParse(
  //       taskDetail?.locations?[selectedLocationIndex].lat ?? '0')!,
  //   double.tryParse(
  //       taskDetail?.locations?[selectedLocationIndex].long ?? '0')!,
  //   myLocation.latitude,
  //   myLocation.longitude,
  // );

  // return distance;
  // }

  // void updateDistanceBetween() async {
  //   _distanceBetween.value = double.nan;

  //   double distance = await _distanceFromUserToLocation(selectedLocationIndex);

  //   _distanceBetween.value = distance;
  // }

  // void fetchSocialAccount() async {
  //   socialAccountData.value = NetworkResource.loading();

  //   final result = await socialAccountProvider.fetchSocialAccount();

  //   NetworkResource.handleResponse(
  //     result,
  //     social_account_response.SocialAccountResponse.fromJson,
  //     socialAccountData,
  //     isShowError: true,
  //   );
  // }

  // String? get connectedTwitterId => socialAccountData.value.data?.data?.twitter;
  // bool get isConnectedTwitter =>
  //     connectedTwitterId != null && connectedTwitterId?.isNotEmpty == true;

  // Future<int> connectTwitterAccount() async {
  //   connectTwitterData.value = NetworkResource.loading();

  //   try {
  //     final id = await authController.fetchTwitterId();

  //     final result =
  //         await socialAccountProvider.connectTwitter('twitter', id.toString());

  //     NetworkResource.handleResponse(
  //       result,
  //       social_update_response.SocialUpdateResponse.fromJson,
  //       connectTwitterData,
  //     );

  //     return id;
  //   } catch (e) {
  //     return Future.error(e.toString().contains("Exception:") == true ? e.toString().substring(10) : e);
  //   } finally {
  //     connectTwitterData.value = NetworkResource.init();
  //   }
  // }

  // bool isConnectTwitterLoading() {
  //   return connectTwitterData.value.isLoading();
  // }

  // Future<void> submitSocialTask(String taskId, String socialId, String type,
  //     {withUpdate = false}) async {
  //   submitSocialTaskData.value = NetworkResource.loading();

  //   final result = await socialTaskDetailProvider.postSubmitSocialTask(
  //       taskId, socialId, type);

  //   NetworkResource.handleResponse(
  //     result,
  //     submit.SubmitSocialTaskResponse.fromJson,
  //     submitSocialTaskData,
  //   );

  //   if (withUpdate && result.isOk) {
  //     taskDetail?.socials?.forEach((social) {
  //       if (social.id == socialId) {
  //         social.action?.status = true;
  //         update();
  //       }
  //     });

  //     // last task check
  //     final isLastTask = taskDetail?.socials
  //         ?.where((element) => element.action?.status == false)
  //         .isEmpty;

  //     if (isLastTask == true) {
  //       final reward = taskDetailData.value.data?.data?.rewards;

  //       Get.offNamed(Routes.taskReward, arguments: {'reward': reward});
  //     } else {
  //       fetchTaskDetail(taskId);
  //     }
  //   }
  // }

  // bool isSubmitSocialTaskLoading() {
  //   return submitSocialTaskData.value.isLoading();
  // }
}
