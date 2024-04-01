import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as perm;
import 'package:plat_app/app/page/home/children/task_detail/model/start_task_response.dart'
    as start_task;
import 'package:plat_app/app/page/home/children/task_detail/model/task_detail_response.dart'
    as task_detail;
import 'package:plat_app/app/page/home/children/task_detail/provider/task_detail_provider.dart';
import 'package:plat_app/app/page/home/children/task_perform/controller/task_perform_controller.dart';
import 'package:plat_app/base/component/dialog/getx_default_dialog.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/development.dart';

class TaskDetailController extends GetxController {
  final taskDetailData =
      Rx(NetworkResource<task_detail.TaskDetailResponse>.init());
  final startTaskData =
      Rx(NetworkResource<start_task.StartTaskResponse>.init());
  final _selectedLocationIndex = 0.obs;

  get selectedLocationIndex => _selectedLocationIndex.value;
  final TaskDetailProvider taskDetailProvider = Get.find();
  final TaskPerformController taskPerformController = Get.find();
  final _distanceBetween = double.nan.obs;

  double get distanceBetween => _distanceBetween.value;
  RxBool isSortingLocation = true.obs;
  RxList<Marker> mapMarkers = <Marker>[].obs;

  @override
  void dispose() {
    // Get.delete<TaskDetailController>();
    onDelete();
    Get.log('TaskDetailController onDelete() called');
    super.dispose();
  }

  Future<void> fetchTaskDetail(String taskId) async {
    taskDetailData.value =
        NetworkResource<task_detail.TaskDetailResponse>.loading();

    var result = await taskDetailProvider.fetchTaskDetail(taskId);

    // devMock(() async {
    //   result = mockResponse(mockTaskDetailResponseSuccess);
    //   await Future.delayed(const Duration(seconds: 2));
    // });

    NetworkResource.handleResponse(
      result,
      task_detail.TaskDetailResponse.fromJson,
      taskDetailData,
      isShowError: true,
    );
  }

  Future<void> startTask({required String taskId, bool force = false}) async {
    startTaskData.value =
        NetworkResource<start_task.StartTaskResponse>.loading();

    if (selectedLocationIndex >= taskDetail?.locations?.length) return;

    final location = taskDetail?.locations![selectedLocationIndex];
    final result = await taskDetailProvider.postStartTask(taskId, location!.id!,
        force: force);

    NetworkResource.handleResponse(
      result,
      start_task.StartTaskResponse.fromJson,
      startTaskData,
      isShowError: true,
    );
  }

  // will request for permission if needed, because permission is required for this function to run
  Future<void> sortTaskDetailLocations() async {
    isSortingLocation.value = true;

    try {
      // sort locations by distance
      final locations = taskDetail?.locations;

      // check if location is granted
      final locationPermission = await perm.Permission.locationWhenInUse.status;

      if (locationPermission != perm.PermissionStatus.granted) {
        // request permission
        await showNeedLocationDialog(() async {
          await devDebugMock(() async {
            print(
                'permission status: ${await perm.Permission.locationWhenInUse.status}');
          });

          if (locationPermission == perm.PermissionStatus.permanentlyDenied) {
            // show dialog to open settings
            await perm.openAppSettings();
          } else if (locationPermission == perm.PermissionStatus.denied) {
            // request permission
            await perm.Permission.locationWhenInUse.request();
            if (await perm.Permission.location.serviceStatus.isDisabled) {
              await Location.instance.requestService();
            }
          }
        });
      }

      final isGranted = await perm.Permission.locationWhenInUse.isGranted;
      if (locations != null && isGranted) {
        // TODO: update library flutter location to ensure the library has fixed the bug
        // that IOS SIMULATORS can't get location despite the permission is granted
        // https://github.com/Lyokone/flutterlocation/issues/621#issuecomment-1042470703
        final LocationData currentLocation = await Location()
            .getLocation()
            .timeout(
              const Duration(seconds: 2),
            )
            .catchError((e) {
          return Future.value(LocationData.fromMap({
            'latitude': double.nan,
            'longitude': double.nan,
          }));
        });

        if (currentLocation.latitude == double.nan ||
            currentLocation.longitude == double.nan) {
          return;
        }

        locations.sort((a, b) {
          if (a.lat == null || a.long == null) return 1;

          final distanceA = _calculateDistance(
            currentLocation.latitude,
            currentLocation.longitude,
            double.tryParse(a.lat!) ?? 0,
            double.tryParse(a.long!) ?? 0,
          );

          final distanceB = _calculateDistance(
            currentLocation.latitude,
            currentLocation.longitude,
            double.tryParse(b.lat!) ?? 0,
            double.tryParse(b.long!) ?? 0,
          );

          return distanceA.compareTo(distanceB);
        });
      }
    } catch (e) {
      // currently ignore, should print out to screen when user not accept location
      devDebugMock(() {
        e.printError();
      });
    } finally {
      isSortingLocation.value = false;
    }
  }

  // Show need location dialog
  Future<void> showNeedLocationDialog(VoidCallback onConfirm) async {
    return GetXDefaultDialog.defaultDialog(
        title: 'request_location_permission'.tr,
        middleText: 'app_collects_location_data'.tr,
        textCancel: 'cancel'.tr,
        textConfirm: 'ok'.tr,
        onConfirm: onConfirm);
  }

  // create getter type of Task
  task_detail.Data? get taskDetail => taskDetailData.value.data?.data;

  bool isFetchingTaskDetail() {
    return taskDetailData.value.isLoading();
  }

  bool isTaskDetailFetchSuccess() {
    return taskDetailData.value.isSuccess();
  }

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

  Future<double> _distanceFromUserToLocation(selectedLocationIndex) async {
    final myLocation = await Location.instance.getLocation();

    final distance = _calculateDistance(
      double.tryParse(
          taskDetail?.locations?[selectedLocationIndex].lat ?? '0')!,
      double.tryParse(
          taskDetail?.locations?[selectedLocationIndex].long ?? '0')!,
      myLocation.latitude,
      myLocation.longitude,
    );

    return distance;
  }

  void updateDistanceBetween() async {
    _distanceBetween.value = double.nan;

    double distance = await _distanceFromUserToLocation(selectedLocationIndex);

    _distanceBetween.value = distance;
  }

  bool isStartTaskSuccess() {
    return startTaskData.value.isSuccess();
  }

  bool isStartTaskLoading() {
    return startTaskData.value.isLoading();
  }

  bool isStartTaskError() {
    return startTaskData.value.isError();
  }
}
