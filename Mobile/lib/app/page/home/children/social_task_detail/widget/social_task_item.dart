import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/controller/social_task_detail_controller.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/model/social_task_detail_response.dart';
import 'package:plat_app/app/page/home/children/task_detail/widgets/location_item.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/base/component/snackbar/getx_default_snack_bar.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class SocialTaskItem extends StatefulWidget {
  final bool expanded;
  final bool isDone;
  final VoidCallback? onToggleExpandedTap;
  final Future<void> Function()? onActionTap;
  final VoidCallback? onPostSubmitTap;
  final bool? isActionClick;
  final TaskCheckIn? taskCheckIn;
  final TaskSocials? taskSocials;
  final TaskEvents? taskEvents;
  final String? taskId;
  final String? jobId;
  final Jobs? jobs;
  final int? index;
  final bool? showPrizeOnDoneTask;

  const SocialTaskItem({
    Key? key,
    this.expanded = false,
    this.isDone = false,
    this.taskCheckIn,
    this.taskSocials,
    this.taskEvents,
    this.jobs,
    this.jobId,
    this.taskId,
    this.onToggleExpandedTap,
    this.onActionTap,
    this.isActionClick = false,
    this.onPostSubmitTap,
    this.index,
    this.showPrizeOnDoneTask = false,
  }) : super(key: key);

  @override
  State<SocialTaskItem> createState() => _SocialTaskItemState();
}

class _SocialTaskItemState extends State<SocialTaskItem>
    with TickerProviderStateMixin {
  final AuthController authController = Get.find();
  final SocialTaskDetailController socialTaskDetailController = Get.find();

  // the circular progress indicator last for n seconds, then it will be replaced by the action button
  final int _progressIndicatorDuration = 15;
  final RxInt _progressIndicatorValue = 0.obs;

  // countdown timer
  Timer? _timer;

  AnimationController? expandController;
  Animation<double>? animation;

  String idJobCheckIn = '';
  bool isDone = false;
  void setIdCheckIn(String id) {
    setState(() {
      idJobCheckIn = id;
    });
  }

  void setIdDone(bool check) {
    setState(() {
      // isDone = check;
    });
  }

  @override
  void initState() {
    super.initState();
    prepareAnimations();
    _runExpandCheck();
  }

  ///Setting up the animation
  void prepareAnimations() {
    expandController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(
      parent: expandController ?? AnimationController(vsync: this),
      curve: Curves.fastOutSlowIn,
    );
  }

  void _runExpandCheck() {
    if (expandController == null) return;

    if (widget.expanded) {
      expandController?.forward();
    } else {
      expandController?.reverse();
    }
  }

  @override
  void didUpdateWidget(covariant SocialTaskItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    _runExpandCheck();
  }

  @override
  void dispose() {
    _timer?.cancel();
    expandController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isDone || isDone) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: dimen16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(dimen10),
              border: Border.all(width: dimen1, color: color469B59),
              color: color469B59,
            ),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(),
                  child: ColorFiltered(
                    colorFilter:
                        const ColorFilter.mode(colorWhite, BlendMode.srcIn),
                    child: Image.asset(
                      getAssetImage(
                          fetchIconPath(widget.taskSocials?.platform ?? 0)),
                      width: dimen24,
                      height: dimen24,
                    ),
                  ),
                ),
                horizontalSpace16,
                Expanded(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(dimen10),
                          bottomRight: Radius.circular(dimen10),
                        )),
                    padding: const EdgeInsets.symmetric(
                        vertical: dimen12, horizontal: dimen16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Text(
                              widget.taskCheckIn?.name ??
                                  widget.taskSocials?.name ??
                                  '',
                              style: text14_32302D_600,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            ),
                          ),
                        ),
                        Image.asset(
                          getAssetImage(AssetImagePath.check),
                          width: dimen24,
                          height: dimen24,
                          color: color469B59,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (widget.isDone || isDone) ...[
            Row(
              children: [
                Padding(
                    padding:
                        const EdgeInsets.only(bottom: dimen2, left: dimen2),
                    child: RichText(
                      text: TextSpan(
                        text: '${'congratulations_you_have_received'.tr} ',
                        style: text14_32302D_400,
                        children: <TextSpan>[
                          TextSpan(
                            text: widget.taskCheckIn != null
                                ? '${widget.taskCheckIn?.amount}PSP'
                                : '${widget.taskSocials?.amount}PSP',
                            style: text12_32302D_600,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ]
        ],
      );
    }

    final BorderRadius borderRadius = widget.expanded
        ? const BorderRadius.only(
            topLeft: Radius.circular(dimen10),
            topRight: Radius.circular(dimen10))
        : border10;

    final Widget actionButton = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpace12,
          GetBuilder(
              init: socialTaskDetailController,
              builder: (context) {
                if (widget.isActionClick == false) {
                  return Center(
                    child: InkWell(
                      onTap: widget.taskCheckIn != null
                          ? () async {
                              if (socialTaskDetailController
                                      .selectedLocationIndex ==
                                  -1) {
                                GetXDefaultSnackBar.errorSnackBar(
                                  backgroundColor: color654D03,
                                  message:
                                      'Please select the location you want to checkin!',
                                );
                                // showCustomDialog('Warning',
                                //     'Please select the location you want to checkin!');
                              } else {
                                socialTaskDetailController.fetchStartJob(
                                  widget.taskId as String,
                                  idJobCheckIn,
                                  widget.taskCheckIn?.jobType as String,
                                );
                                Future.delayed(const Duration(seconds: 2))
                                    .then((value) {
                                  socialTaskDetailController
                                      .fetchTaskDetail(widget.taskId as String);
                                });
                                setIdDone(true);
                              }
                            }
                          : () {
                              socialTaskDetailController.fetchStartJob(
                                widget.taskId as String,
                                widget.taskSocials?.id as String,
                                widget.taskSocials?.jobType as String,
                              );
                              setIdDone(true);
                            },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: dimen16, vertical: dimen10),
                        decoration: BoxDecoration(
                          color: color1D93E3,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'Start Now',
                          style: text14_white_600,
                        ),
                      ),
                    ),
                  );
                }

                return Obx(() =>
                    (_progressIndicatorValue.value < _progressIndicatorDuration)
                        ? const Center(
                            child: CircularProgressIndicator(
                              strokeWidth: dimen2,
                            ),
                          )
                        : AppButton(
                            title: '${'checking_action'.tr}...',
                            isEnable: false,
                          ));
              })
        ]);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(dimen10),
        border: Border.all(
          width: dimen1,
          color: fetchColor(widget.taskSocials?.platform ?? 0),
        ),
        color: fetchColor(widget.taskSocials?.platform ?? 0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          InkWell(
            onTap: widget.onToggleExpandedTap,
            child: Container(
              height: dimen80,
              padding: const EdgeInsets.symmetric(
                horizontal: dimen16,
              ),
              child: Image.asset(
                getAssetImage(fetchIconPath(widget.taskSocials?.platform ?? 0)),
                width: dimen24,
                height: dimen24,
                color: colorWhite,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(dimen10),
                  bottomRight: Radius.circular(dimen10),
                ),
              ),
              child: Column(
                children: [
                  InkWell(
                    onTap: widget.onToggleExpandedTap,
                    child: Container(
                      padding:
                          const EdgeInsets.only(right: dimen16, left: dimen16),
                      height: dimen80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Text(
                                    widget.taskCheckIn?.name ??
                                        widget.taskSocials?.name ??
                                        widget.taskEvents?.name ??
                                        '',
                                    style: text14_32302D_600,
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  ),
                                ),
                              ),
                              widget.taskSocials?.lock == true
                                  ? Image.asset(
                                      getAssetImage(AssetImagePath.lock),
                                      width: dimen24,
                                      height: dimen24,
                                    )
                                  : const SizedBox(),
                              Image.asset(
                                widget.expanded
                                    ? getAssetImage(
                                        AssetImagePath.arrow_up_outline)
                                    : getAssetImage(
                                        AssetImagePath.arrow_down_outline),
                                width: dimen24,
                                height: dimen24,
                              ),
                            ],
                          ),
                          widget.taskSocials?.lock == true
                              ? const SizedBox.shrink()
                              : Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: dimen8,
                                    vertical: dimen2,
                                  ),
                                  margin: const EdgeInsets.only(top: dimen12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(dimen4),
                                    color: color469B59,
                                  ),
                                  child: Text(
                                    widget.taskCheckIn != null
                                        ? '+ ${widget.taskCheckIn?.amount} PSP'
                                        : '+ ${widget.taskSocials?.amount} PSP',
                                    style: text10_white_600,
                                  ),
                                )
                        ],
                      ),
                    ),
                  ),
                  SizeTransition(
                    sizeFactor: animation ?? const AlwaysStoppedAnimation(0),
                    axisAlignment: dimen1,
                    child: Container(
                      height: widget.expanded ? null : dimen0,
                      decoration: const BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(dimen10)),
                      ),
                      padding: const EdgeInsets.only(
                          left: dimen16, right: dimen16, bottom: dimen20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(
                            thickness: dimen1,
                          ),
                          verticalSpace16,
                          Text(
                            widget.taskCheckIn?.description ??
                                widget.taskSocials?.description ??
                                '',
                            style: text14_625F5C_400,
                          ),
                          verticalSpace16,
                          widget.taskCheckIn != null
                              ? SingleChildScrollView(
                                  child: SizedBox(
                                    height: widget.taskCheckIn?.jobs?.length
                                                as int >=
                                            3
                                        ? 200
                                        : widget.taskCheckIn?.jobs?.length
                                                    as int ==
                                                2
                                            ? 170
                                            : 70,
                                    child: MediaQuery.removePadding(
                                      context: context,
                                      removeTop: true,
                                      removeBottom: true,
                                      child: RawScrollbar(
                                        controller: ScrollController(),
                                        // thumbVisibility: true,
                                        // interactive: true,
                                        thumbColor: color625F5C,
                                        radius: const Radius.circular(8),
                                        thickness: dimen4,
                                        crossAxisMargin: 1,
                                        child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              verticalSpace16,
                                          itemCount: widget
                                                  .taskCheckIn?.jobs?.length ??
                                              0,
                                          shrinkWrap: true,
                                          physics: widget.taskCheckIn?.jobs
                                                      ?.length as int >=
                                                  3
                                              ? const ClampingScrollPhysics()
                                              : widget.taskCheckIn?.jobs?.length
                                                          as int ==
                                                      2
                                                  ? const NeverScrollableScrollPhysics()
                                                  : const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) => Obx(
                                            () => LocationItem(
                                                name: widget.taskCheckIn
                                                        ?.jobs?[index].name ??
                                                    '',
                                                address: widget
                                                        .taskCheckIn
                                                        ?.jobs?[index]
                                                        .address ??
                                                    '',
                                                isActive: socialTaskDetailController
                                                        .selectedLocationIndex ==
                                                    index,
                                                onTap: () {
                                                  socialTaskDetailController
                                                      .setSelectedLocationIndex(
                                                          index);

                                                  setIdCheckIn(widget
                                                      .taskCheckIn
                                                      ?.jobs?[index]
                                                      .id as String);
                                                }),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : const SizedBox(),
                          verticalSpace10,
                          actionButton
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String fetchIconPath(num platform) {
    switch (platform) {
      case 1:
        return AssetImagePath.twitter;
      case 2:
        return AssetImagePath.facebook;
      case 3:
        return AssetImagePath.telegram;
      case 4:
        return AssetImagePath.instagram_black;
      case 5:
        return AssetImagePath.youtube;
      case 6:
        return AssetImagePath.discord;
      default:
        return AssetImagePath.location;
    }
  }

  Color fetchColor(num platform) {
    switch (platform) {
      case 1:
        return color1DA5F2;
      case 2:
        return color1D93E3;
      case 3:
        return color30A1DB;
      case 4:
        return colorDA656A;
      case 5:
        return colorF20200;
      case 6:
        return color5260E6;
      default:
        return color3F959F;
    }
  }
}
