import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/nfts/controller/nft_controller.dart';
import 'package:plat_app/base/component/spacer/assets_spacer.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/nft_card.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/nft_card_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class NftScrollView extends StatefulWidget {
  const NftScrollView({
    Key? key,
    required this.headerNavigator,
  }) : super(key: key);

  final Widget headerNavigator;

  @override
  State<NftScrollView> createState() => _NftScrollViewState();
}

class _NftScrollViewState extends State<NftScrollView> {
  final nftController = Get.find<NftController>();
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    nftController.fetchNftList();
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

    final shimmerListView = AlignedGridView.count(
      controller: scrollController,
      crossAxisCount: 2,
      mainAxisSpacing: dimen16,
      crossAxisSpacing: dimen19,
      padding: EdgeInsets.only(left: dimen16, right: dimen16, top: dimen24),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return NftCardShimmer();
      },
      itemCount: 6,
    );

    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          if (notification.metrics.pixels >=
              notification.metrics.maxScrollExtent - dimen200) {
            nftController.loadMoreNftItem();
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
          Obx(() => SliverToBoxAdapter(
                child: nftController.nftList.isEmpty
                    ? (nftController.isNftListLoading()
                        ? shimmerListView
                        : emptyItemWidget)
                    : AlignedGridView.count(
                        controller: scrollController,
                        crossAxisCount: 2,
                        mainAxisSpacing: dimen16,
                        crossAxisSpacing: dimen19,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            left: dimen16, right: dimen16, top: dimen24),
                        itemBuilder: (context, index) {
                          return NftCard(
                            nftName: nftController.nftList[index].name ?? '',
                            imageUrl:
                                nftController.nftList[index].urlImage ?? '',
                          );
                        },
                        itemCount: nftController.nftList.length,
                      ),
              )),
          SliverToBoxAdapter(
              child: Obx(() => Column(
                    children: [
                      verticalSpace24,
                      if (nftController.isNftListLoading())
                        const Center(
                            child: CircularProgressIndicator(
                          strokeWidth: dimen2,
                        ))
                      else if (nftController.currentPage.value ==
                          nftController.totalPage)
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
