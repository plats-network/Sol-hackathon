import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/voucher_history/controller/voucher_history_controller.dart';
import 'package:plat_app/app/page/home/children/voucher_history/widgets/voucher_tab_view.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/voucher_card.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/voucher_card_shimmer.dart';
import 'package:plat_app/app/widgets/app_modern_tabbar.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class VoucherHistoryPage extends StatefulWidget {
  const VoucherHistoryPage({super.key});

  @override
  State<VoucherHistoryPage> createState() => _VoucherHistoryPageState();
}

class _VoucherHistoryPageState extends State<VoucherHistoryPage>
    with SingleTickerProviderStateMixin {
  final VoucherHistoryController voucherHistoryController = Get.find();
  late TabController tabController;
  final menuItemList = ['used'.tr, 'expired'.tr];

  @override
  void initState() {
    super.initState();

    voucherHistoryController.fetchVoucherHistory();
    tabController = TabController(length: menuItemList.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget demoTabView = ListView.builder(
      itemBuilder: (context, index) => Container(
        margin: const EdgeInsets.only(top: dimen24),
        child: VoucherCard(
          imageUrl: 'https://i.imgur.com/rQwjL1u.jpg',
          topTitle: '30shine salon 38 Nguyen Trai Ha Noi',
          middleTitle: 'Tưng bừng mua 3 tặng 1 tại 30shine store',
          bottomTitle: RichText(
            text: const TextSpan(
              children: [
                TextSpan(text: 'Expiry date: ', style: text12_9C9896_400),
                TextSpan(text: '30/12/2021', style: text12_469B59_400),
              ],
            ),
          ),
          onTap: () {
            Get.toNamed(Routes.voucherDetail);
          },
        ),
      ),
      itemCount: 10,
    );

    final Widget shimmerTabView = Container(
      margin: const EdgeInsets.only(top: dimen24),
      child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => Container(
                margin: const EdgeInsets.only(
                  bottom: dimen24,
                ),
                child: VoucherCardShimmer(),
              ),
          itemCount: 5),
    );

    final usedVoucherTabView = Obx(() => VoucherTabView(
          noDataText: 'no_used_gifts'.tr,
          loadMoreVoucher: voucherHistoryController.loadMoreUsedVoucher,
          isVoucherListError: voucherHistoryController.isUsedVoucherListError,
          currentPage: voucherHistoryController.usedVoucherPage.value,
          isVoucherListLoading: voucherHistoryController.isUsedVoucherLoading,
          totalPage: voucherHistoryController.usedVoucherTotalPage,
          voucherList: voucherHistoryController.usedVoucherList,
        ));

    final expiredVoucherTabView = Obx(() => VoucherTabView(
          noDataText: 'no_expired_gifts'.tr,
          loadMoreVoucher: voucherHistoryController.loadMoreExpiredVoucher,
          isVoucherListError:
              voucherHistoryController.isExpiredVoucherListError,
          currentPage: voucherHistoryController.expiredVoucherPage.value,
          isVoucherListLoading:
              voucherHistoryController.isExpiredVoucherLoading,
          totalPage: voucherHistoryController.expiredVoucherTotalPage,
          voucherList: voucherHistoryController.expiredVoucherList,
        ));

    final Widget tabViews =
        Obx(() => TabBarView(controller: tabController, children: [
              voucherHistoryController.usedVoucherPage.value == 0
                  ? shimmerTabView
                  : usedVoucherTabView,
              voucherHistoryController.expiredVoucherPage.value == 0
                  ? shimmerTabView
                  : expiredVoucherTabView,
            ]));

    return CommonAppPage(
      children: [
        NestedScrollView(
            headerSliverBuilder: ((context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: colorBackground,
                    shadowColor: colorTransparent,
                    pinned: true,
                    title: Container(
                      margin: const EdgeInsets.symmetric(horizontal: dimen16),
                      child: Column(children: [
                        verticalSpace28,
                        Row(
                          children: [
                            Expanded(
                              child: Text('history'.tr,
                                  style: text28_0E4C88_700,
                                  textAlign: TextAlign.center),
                            ),
                          ],
                        ),
                      ]),
                    ),
                  ),
                  SliverAppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: colorTransparent,
                      title: AppModernTabBar(
                        controller: tabController,
                        menuItemList: menuItemList,
                      )),
                ]),
            body: tabViews),
        // Obx(() => voucherHistoryController.isVoucherHistoryLoading()
        //     ? FullScreenProgress()
        //     : Container())
      ],
    );
  }
}
