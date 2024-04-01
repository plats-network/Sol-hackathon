import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/box_history/controller/box_history_controller.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/voucher_card.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/voucher_card_shimmer.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BoxHistoryPage extends StatefulWidget {
  const BoxHistoryPage({super.key});

  @override
  State<BoxHistoryPage> createState() => _VoucherHistoryPageState();
}

class _VoucherHistoryPageState extends State<BoxHistoryPage>
    with SingleTickerProviderStateMixin {
  final BoxHistoryController boxHistoryController =
      Get.find<BoxHistoryController>();
  @override
  void initState() {
    super.initState();
    boxHistoryController.fetchBoxHistory();
  }

  @override
  Widget build(BuildContext context) {
    final Widget mainTabView = Obx(() => boxHistoryController.boxList.isNotEmpty
        ? ListView.builder(
            itemBuilder: (context, index) => Container(
              margin: const EdgeInsets.only(top: dimen16),
              child: VoucherCard(
                imageUrl: boxHistoryController.boxList[index].icon ?? '',
                middleTitle: boxHistoryController.boxList[index].name ?? '',
                bottomTitle: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                          text: 'expiry_date'.tr, style: text12_9C9896_400),
                      TextSpan(
                          text:
                              boxHistoryController.boxList[index].expired ?? '',
                          style: text12_469B59_400),
                    ],
                  ),
                ),
              ),
            ),
            itemCount: boxHistoryController.boxList.length,
          )
        : boxHistoryController.isBoxHistoryLoading()
            ? ListView.builder(
                itemBuilder: (context, index) => Container(
                  margin: const EdgeInsets.only(top: dimen16),
                  child: const VoucherCardShimmer(),
                ),
                itemCount: 10,
              )
            : Column(children: [
                verticalSpace24,
                Image.asset(
                  getAssetImage(AssetImagePath.no_lock_tray_item),
                  width: dimen180,
                  height: dimen150,
                ),
                verticalSpace16,
                Text('no_box'.tr, style: text14_625F5C_400)
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
                    toolbarHeight: dimen69,
                    title: Container(
                      margin: const EdgeInsets.symmetric(horizontal: dimen16),
                      child: Column(children: [
                        verticalSpace28,
                        Text('history'.tr,
                            style: text28_0E4C88_700,
                            textAlign: TextAlign.center),
                      ]),
                    ),
                  ),
                ]),
            body: mainTabView),
      ],
    );
  }
}
