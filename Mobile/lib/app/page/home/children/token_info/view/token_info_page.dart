import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/token_info/controller/token_info_controller.dart';
import 'package:plat_app/app/page/home/children/token_info/controller/token_info_datasource.dart';
import 'package:plat_app/app/page/home/children/token_info/widgets/transaction_item.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class TokenInfoPage extends StatefulWidget {
  const TokenInfoPage({Key? key}) : super(key: key);

  @override
  State<TokenInfoPage> createState() => _TokenInfoPageState();
}

class _TokenInfoPageState extends State<TokenInfoPage> {
  final TokenInfoController controller = Get.find();
  final TextEditingController _searchController = TextEditingController();
  final DraggableScrollableController scrollController =
      DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    const iconSize = dimen32;
    const transactions = mockTransactionHistory;

    final Widget body = Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(dimen32)),
        color: colorWhite,
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: dimen16, vertical: 32),
        height: context.height,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('history'.tr, style: text18_32302D_700),
                Container(
                  height: dimen32,
                  width: dimen71,
                  decoration: BoxDecoration(
                    border: Border.all(color: colorE4E1E1),
                    borderRadius: border50,
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: dimen12, vertical: dimen8),
                    child: Row(children: [
                      Text('all'.tr, style: text12_32302D_600),
                      horizontalSpace8,
                      Image.asset(getAssetImage(AssetImagePath.arrow_down),
                          width: dimen20, height: dimen20)
                    ]),
                  ),
                )
              ],
            ),
            verticalSpace24,
            transactions.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      // shrinkWrap: true,
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        return TransactionItem(
                          text: transactions[index]['title'].toString(),
                          time: transactions[index]['time'].toString(),
                          value: '',
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          verticalSpace20,
                    ),
                  )
                : Column(children: [
                    verticalSpace32,
                    Image.asset(getAssetImage(AssetImagePath.no_transactions),
                        width: dimen180, height: dimen150),
                    verticalSpace16,
                    Text('no_transactions_in_your_history_yet'.tr,
                        style: text14_625F5C_400),
                  ])
          ],
        ),
      ),
    );

    return CommonAppPage(
      backgroundColor: color469B59,
      hasSafeAreaBottom: false,
      children: [
        Column(
          children: [
            Column(
              children: [
                verticalSpace26,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(clipBehavior: Clip.none, children: [
                      Text(assetsInfo['name'] ?? '', style: text28_white_700),
                      Positioned(
                          right: -iconSize - dimen8,
                          child: Image.asset(
                              getAssetImage(AssetImagePath.ethereum),
                              width: iconSize,
                              height: iconSize))
                    ]),
                  ],
                ),
              ],
            ),
            Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('balance'.tr, style: text16_white_400),
                  horizontalSpace8,
                  Image.asset(getAssetImage(AssetImagePath.eye_white),
                      width: dimen24, height: dimen24),
                ],
              ),
              verticalSpace4,
              Text('\$ ${assetsInfo['balance']!}', style: text28_white_700),
              verticalSpace4,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('≈ ${assetsInfo['approx']!}', style: text16_white_400),
                ],
              ),
              verticalSpace16,
              Container(
                margin: EdgeInsets.symmetric(horizontal: dimen16),
                child: AppButton(
                  title: 'exchange_to_usdt_now'.tr,
                  isPrimaryStyle: false,
                ),
              ),
              verticalSpace16,
              Container(
                margin: EdgeInsets.symmetric(horizontal: dimen16),
                child: Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        title: 'claim_to_plats_wallet'.tr,
                        backgroundColor: colorTransparent,
                        border: Border.all(color: colorA2CCF3),
                        horizontalPadding: dimen8,
                      ),
                    ),
                    horizontalSpace8,
                    Expanded(
                      child: AppButton(
                        title: 'donate_to_friend'.tr,
                        backgroundColor: colorTransparent,
                        border: Border.all(color: colorA2CCF3),
                        horizontalPadding: dimen8,
                      ),
                    )
                  ],
                ),
              ),
              verticalSpace40,
            ]),
          ],
        ),
        // DraggableScrollableSheet(

        //   controller: scrollController,
        //   builder: (context, scrollController) =>
        //       SingleChildScrollView(controller: scrollController, child: body),
        //   // snapSizes: const [0.5, 0.8],
        //   // snap: true,
        //   // expand: true,
        //   minChildSize: 0.63,
        //   initialChildSize: 0.63,
        //   // maxChildSize: 0.90,
        // ),
      ],
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final Widget headerTitle;

  Delegate(this.backgroundColor, this.headerTitle);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: headerTitle,
    );
  }

  @override
  double get maxExtent => 9999;

  @override
  double get minExtent => 0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
