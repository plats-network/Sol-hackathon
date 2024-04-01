import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:plat_app/app/page/home/children/check_in_list/controller/check_in_list_controller.dart';
import 'package:plat_app/app/page/home/children/check_in_list/widgets/check_in_list_shimmer_widget.dart';
import 'package:plat_app/app/page/home/children/check_in_list/widgets/check_in_list_widget.dart';
import 'package:plat_app/app/page/home/children/task_perform/controller/task_perform_controller.dart';
import 'package:plat_app/app/page/home/page/home_tab/widgets/widgets.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class CheckInListPage extends StatefulWidget {
  const CheckInListPage({Key? key}) : super(key: key);

  @override
  _CheckInListPageState createState() => _CheckInListPageState();
}

class _CheckInListPageState extends State<CheckInListPage>
    with TickerProviderStateMixin {
  final CheckInListController checkInListController = Get.find();
  final TaskPerformController taskPerformController = Get.find();
  final ScrollController _scrollController = ScrollController();

  void _loadMore() async {
    if (checkInListController.currentPage.value <
            checkInListController.totalPage.value &&
        !checkInListController.isCheckInListLoading()) {
      checkInListController
          .loadMoreCheckInTask(checkInListController.currentPage.value + 1);
    }
  }

  @override
  void initState() {
    checkInListController.loadMoreCheckInTask(1);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - dimen200) {
        _loadMore();
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: RefreshIndicator(
            displacement: dimen100,
            backgroundColor: Colors.white,
            color: colorPrimary,
            strokeWidth: dimen3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              checkInListController.loadMoreCheckInTask(
                  checkInListController.currentPage.value + 1);
            },
            child: Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: _scrollController,
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: colorWhite,
                      title: Row(children: [
                        //back button
                        AppBackButton(
                          onTab: () {
                            Get.back();
                          },
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              'check_in'.tr,
                              style: text24_32302D_700,
                            ),
                          ),
                        ),
                        horizontalSpace48
                      ]),
                      centerTitle: false,
                      floating: true,
                      pinned: false,
                      snap: false,
                    ),
                    taskPerformController.isFetchDoingTaskSuccess()
                        ? SliverPadding(
                            padding: const EdgeInsets.only(top: dimen0),
                            sliver: SliverToBoxAdapter(
                              child: TaskInProgressWidget(
                                  task: taskPerformController
                                      .doingTask.value.data?.data?.task),
                            ),
                          )
                        : const SliverToBoxAdapter(),
                    SliverPadding(
                      padding: const EdgeInsets.only(top: dimen0),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            CheckInListWidget(
                              tasks: checkInListController.tasks,
                            ),
                            checkInListController.isCheckInListLoading() &&
                                    checkInListController.currentPage.value == 0
                                ? const CheckInListShimmerWidget()
                                : checkInListController
                                            .isCheckInListLoading() &&
                                        checkInListController
                                                .currentPage.value >
                                            dimen0
                                    ? const CircularProgressIndicator(
                                        strokeWidth: dimen2,
                                      )
                                    : const SizedBox.shrink(),
                            checkInListController.tasks.value.isNotEmpty &&
                                    checkInListController.currentPage.value ==
                                        checkInListController.totalPage.value
                                ? Container(
                                    width: double.infinity,
                                    color: colorWhite,
                                    height: dimen50,
                                    child: Text(
                                      'no_more_data'.tr,
                                      textAlign: TextAlign.center,
                                    ))
                                : const SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
