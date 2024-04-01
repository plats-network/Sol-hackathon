import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/voucher_history/widgets/voucher_tab_view.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/controller/gift_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/widgets/gift_header.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/voucher_card.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/voucher_card_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class GiftScrollView extends StatefulWidget {
  const GiftScrollView({
    Key? key,
    required this.headerNavigator,
  }) : super(key: key);

  final Widget headerNavigator;

  @override
  State<GiftScrollView> createState() => _GiftScrollViewState();
}

class _GiftScrollViewState extends State<GiftScrollView> {
  final GiftController giftController = Get.find();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    giftController.fetchGiftList();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - dimen200) {
            if (giftController.totalPage != null &&
                giftController.currentPage.value < giftController.totalPage! &&
                !giftController.isGiftListLoading()) {
              giftController.loadMoreGift();
            }
          }
        }
        return true;
      },
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          widget.headerNavigator,
          SliverToBoxAdapter(
            child: VoucherHeader(),
          ),
          Obx(() => giftController.currentPage.value == 0
              ? SliverToBoxAdapter(
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
                )
              : giftController.isGiftListError()
                  ? SliverToBoxAdapter(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Image.asset(
                            getAssetImage(AssetImagePath.no_lock_tray_item),
                            width: dimen180,
                            height: dimen150,
                          ),
                          verticalSpace16,
                          Text('no_gift'.tr, style: text14_625F5C_400)
                        ]))
                  : Obx(() => SliverToBoxAdapter(
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemBuilder: (context, index) {
                            if (index == giftController.giftList.length) {
                              if (giftController.isGiftListLoading()) {
                                return Center(
                                    child: CircularProgressIndicator(
                                  strokeWidth: dimen2,
                                ));
                              }
                              if (giftController.currentPage.value ==
                                  giftController.totalPage) {
                                return SizedBox(
                                    width: double.infinity,
                                    height: dimen50,
                                    child: Text(
                                      'no_more_data'.tr,
                                      textAlign: TextAlign.center,
                                    ));
                              }
                              return Container(
                                height: dimen24,
                              );
                            }

                            return giftController.giftList[index].isOpen !=
                                        null &&
                                    giftController.giftList[index].isOpen! ==
                                        false
                                ? Container(
                                    margin: const EdgeInsets.only(
                                      bottom: dimen24,
                                    ),
                                    child: VoucherCard(
                                      imageUrl:
                                          'https://i.imgur.com/RuflStM.png',
                                      middleTitle: 'open_the_box_now'.tr,
                                      bottomTitle: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'expiry_date'.tr,
                                              style: text12_9C9896_400,
                                            ),
                                            TextSpan(
                                              text: giftController.giftList
                                                      .value[index].expired ??
                                                  '',
                                              style: text12_469B59_400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        logEvent(
                                            eventName: 'GIFT_BOX_DETAIL_VIEW',
                                            eventParameters: {
                                              'box_id': giftController
                                                  .giftList[index].id
                                            });

                                        Get.toNamed(Routes.boxDetail,
                                            arguments: {
                                              'box_id': giftController
                                                  .giftList[index].id
                                            });
                                      },
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(
                                      bottom: dimen24,
                                    ),
                                    child: VoucherCard(
                                      imageUrl: giftController
                                              .giftList[index].urlImage ??
                                          '',
                                      topTitle: giftController
                                              .giftList[index].address ??
                                          '',
                                      middleTitle:
                                          giftController.giftList[index].name ??
                                              '',
                                      bottomTitle: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: 'expiry_date'.tr,
                                              style: text12_9C9896_400,
                                            ),
                                            TextSpan(
                                              text: giftController.giftList
                                                      .value[index].expired ??
                                                  '',
                                              style: text12_469B59_400,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        logEvent(
                                            eventName:
                                                'GIFT_VOUCHER_DETAIL_VIEW',
                                            eventParameters: {
                                              'voucher_id': giftController
                                                  .giftList[index].id
                                            });
                                        Get.toNamed(Routes.voucherDetail,
                                            arguments: {
                                              'voucher_id': giftController
                                                      .giftList
                                                      .value[index]
                                                      .id ??
                                                  '',
                                            });
                                      },
                                    ),
                                  );
                          },
                          itemCount: giftController.giftList.length + 1,
                        ),
                      )))
        ],
      ),
    );
  }
}
