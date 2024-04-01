import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/voucher_history/controller/voucher_history_controller.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/voucher_card.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/model/gift_list_response.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class VoucherTabView extends StatelessWidget {
  const VoucherTabView({
    Key? key,
    required this.isVoucherListError,
    required this.isVoucherListLoading,
    required this.voucherList,
    required this.currentPage,
    required this.totalPage,
    required this.noDataText,
    required this.loadMoreVoucher,
  }) : super(key: key);

  final Function loadMoreVoucher;
  final Function isVoucherListError;
  final Function isVoucherListLoading;
  final int currentPage;
  final int? totalPage;
  final List<Data> voucherList;
  final String noDataText;

  @override
  Widget build(BuildContext context) {
    return Obx(() => isVoucherListError()
        ? Column(
            children: [
              verticalSpace24,
              Image.asset(
                getAssetImage(AssetImagePath.no_lock_tray_item),
                width: dimen180,
                height: dimen150,
              ),
              verticalSpace16,
              Text(noDataText, style: text14_625F5C_400)
            ],
          )
        : NotificationListener(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                if (notification.metrics.pixels >=
                    notification.metrics.maxScrollExtent - dimen200) {
                  if (totalPage != null &&
                      currentPage < totalPage! &&
                      !isVoucherListLoading()) {
                    loadMoreVoucher();
                  }
                }
              }
              return true;
            },
            child: CustomScrollView(slivers: [
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(top: dimen24),
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        if (index == voucherList.length) {
                          if (isVoucherListLoading()) {
                            return Center(
                                child: CircularProgressIndicator(
                              strokeWidth: dimen2,
                            ));
                          }
                          if (currentPage == totalPage) {
                            return SizedBox(
                                width: double.infinity,
                                height: dimen50,
                                child: Text(
                                  'no_more_data'.tr,
                                  textAlign: TextAlign.center,
                                ));
                          }
                          return Container();
                        }

                        return Container(
                            margin: const EdgeInsets.only(
                              bottom: dimen24,
                            ),
                            child: VoucherCard(
                              imageUrl: voucherList[index].urlImage ?? '',
                              topTitle: voucherList[index].address ?? '',
                              middleTitle: voucherList[index].name ?? '',
                              bottomTitle: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'expiry_date'.tr,
                                      style: text12_9C9896_400,
                                    ),
                                    TextSpan(
                                      text: voucherList[index].expired ?? '',
                                      style: text12_469B59_400,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                Get.toNamed(Routes.voucherDetail, arguments: {
                                  'voucher_id': voucherList[index].id ?? '',
                                });
                              },
                            ));
                      },
                      itemCount: voucherList.length + 1),
                ),
              ),
            ]),
          ));
  }
}
