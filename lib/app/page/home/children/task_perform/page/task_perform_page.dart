import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:plat_app/app/page/home/children/task_perform/controller/task_perform_controller.dart';
import 'package:plat_app/app/page/home/children/task_perform/model/doing_task_response_extension.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/dialog/getx_default_dialog.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/latlng_util.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:plat_app/development.dart';

part 'task_perform_page_action.dart';

class TaskPerformPage extends StatefulWidget {
  const TaskPerformPage({Key? key}) : super(key: key);

  @override
  State<TaskPerformPage> createState() => _TaskPerformPageState();
}

const PERCENT_COLOR_CHANGE = 0.15;

class _TaskPerformPageState extends State<TaskPerformPage> {
  final Completer<GoogleMapController> googleMapControllerCompleter =
  Completer();
  GoogleMapController? googleMapController;
  final TaskPerformController taskPerformController = Get.find();
  final AppNotificationController appNotificationController = Get.find();

  late Timer _timer;
  final maxTime = 1.obs;
  final timeRemaining = 1.obs;
  final timeRemainingStr = ''.obs;
  final delta = 1;
  final progressPercent = 0.0.obs;
  final progressBackgroundColor = colorE9F4EC.obs;
  final progressColor = color469B59.obs;
  GoogleMapPolyline googleMapPolyline =
  GoogleMapPolyline(apiKey: googleMapApiKey);
  Map<PolylineId, Polyline> _polylines = <PolylineId, Polyline>{};
  int _polylineCount = 1;
  final _doingTaskMarkerIcon = Rx<BitmapDescriptor?>(null);
  final _myLocationMarkerIcon = Rx<BitmapDescriptor?>(null);
  final _markers = Rx<Map<MarkerId, Marker>>({});
  LocationData? myLocation;
  late Worker cancelTaskWorker;
  late Worker fetchDoingTaskWorker;
  final isCheckinButtonEnable = false.obs;

  @override
  void initState() {
    super.initState();
    startTimer();
    taskPerformController.patchCancelOldPolyline();
    fetchDoingTaskWorker =
        ever(taskPerformController.doingTask, (NetworkResource data) {
          if (data.isSuccess()) {
            if (taskPerformController.doingTask.value.data?.data?.timeExpried ==
                true) {
              // Task expired, cancel count down notifications
              appNotificationController.cancelCountDownNotification();
              // Show task time out
              GetXDefaultDialog.alertDialog(
                title: 'task_time_out_title'.tr,
                middleText: 'task_time_out_content'.tr,
                textConfirm: 'close'.tr,
              ).then((value) {
                taskPerformController.patchCancelTask();
              });
            } else {
              // Show doing task notification
              appNotificationController.showDoingTaskNotification();
              // Show route
              updateMarkers();
            }
          }
        });
    cancelTaskWorker =
        ever(taskPerformController.cancelTask, (NetworkResource data) {
          if (data.isSuccess()) {
            Get.offAllNamed(Routes.home);
          }
        });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // taskPerformController.fetchDoingTask();
      await _createDoingTaskMarkerImageFromAsset();
      await _createMyLocationMarkerImageFromAsset();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    fetchDoingTaskWorker.dispose();
    cancelTaskWorker.dispose();
    googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hanoiPosition = CameraPosition(
      target: LatLng(myLocation?.latitude ?? 21.0027393,
          myLocation?.longitude ?? 105.8112054),
      zoom: 10,
    );

    final googleMapWidget = Obx(() {
      return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: hanoiPosition,
        onMapCreated: (GoogleMapController controller) {
          googleMapControllerCompleter.complete(controller);
          googleMapController = controller;
        },
        polylines: Set<Polyline>.of(_polylines.values),
        zoomControlsEnabled: false,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: Set<Marker>.of(_markers.value.values),
      );
    });

    final timeRemainingWidget = Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('time_remaining'.tr),
            Obx(() {
              return Text(timeRemainingStr.value);
            }),
          ],
        ),
        horizontalSpace16,
        Expanded(
          child: Obx(() {
            return LinearPercentIndicator(
              lineHeight: dimen12,
              percent: progressPercent.value,
              backgroundColor: progressBackgroundColor.value,
              progressColor: progressColor.value,
              barRadius: Radius.circular(dimen12),
            );
          }),
        )
      ],
    );

    final checkinWidget = Container(
      decoration: BoxDecoration(color: colorE9F4EC, borderRadius: border18),
      padding: EdgeInsets.symmetric(horizontal: dimen16, vertical: dimen13),
      child: Row(
        children: [
          Image(
            image: AssetImage(getAssetImage(AssetImagePath.icon_checkin)),
            width: dimen32,
          ),
          horizontalSpace8,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskPerformController
                      .doingTask.value.data?.data?.taskLocations?.name ??
                      '',
                  style: text14_327140_600,
                ),
                Text(
                  taskPerformController
                      .doingTask.value.data?.data?.taskLocations?.address ??
                      '',
                  style: text10_625F5C_400,
                ),
              ],
            ),
          )
        ],
      ),
    );

    final buttonWidget = Row(
      children: [
        Expanded(
            child: AppButton(
              title: 'cancel'.tr,
              isPrimaryStyle: false,
              onTap: () {
                showCancelTaskBottomSheet();
              },
            )),
        horizontalSpace16,
        Expanded(
            child: Obx(() {
              return AppButton(
                title: 'check_in'.tr,
                isEnable: isCheckinButtonEnable.value,
                onTap: () {
                  showCheckValidPhoto();
                },
              );
            })),
      ],
    );

    final bottomSheetWidget = Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.all(dimen16),
        padding: EdgeInsets.all(dimen16),
        decoration: BoxDecoration(color: colorWhite, borderRadius: border24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            timeRemainingWidget,
            verticalSpace16,
            checkinWidget,
            verticalSpace16,
            buttonWidget,
          ],
        ),
      ),
    );

    return CommonAppPage(children: [
      googleMapWidget,
      bottomSheetWidget,
      devDebugMockWidget(Positioned(
          right: 0,
          bottom: 0,
          child: TextButton(
              onPressed: () {
                showCheckValidPhoto();
              },
              child: Text('Force checkin')))),
      Obx(() =>
      (taskPerformController.isFetchingDoingTask() ||
          taskPerformController.isCancelingTask())
          ? FullScreenProgress()
          : Container())
    ]);
  }
}
