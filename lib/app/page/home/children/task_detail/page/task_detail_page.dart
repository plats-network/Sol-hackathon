import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:plat_app/app/page/home/children/task_detail/controller/task_detail_controller.dart';
import 'package:plat_app/app/page/home/children/task_detail/model/task_detail_response.dart';
import 'package:plat_app/app/page/home/children/task_detail/widgets/collapsible_content.dart';
import 'package:plat_app/app/page/home/children/task_detail/widgets/location_item.dart';
import 'package:plat_app/app/page/home/children/task_detail/widgets/location_item_shimmer.dart';
import 'package:plat_app/app/page/home/children/task_perform/controller/task_perform_controller.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/app/widgets/app_slider.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:plat_app/development.dart';
import 'dart:io' show Platform;

part 'task_detail_page_action.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({Key? key}) : super(key: key);

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final TaskDetailController taskDetailController = Get.find();
  final TaskPerformController taskPerformController = Get.find();
  final Completer<GoogleMapController> googleMapControllerCompleter =
      Completer();
  late GoogleMapController googleMapController;
  final taskId = Get.arguments['task_id'];

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 15,
  );
  late Worker _taskFetchWorker;
  late Worker _doingTaskWorker;

  @override
  void initState() {
    super.initState();
    refetchTaskDetail();
    _doingTaskWorker =
        ever(taskPerformController.doingTask, (NetworkResource data) {
      if (data.isSuccess()) {
        Get.toNamed(Routes.taskPerform);
      }
    });
    _taskFetchWorker = ever(taskDetailController.taskDetailData,
        (NetworkResource<TaskDetailResponse> value) async {
      if (taskDetailController.isTaskDetailFetchSuccess()) {
        animateToLocation(0);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Log event TASK_VIEW
      logEvent(eventName: 'TASK_VIEW', eventParameters: {
        'task_id': taskId,
      });
    });
  }

  @override
  void dispose() {
    _taskFetchWorker.dispose();
    _doingTaskWorker.dispose();
    googleMapController.dispose();
    taskDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget overviewContent = Obx(
      () => CollapsibleContent(
          text:
              (taskDetailController.taskDetail?.description ?? "No description")
                  .replaceAll('\\n', '\n')
                  .trim()),
    );

    Widget startNowBottomSheetBody = SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Obx(
          () => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              taskDetailController
                      .taskDetail
                      ?.locations?[taskDetailController.selectedLocationIndex]
                      .address ??
                  '',
              style: text22_32302D_700,
            ),
            verticalSpace24,
            Row(
              children: [
                Image.asset(getAssetImage(AssetImagePath.navigation_up),
                    width: dimen15, height: dimen17),
                horizontalSpace8,
                // TODO: change later
                Obx(() => Text(
                    taskDetailController.distanceBetween.isNaN
                        ? 'fetching_distance'.tr
                        : '${taskDetailController.distanceBetween.toStringAsFixed(2)}km apart',
                    style: text16_625F5C_400)),
              ],
            ),
            verticalSpace24,
            Row(
              children: [
                Image.asset(getAssetImage(AssetImagePath.time),
                    width: dimen18, height: dimen20),
                horizontalSpace8,
                // TODO: change later
                Text(
                    '${taskDetailController.taskDetail?.duration} ${'minutes'.tr.toLowerCase()}',
                    style: text16_625F5C_400),
              ],
            ),
            verticalSpace24,
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: 'cancel'.tr,
                    onTap: () => Get.back(),
                    isPrimaryStyle: false,
                  ),
                ),
                horizontalSpace8,
                Expanded(
                  child: AppButton(
                    title: 'start_now'.tr,
                    horizontalPadding: dimen4,
                    onTap: onTapStartNow,
                  ),
                )
              ],
            ),
            verticalSpace16,
          ]),
        ));

    final Widget header = Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              taskDetailController.taskDetail?.name ?? '',
              style: text28_32302D_700,
            ),
            verticalSpace8,
            Text(
                taskDetailController.taskDetail?.postBy != null
                    ? '${'by'.tr} ${taskDetailController.taskDetail?.postBy ?? ''}'
                    : '',
                style: text14_9C9896_400),
          ],
        ));

    final Widget taskDetailBody = RefreshIndicator(
      onRefresh: () async {
        if (kDebugMode) {
          print("onRefresh");
        }

        await refetchTaskDetail();
      },
      child: SingleChildScrollView(
        child: Container(
          margin:
              const EdgeInsets.symmetric(horizontal: dimen16, vertical: dimen8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => AppSlider(
                    images: taskDetailController.taskDetail?.galleries
                            ?.map((e) => e.url!)
                            .toList() ??
                        [],
                    label: 'checkin'.tr,
                  )),
              verticalSpace16,
              Container(
                margin: const EdgeInsets.symmetric(horizontal: dimen8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      header,
                      verticalSpace24,
                      Text('overview'.tr, style: text16_32302D_700),
                      verticalSpace8,
                      overviewContent,
                      verticalSpace24,
                      Text('schedule'.tr, style: text16_32302D_700),
                      verticalSpace8,
                      Container(
                        width: double.infinity,
                        height: 200,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: border16,
                        ),
                        child: Obx(
                          () => GoogleMap(
                              myLocationButtonEnabled: false,
                              initialCameraPosition: _initialCameraPosition,
                              // zoomGesturesEnabled: false,
                              scrollGesturesEnabled: false,
                              markers: Set<Marker>.of(
                                  taskDetailController.mapMarkers),
                              onMapCreated: (mapController) {
                                if (!googleMapControllerCompleter.isCompleted) {
                                  googleMapControllerCompleter
                                      .complete(mapController);
                                }

                                googleMapController = mapController;
                              }),
                        ),
                      ),
                      verticalSpace16,
                      Obx(() => RichText(
                            text: TextSpan(
                              text: '${'checkin_help_text'.tr} ',
                              style: text14_32302D_400,
                              children: [
                                TextSpan(
                                    text: '${'branch_list'.tr} ',
                                    style: text14_32302D_600),
                                TextSpan(
                                    text: '${'of'.tr} ',
                                    style: text14_32302D_400),
                                TextSpan(
                                    text: taskDetailController
                                            .taskDetail?.postBy ??
                                        '',
                                    style: text14_32302D_400),
                              ],
                            ),
                          )),
                      verticalSpace16,
                      Obx(() => taskDetailController.isSortingLocation.isTrue
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                SizedBox(
                                  width: dimen20,
                                  height: dimen20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: dimen2,
                                  ),
                                ),
                                // show text: is sorting locations
                              ],
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) =>
                                  verticalSpace16,
                              itemCount: taskDetailController
                                      .taskDetail?.locations?.length ??
                                  0,
                              //sampleCoords.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Obx(
                                () => LocationItem(
                                    name: taskDetailController.taskDetail
                                            ?.locations?[index].name ??
                                        '',
                                    address: taskDetailController.taskDetail
                                            ?.locations?[index].address ??
                                        '',
                                    isActive: taskDetailController
                                            .selectedLocationIndex ==
                                        index,
                                    onTap: () {
                                      taskDetailController
                                          .setSelectedLocationIndex(index);
                                      animateToLocation(index);
                                    }),
                              ),
                            )),
                      verticalSpace88,
                    ]),
              )
            ],
          ),
        ),
      ),
    );

    final Widget taskDetailBodyShimmer = SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: dimen16, vertical: dimen8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmer(
            width: context.width,
            height: context.width,
            cornerRadius: dimen16,
          ),
          verticalSpace16,
          AppShimmer(
            width: context.width * 0.5,
            height: dimen34,
            cornerRadius: dimen8,
          ),
          verticalSpace8,
          AppShimmer(
            width: dimen52,
            height: dimen14,
            cornerRadius: dimen8,
          ),
          verticalSpace24,
          AppShimmer(
            width: context.width * 0.3,
            height: dimen22,
            cornerRadius: dimen8,
          ),
          verticalSpace8,
          AppShimmer(
            width: context.width,
            height: dimen76,
            cornerRadius: dimen8,
          ),
          verticalSpace24,
          AppShimmer(
            width: context.width * 0.3,
            height: dimen22,
            cornerRadius: dimen8,
          ),
          verticalSpace8,
          AppShimmer(
            width: context.width,
            height: 200,
            cornerRadius: dimen16,
          ),
          verticalSpace16,
          AppShimmer(
            width: context.width,
            height: dimen32,
            cornerRadius: dimen8,
          ),
          verticalSpace16,
          ListView.separated(
            separatorBuilder: (context, index) => verticalSpace16,
            itemCount: 4,
            //sampleCoords.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const LocationItemShimmer(),
          ),
          verticalSpace88,
        ],
      ),
    ));

    final positionedBottomSheet = Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        color: colorE8F2FC,
        padding: Platform.isIOS && MediaQuery.of(context).size.height >= 812
            ? EdgeInsets.only(left: dimen24,right: dimen24, top: dimen16, bottom: dimen32)
            : EdgeInsets.symmetric(horizontal: dimen24, vertical: dimen16),
        child: Obx(() => Row(
              children: [
                Container(
                  width: dimen56,
                  height: dimen56,
                  decoration: BoxDecoration(
                    borderRadius: border50,
                    color: colorWhite,
                  ),
                  padding: EdgeInsets.all(dimen9),
                  child: taskDetailController.taskDetail?.rewards?.image != null
                      ? AppCachedImage(
                          imageUrl:
                              taskDetailController.taskDetail?.rewards?.image ??
                                  '',
                          width: dimen56,
                          height: dimen56,
                          cornerRadius: dimen50,
                        )
                      : Container(),
                ),
                horizontalSpace8,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('reward'.tr, style: text14_9C9896_400),
                    // Text('1 Mystery Box', style: text18_0E4C88_700),
                    Text(
                        taskDetailController.taskDetail?.rewards?.name != null
                            // ? '${taskDetailController.taskDetail?.rewards?.amount} ${taskDetailController.taskDetail?.rewards?.name}'
                            ? '${taskDetailController.taskDetail?.rewards?.name}'
                            : '',
                        style: text18_0E4C88_700),
                  ],
                ),
                Expanded(child: Container()),
                Obx(
                  () => AppButton(
                    horizontalPadding: dimen20,
                    title:
                        taskDetailController.taskDetail?.improgressFlag == true
                            ? 'continue'.tr
                            : taskDetailController.taskDetail?.taskDone == true
                                ? 'done'.tr
                                : 'start_now'.tr,
                    isEnable:
                        !(taskDetailController.taskDetail?.taskDone == true),
                    onTap: () async {
                      // If continue, then just navigate to task perform, else show bottomsheet
                      if (taskDetailController.taskDetail?.improgressFlag ==
                          true) {
                        Get.toNamed(Routes.taskPerform);
                      } else {
                        taskDetailController.updateDistanceBetween();
                        GetXDefaultBottomSheet.rawBottomSheet(
                          startNowBottomSheetBody,
                        );
                      }
                    },
                  ),
                ),
              ],
            )),
      ),
    );

    final positionedBottomSheetShimmer = Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          color: colorE8F2FC,
          padding: EdgeInsets.symmetric(horizontal: dimen24, vertical: dimen16),
          child: Row(
            children: [
              AppShimmer(
                width: dimen56,
                height: dimen56,
                cornerRadius: dimen50,
              ),
              horizontalSpace8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(
                    width: dimen52,
                    height: dimen14,
                    cornerRadius: dimen8,
                  ),
                  verticalSpace4,
                  AppShimmer(
                    width: dimen52,
                    height: dimen14,
                    cornerRadius: dimen8,
                  ),
                ],
              ),
              Expanded(child: Container()),
              AppShimmer(
                width: dimen52,
                height: dimen14,
                cornerRadius: dimen8,
              ),
            ],
          ),
        ));

    return CommonAppPage(
      padding: const EdgeInsets.only(left: dimen32, top: dimen24),
      hasSafeAreaBottom: false,
      children: [
        Obx(() => (taskDetailController.isFetchingTaskDetail() ||
                taskDetailController.isStartTaskLoading())
            ? Stack(children: [
                taskDetailBodyShimmer,
                positionedBottomSheetShimmer,
                FullScreenProgress()
              ])
            : Stack(children: [taskDetailBody, positionedBottomSheet])),
      ],
    );
  }

  void onTapStartNow() async {
    // Log event TASK_START_NOW
    logEvent(eventName: 'TASK_START_NOW', eventParameters: {
      'task_id': taskId,
    });

    // TODO: must check for success
    // final isSuccess = await controller.requestPermission();

    if (taskDetailController.taskPerformController.isDoingTask()) {
      if (taskDetailController
              .taskPerformController.doingTask.value.data!.data!.task?.id ==
          taskDetailController.taskDetail?.id) {
        Get.toNamed(Routes.taskPerform);
        return;
      }

      GetXDefaultBottomSheet.warningBottomSheet(
          title: 'start_task_error'.tr,
          text: Obx(() => RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  text: 'task_already_started1'.tr,
                  style: text16_32302D_400,
                  children: [
                    TextSpan(
                        text:
                            '"${taskDetailController.taskPerformController.doingTask.value.data?.data?.task?.name}"',
                        style: text16_32302D_700),
                    TextSpan(
                        text: 'task_already_started2'.tr,
                        style: text16_32302D_400)
                  ]))),
          buttons: [
            Expanded(
              child: AppButton(
                title: 'cancel'.tr,
                isPrimaryStyle: false,
                onTap: () {
                  Get.back();
                  Get.back();
                },
              ),
            ),
            horizontalSpace8,
            Expanded(
              child: AppButton(
                title: 'agree'.tr,
                onTap: () async {
                  Get.back();
                  Get.back();

                  await taskDetailController.startTask(
                      taskId: taskId, force: true);
                  // taskDetailController.taskPerformController.fetchDoingTask();
                  refetchTaskDetail();
                },
              ),
            ),
          ]);

      return;
    }

    await taskDetailController.startTask(taskId: taskId);

    // Hide bottom sheet
    Get.back();

    // taskDetailController.taskPerformController
    //     .fetchDoingTask(isShowError: false);
    refetchTaskDetail();
  }
}
