import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/token/controller/token_controller.dart';
import 'package:plat_app/base/component/spacer/assets_spacer.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/assets_tray_item.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/assets_tray_item_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class TokenScrollView extends StatefulWidget {
  const TokenScrollView({
    Key? key,
    required this.headerNavigator,
  }) : super(key: key);

  final Widget headerNavigator;

  @override
  State<TokenScrollView> createState() => _TokenScrollViewState();
}

class _TokenScrollViewState extends State<TokenScrollView> {
  final tokenController = Get.find<TokenController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    tokenController.fetchNftList();
  }

  @override
  Widget build(BuildContext context) {
    final Widget emptyItemWidget = Container(
      margin: EdgeInsets.only(top: dimen24),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Image.asset(
          getAssetImage(AssetImagePath.no_lock_tray_item),
          width: dimen180,
          height: dimen150,
        ),
        verticalSpace16,
        Text('no_tray_item'.tr, style: text14_625F5C_400)
      ]),
    );

    final shimmerListView = ListView.builder(
      // padding: EdgeInsets.only(left: dimen16, right: dimen16, top: dimen24),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
            padding: const EdgeInsets.symmetric(horizontal: dimen16),
            child: Container(
                padding: const EdgeInsets.symmetric(vertical: dimen24),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: colorE4E1E1,
                      width: 1,
                    ),
                  ),
                ),
                child: AssetsTrayItemShimmer()));
      },
      itemCount: 6,
    );

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - dimen200) {
            tokenController.loadMoreToken();
          }
        }
        return true;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          widget.headerNavigator,
          SliverToBoxAdapter(
            child: Column(
              children: [
                const AppSpacer(),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Obx(() => tokenController.tokenList.isEmpty
                ? tokenController.isTokenListLoading()
                    ? shimmerListView
                    : emptyItemWidget
                : ListView.builder(
                    controller: scrollController,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Material(
                        color: colorWhite,
                        child: InkWell(
                          onTap: () {
                            // Get.toNamed(Routes.tokenInfo);
                          },
                          child: Container(
                            padding:
                                const EdgeInsets.symmetric(horizontal: dimen16),
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: dimen24),
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: colorE4E1E1,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: AssetsTrayItem(
                                image:
                                    tokenController.tokenList[index].icon ?? '',
                                amount: tokenController.tokenList[index].amount
                                    .toString(),
                                approx: '',
                                name:
                                    tokenController.tokenList[index].name ?? '',
                                noBottomRow: true,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: tokenController.tokenList.length,
                  )),
          ),
          Obx(() => SliverToBoxAdapter(
                  child: Column(
                children: [
                  verticalSpace24,
                  if (tokenController.isTokenListLoading()) ...[
                    const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: dimen2,
                    ))
                  ],
                  if (tokenController.currentPage.value ==
                      tokenController.totalPage)
                    SizedBox(
                        width: double.infinity,
                        height: dimen50,
                        child: Text(
                          'no_more_data'.tr,
                          textAlign: TextAlign.center,
                        ))
                ],
              )))
        ],
      ),
    );
  }
}
