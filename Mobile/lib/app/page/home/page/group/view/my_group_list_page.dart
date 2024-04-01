import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/check_in_list/widgets/check_in_list_shimmer_widget.dart';
import 'package:plat_app/app/page/home/page/group/controller/group_controller.dart';
import 'package:plat_app/app/page/home/page/group/widgets/group_card.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class MyGroupPage extends StatefulWidget {
  const MyGroupPage({Key? key}) : super(key: key);

  @override
  MyGroupPageState createState() => MyGroupPageState();
}

class MyGroupPageState extends State<MyGroupPage>
    with TickerProviderStateMixin {
  final GroupController groupController = Get.find();
  final ScrollController scrollController = ScrollController();

  void _loadMore() async {
    if (groupController.currentMyGroupPage.value <
            groupController.totalMyGroupPage.value &&
        !groupController.isMyGroupListLoading()) {
      groupController
          .loadMoreMyGroups(groupController.currentMyGroupPage.value + 1);
    }
  }

  @override
  void initState() {
    super.initState();
    if (groupController.isGroupInit.value != true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        groupController.fetchAllMyGroup();
        groupController.loadMoreMyGroups(1);
        groupController.isGroupInit.value = true;
      });
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - dimen200) {
        _loadMore();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
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
              groupController.loadMoreMyGroups(
                  groupController.currentMyGroupPage.value + 1);
            },
            child: Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  controller: scrollController,
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
                              'my_group'.tr,
                              style: text18_32302D_700,
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
                            groupController.isMyGroupListLoading()
                                ? const CheckInListShimmerWidget()
                                : groupController.isGroupListSuccess()
                                    ? Container(
                                        color: colorBackground,
                                        margin: const EdgeInsets.symmetric(
                                          horizontal: dimen16,
                                        ),
                                        child: ListView.separated(
                                          clipBehavior: Clip.none,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              Container(
                                            width: context.width,
                                            constraints: const BoxConstraints(
                                                // maxHeight: dimen161,
                                                ),
                                            child: GroupCard(
                                              onTap: () => Get.toNamed(
                                                  Routes.groupDetail,
                                                  arguments: {
                                                    'group': groupController
                                                        .myGroups[index],
                                                  }),
                                              maxDescriptionLines: 2,
                                              infoPadding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: dimen16,
                                                vertical: dimen6,
                                              ),
                                              groupList: groupController
                                                  .myGroups[index],
                                              group: {
                                                'telegram': groupController
                                                        .myGroups[index]
                                                        .telegram_url ??
                                                    '',
                                                'discord': groupController
                                                        .myGroups[index]
                                                        .discord_url ??
                                                    '',
                                                'twitter': groupController
                                                        .myGroups[index]
                                                        .twitter_url ??
                                                    '',
                                                'instagram': groupController
                                                        .myGroups[index]
                                                        .instagram_url ??
                                                    '',
                                                'youtube': groupController
                                                        .myGroups[index]
                                                        .youtube_url ??
                                                    '',
                                                'facebook': groupController
                                                        .myGroups[index]
                                                        .facebook_url ??
                                                    '',
                                              },
                                            ),
                                          ),
                                          separatorBuilder: (context, index) =>
                                              verticalSpace16,
                                          itemCount:
                                              groupController.myGroups.length,
                                        ),
                                      )
                                    : const Center(
                                        child: CircularProgressIndicator()),
                            groupController.isMyGroupListLoading() &&
                                    groupController.currentMyGroupPage.value ==
                                        0
                                ? const CheckInListShimmerWidget()
                                : groupController.isMyGroupListLoading() &&
                                        groupController
                                                .currentMyGroupPage.value >
                                            dimen0
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 10),
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: dimen2,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                            groupController.groups.value.isNotEmpty &&
                                    groupController.currentMyGroupPage.value ==
                                        groupController.totalMyGroupPage.value
                                ? SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      'no_more_data'.tr,
                                      textAlign: TextAlign.center,
                                    ))
                                : const SizedBox.shrink(),
                            verticalSpace32,
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
