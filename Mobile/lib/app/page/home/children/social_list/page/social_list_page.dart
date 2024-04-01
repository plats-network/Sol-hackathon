import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:plat_app/app/page/home/children/check_in_list/widgets/check_in_list_shimmer_widget.dart';
import 'package:plat_app/app/page/home/children/social_list/controller/social_list_controller.dart';
import 'package:plat_app/app/page/home/children/social_list/widgets/social_list_widget.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class SocialListPage extends StatefulWidget {
  const SocialListPage({Key? key}) : super(key: key);

  @override
  SocialListPageState createState() => SocialListPageState();
}

class SocialListPageState extends State<SocialListPage>
    with TickerProviderStateMixin {
  final SocialListController socialListController = Get.find();
  final ScrollController _scrollController = ScrollController();

  void _loadMore() async {
    if (socialListController.currentPage.value <
            socialListController.totalPage.value &&
        !socialListController.isSocialListLoading()) {
      socialListController
          .loadMoreSocialTask(socialListController.currentPage.value + 1);
    }
  }

  @override
  void initState() {
    socialListController.loadMoreSocialTask(1);
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
              socialListController.loadMoreSocialTask(
                  socialListController.currentPage.value + 1);
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
                              'social_task'.tr,
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
                    SliverPadding(
                      padding: const EdgeInsets.only(top: dimen0),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            SocialListWidget(
                              tasks: socialListController.tasks,
                            ),
                            socialListController.isSocialListLoading() &&
                                    socialListController.currentPage.value == 0
                                ? const CheckInListShimmerWidget()
                                : socialListController.isSocialListLoading() &&
                                        socialListController.currentPage.value >
                                            dimen0
                                    ? const CircularProgressIndicator(
                                        strokeWidth: dimen2,
                                      )
                                    : const SizedBox.shrink(),
                            socialListController.tasks.isNotEmpty &&
                                    socialListController.currentPage.value ==
                                        socialListController.totalPage.value
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
