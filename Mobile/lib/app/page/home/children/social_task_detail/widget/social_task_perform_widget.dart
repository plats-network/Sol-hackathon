import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/controller/social_task_detail_controller.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/widget/social_task_item.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/base/component/snackbar/getx_default_snack_bar.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:plat_app/development.dart';

class SocialTaskPerformWidget extends StatefulWidget {
  const SocialTaskPerformWidget({super.key});

  @override
  State<SocialTaskPerformWidget> createState() =>
      _SocialTaskPerformWidgetState();
}

class _SocialTaskPerformWidgetState extends State<SocialTaskPerformWidget> {
  final SocialTaskDetailController socialTaskDetailController = Get.find();

  // is collapsed
  RxList<bool> isExpanded = <bool>[].obs;
  RxList<bool> isExpandedSocialTask = <bool>[].obs;
  RxList<bool> isActionClick = <bool>[].obs;
  RxList<bool> isActionClickSocialTask = <bool>[].obs;
  late Worker _jobWorker;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((Duration timeStamp) {
      // init isExpaded
      isExpanded.clear();
      isExpandedSocialTask.clear();
      isActionClick.clear();
      isActionClickSocialTask.clear();

      if (socialTaskDetailController.taskDetail?.taskCheckIn != null) {
        isExpanded.value = List<bool>.filled(
          socialTaskDetailController.taskDetail?.taskCheckIn?.length ?? 0,
          false,
        );
        isActionClick.value = List<bool>.filled(
          socialTaskDetailController.taskDetail?.taskCheckIn?.length ?? 0,
          false,
        );
      }
      if (socialTaskDetailController.taskDetail?.taskSocial != null) {
        isExpandedSocialTask.value = List<bool>.filled(
          socialTaskDetailController.taskDetail?.taskSocial?.length ?? 0,
          false,
        );
        isActionClickSocialTask.value = List<bool>.filled(
          socialTaskDetailController.taskDetail?.taskSocial?.length ?? 0,
          false,
        );
      }

      // socialTaskDetailController.fetchSocialAccount();
    });
    _jobWorker =
        ever(socialTaskDetailController.submitStartJob, (NetworkResource data) {
      if (data.isSuccess()) {
        GetXDefaultSnackBar.successSnackBar(
          message: data.data.data['message'].toString() ?? 'success'.tr,
        );
      } else if (data.isError()) {
        // GetXDefaultSnackBar.errorSnackBar(
        //   message: data.message ?? 'error'.tr,
        //   backgroundColor: colorFFB800,
        // );
      }
    });
  }

  @override
  void dispose() {
    _jobWorker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget schedule = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        verticalSpace8,
        Text('schedule'.tr, style: text18_32302D_700),
        verticalSpace8,
        Obx(
          () => ListView.separated(
            padding: const EdgeInsets.only(bottom: dimen8),
            itemBuilder: (context, index) {
              return GetBuilder(
                init: socialTaskDetailController,
                builder: (controller) {
                  final taskCheckIn = socialTaskDetailController
                      .taskDetail?.taskCheckIn?[index];
                  final isDone = socialTaskDetailController
                      .taskDetail?.taskCheckIn?[index].jobStatus;
                  // final isDone = social?.action?.status == true;
                  final isExpand =
                      isExpanded.length > index ? isExpanded[index] : false;

                  return IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => SocialTaskItem(
                              taskId: socialTaskDetailController.taskDetail?.id,
                              jobId: socialTaskDetailController
                                  .taskDetail?.taskCheckIn?[index].id,
                              taskCheckIn: taskCheckIn,
                              expanded: isExpanded.length > index &&
                                  isExpanded[index] == true,
                              isDone: isDone as bool,
                              showPrizeOnDoneTask: true,
                              onToggleExpandedTap: () {
                                isExpanded[index] = !isExpanded[index];
                              },
                              onActionTap: () async {
                                // final url = taskCheckIn?.urlIntent ?? '';

                                isActionClick[index] = true;
                                // await launchSocial(url, url);
                              },
                              onPostSubmitTap: () {
                                isActionClick[index] = false;
                              },
                              isActionClick: isActionClick.length > index
                                  ? isActionClick[index]
                                  : false,
                              index: index,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => verticalSpace8,
            itemCount:
                socialTaskDetailController.taskDetail?.taskCheckIn?.length ?? 0,
          ),
        ),
        Obx(
          () => ListView.separated(
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return GetBuilder(
                init: socialTaskDetailController,
                builder: (controller) {
                  final taskSocial =
                      socialTaskDetailController.taskDetail?.taskSocial?[index];
                  final isDone = socialTaskDetailController
                      .taskDetail?.taskSocial?[index].jobStatus;
                  final isExpand = isExpandedSocialTask.length > index
                      ? isExpandedSocialTask[index]
                      : false;

                  return IntrinsicHeight(
                    child: Row(
                      children: [
                        Expanded(
                          child: Obx(
                            () => SocialTaskItem(
                              taskId: socialTaskDetailController.taskDetail?.id,
                              taskSocials: taskSocial,
                              expanded: isExpandedSocialTask.length > index &&
                                  isExpandedSocialTask[index] == true,
                              isDone: isDone as bool,
                              showPrizeOnDoneTask: true,
                              onToggleExpandedTap: () {
                                if (taskSocial?.lock == true) {
                                  isExpandedSocialTask[index] =
                                      isExpandedSocialTask[index];
                                } else {
                                  isExpandedSocialTask[index] =
                                      !isExpandedSocialTask[index];
                                }
                              },
                              onActionTap: () async {
                                // final url = taskCheckIn?.urlIntent ?? '';

                                isActionClickSocialTask[index] = true;
                                // await launchSocial(url, url);
                              },
                              onPostSubmitTap: () {
                                isActionClickSocialTask[index] = false;
                              },
                              isActionClick:
                                  isActionClickSocialTask.length > index
                                      ? isActionClickSocialTask[index]
                                      : false,
                              index: index,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => verticalSpace8,
            itemCount:
                socialTaskDetailController.taskDetail?.taskSocial?.length ?? 0,
          ),
        ),
        debugMockWidget(Column(
          children: [
            verticalSpace20,
            AppButton(
              title: "Debug: Go to task reward page",
              onTap: () {
                Get.toNamed(Routes.taskReward, arguments: {
                  // 'reward': socialTaskDetailController.taskDetail?.rewards
                });
              },
            ),
          ],
        )),
        verticalSpace80,
      ],
    );
    return schedule;
  }
}
