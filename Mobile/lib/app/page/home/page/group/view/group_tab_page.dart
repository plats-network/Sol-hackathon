import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/check_in_list/widgets/check_in_list_shimmer_widget.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/page/home/page/group/controller/group_controller.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/spacer/assets_spacer.dart';
import 'package:plat_app/app/page/home/page/group/widgets/group_card.dart';
import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
import 'package:plat_app/app/page/home/page/setting/controller/setting_controller.dart';
import 'package:plat_app/app/page/home/widgets/sticky_sliver_appbar.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class GroupTabPage extends StatefulWidget {
  const GroupTabPage({Key? key}) : super(key: key);

  @override
  State<GroupTabPage> createState() => _GroupTabPageState();
}

class _GroupTabPageState extends State<GroupTabPage> {
  final AppNotificationController appNotificationController = Get.find();
  final SettingController settingController = Get.find();
  final HomeTabController homeTabController = Get.find();
  final ScrollController scrollController = ScrollController();
  final GroupController groupController = Get.find();
  final RxBool _shouldShowFloatingButton = false.obs;

  void _loadMore() async {
    if (groupController.currentPage.value < groupController.totalPage.value &&
        !groupController.isGroupListLoading()) {
      groupController.loadMoreGroups(groupController.currentPage.value + 1);
    }
  }

  @override
  void initState() {
    super.initState();
    if (groupController.isGroupInit.value != true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        groupController.fetchAllGroup();
        groupController.fetchAllMyGroup();
        groupController.loadMoreGroups(1);
        groupController.loadMoreMyGroups(1);
        groupController.isGroupInit.value = true;
      });
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - dimen200) {
        _loadMore();
      }
      if (scrollController.offset > 0) {
        _shouldShowFloatingButton.value = true;
      } else {
        _shouldShowFloatingButton.value = false;
      }
    });
  }

  // @override
  // void didUpdateWidget(GroupTabPage oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   groupController.fetchAllGroup();
  //   groupController.fetchAllMyGroup();
  //   groupController.loadMoreGroups(1);
  //   groupController.loadMoreMyGroups(1);
  // }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          floatingActionButton: Obx(() => AnimatedOpacity(
                opacity: _shouldShowFloatingButton.value ? 1 : 0,
                duration: const Duration(milliseconds: 100),
                child: InkWell(
                  borderRadius: border80,
                  onTap: () {
                    scrollController.animateTo(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  child: Container(
                    width: dimen40,
                    height: dimen40,
                    decoration: BoxDecoration(
                      borderRadius: border80,
                      color: colorWhite,
                      boxShadow: [
                        BoxShadow(
                          color: colorBlack.withOpacity(0.24),
                          offset: const Offset(dimen0, dimen2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    child: Image.asset(getAssetImage(AssetImagePath.arrow_up)),
                  ),
                ),
              )),
          backgroundColor: colorBackground,
          body: CommonAppBarPage(
            title: 'groups'.tr,
            child: RefreshIndicator(
              displacement: dimen100,
              backgroundColor: Colors.white,
              color: colorPrimary,
              strokeWidth: dimen3,
              triggerMode: RefreshIndicatorTriggerMode.onEdge,
              onRefresh: () async {
                groupController.fetchAllGroup();
                groupController.fetchAllMyGroup();
              },
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                      child: Container(
                          margin: const EdgeInsets.symmetric(vertical: dimen16),
                          child: const AppSpacer())),
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        groupController.myGroups.isNotEmpty
                            ? Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: dimen16,
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'my_group'.tr,
                                          style: text16_32302D_700,
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            groupController.loadMoreMyGroups(1);
                                            Get.toNamed(Routes.myGroupList);
                                          },
                                          child: Text('see_more'.tr,
                                              style: text14_177FE2_400),
                                        ),
                                      ],
                                    ),
                                  ),
                                  verticalSpace8,
                                  Container(
                                    color: colorWhite,
                                    height: dimen80,
                                    width: double.infinity,
                                    child: ListView.separated(
                                      clipBehavior: Clip.none,
                                      itemBuilder: (context, index) => Container(
                                        margin: EdgeInsets.only(
                                          left: index == 0 ? dimen16 : dimen0,
                                          right: index ==
                                                  groupController
                                                          .myGroups.length -
                                                      1
                                              ? dimen16
                                              : dimen0,
                                        ),
                                        padding: const EdgeInsets.only(
                                          // left: dimen16,
                                          top: dimen16,
                                          bottom: dimen16,
                                        ),
                                        width: dimen50,
                                        height: dimen50,
                                        child: groupController
                                                .isMyGroupListLoading()
                                            ? AppShimmer(
                                                height: dimen40,
                                                width: dimen40,
                                                cornerRadius: 50)
                                            : Container(
                                                child: itemMyGroups(
                                                  urlImage: groupController
                                                          .myGroups[index]
                                                          .avatar_url ??
                                                      '',
                                                  onTap: () => Get.toNamed(
                                                      Routes.groupDetail,
                                                      arguments: {
                                                        'group': groupController
                                                            .myGroups[index],
                                                      }),
                                                ),
                                              ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          horizontalSpace16,
                                      itemCount: groupController.myGroups.length,
                                      scrollDirection: Axis.horizontal,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        verticalSpace16,
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                            horizontal: dimen16,
                          ),
                          child: Text(
                            'groups'.tr,
                            style: text16_32302D_700,
                          ),
                        ),
                        verticalSpace16,
                        groupController.isGroupListLoading()
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
                                      itemBuilder: (context, index) => Container(
                                        width: context.width,
                                        constraints: const BoxConstraints(
                                            // maxHeight: dimen161,
                                            ),
                                        child: GroupCard(
                                          onTap: () => Get.toNamed(
                                              Routes.groupDetail,
                                              arguments: {
                                                'group':
                                                    groupController.groups[index],
                                              }),
                                          maxDescriptionLines: 2,
                                          infoPadding: const EdgeInsets.symmetric(
                                            horizontal: dimen16,
                                            vertical: dimen6,
                                          ),
                                          groupList:
                                              groupController.groups[index],
                                          group: {
                                            'telegram': groupController
                                                    .groups[index].telegram_url ??
                                                '',
                                            'discord': groupController
                                                    .groups[index].discord_url ??
                                                '',
                                            'twitter': groupController
                                                    .groups[index].twitter_url ??
                                                '',
                                            'instagram': groupController
                                                    .groups[index]
                                                    .instagram_url ??
                                                '',
                                            'youtube': groupController
                                                    .groups[index].youtube_url ??
                                                '',
                                            'facebook': groupController
                                                    .groups[index].facebook_url ??
                                                '',
                                          },
                                        ),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          verticalSpace16,
                                      itemCount: groupController.groups.length,
                                    ),
                                  )
                                : const Center(
                                    child: CircularProgressIndicator()),
                        groupController.isGroupListLoading() &&
                                groupController.currentPage.value == 0
                            ? const CheckInListShimmerWidget()
                            : groupController.isGroupListLoading() &&
                                    groupController.currentPage.value > dimen0
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
                                groupController.currentPage.value ==
                                    groupController.totalPage.value
                            ? Container(
                                width: double.infinity,
                                padding: const EdgeInsets.only(top: dimen24),
                                child: Text(
                                  'no_more_data'.tr,
                                  textAlign: TextAlign.center,
                                ))
                            : const SizedBox.shrink(),
                        verticalSpace32,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget itemMyGroups({required String urlImage, final VoidCallback? onTap}) =>
      InkWell(
        onTap: onTap,
        child: AppCachedImage(
          imageUrl: urlImage,
          width: dimen50,
          height: dimen50,
          cornerRadius: dimen80,
          backgroundColor: colorWhite,
        ),
      );
}
