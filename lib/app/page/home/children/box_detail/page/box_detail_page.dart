import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/box_detail/controller/box_detail_controller.dart';
import 'package:plat_app/app/page/home/children/box_detail/widget/unbox_description_widget.dart';
import 'package:plat_app/app/page/home/page/assets/controller/assets_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/controller/gift_controller.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:confetti/confetti.dart';

class BoxDetailPage extends StatefulWidget {
  const BoxDetailPage({super.key});

  @override
  State<BoxDetailPage> createState() => _BoxDetailPageState();
}

class _BoxDetailPageState extends State<BoxDetailPage>
    with SingleTickerProviderStateMixin {
  final boxDetailController = Get.find<BoxDetailController>();
  final AssetsController assetsController = Get.find();
  final GiftController giftController = Get.find();

  final boxDetailId = Get.arguments['box_id'];
  late Worker _detailFetchWorker;
  late Worker _unboxWorker;

  late Animation<double> _boxAnimation;
  late AnimationController _boxAnimateController;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    boxDetailController.fetchBoxDetail(boxDetailId);
    _detailFetchWorker = ever(boxDetailController.boxDetailData, (boxDetail) {
      // todo: handle boxDetail error/success
    });
    _unboxWorker = ever(boxDetailController.boxDetailUnboxData,
        (NetworkResource response) {
      if (response.isError()) {
        if (response.data.data.amount == null) {
          GetXDefaultBottomSheet.errorBottomSheet(
              title: 'error'.tr,
              text: Text(response.message ?? 'error'.tr),
              buttons: [
                Expanded(
                    child: AppButton(
                  title: 'ok'.tr,
                  onTap: () {
                    Get.back();
                  },
                ))
              ]);
          return;
        }
      } else if (response.isSuccess()) {
        _boxAnimateController.forward(from: 0);
        _confettiController.play();

        giftController.fetchGiftList();
      }
    });

    _boxAnimateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _boxAnimation =
        Tween<double>(begin: 0, end: 1).animate(_boxAnimateController)
          ..addListener(() {
            setState(() {});
          });

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 1),
    );
  }

  @override
  void dispose() {
    _detailFetchWorker.dispose();
    _unboxWorker.dispose();
    _boxAnimateController.dispose();
    boxDetailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const translateDistance = dimen100;

    return CommonAppPage(children: [
      Column(children: [
        verticalSpace26,
        Row(
          children: [
            Expanded(
              child: Text('details'.tr,
                  style: text28_0E4C88_700, textAlign: TextAlign.center),
            ),
          ],
        ),
        verticalSpace24,
        Expanded(
            child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: dimen16),
            width: context.width,
            child: Column(
              children: [
                verticalSpace24,
                Text('hurray_your_rewards_are_available_now'.tr,
                    style: text16_32302D_400),
                verticalSpace24,
                Obx(() => Image.asset(
                      getAssetImage(
                          boxDetailController.isUnboxTaskDetailSuccess()
                              ? AssetImagePath.mystery_box_style_3
                              : AssetImagePath.mystery_box_large),
                      width: dimen295,
                      height: dimen295,
                    )),
                verticalSpace24,
                if (boxDetailController.isUnboxTaskDetailSuccess()) ...[
                  SizedBox(
                    height: translateDistance,
                  ),
                  Transform.translate(
                    offset: Offset(0, -_boxAnimation.value * translateDistance),
                    child: Opacity(
                        opacity: _boxAnimation.value,
                        child: Obx(() => UnboxDescriptionWidget(
                            type: boxDetailController
                                    .boxDetailUnboxData.value.data?.data?.type
                                    ?.toInt() ??
                                0,
                            value: boxDetailController
                                    .boxDetailUnboxData.value.data?.data?.amount
                                    .toString() ??
                                '',
                            name: boxDetailController
                                    .boxDetailUnboxData.value.data?.data?.name
                                    .toString() ??
                                ''))),
                  )
                ]
              ],
            ),
          ),
        )),
        Container(
            color: colorBackground,
            padding: const EdgeInsets.only(
                bottom: dimen16, left: dimen16, right: dimen16),
            child: Obx(() => boxDetailController.isUnboxTaskDetailSuccess()
                ? AppButton(
                    title: 'done'.tr,
                    onTap: () {
                      Get.back();
                      switch (boxDetailController
                          .boxDetailUnboxData.value.data?.data?.type) {
                        case BoxType.token:
                          assetsController.setMainTrayCategoryIndex(0);
                          break;
                        case BoxType.nft:
                          assetsController.setMainTrayCategoryIndex(1);
                          break;
                        default:
                          assetsController.setMainTrayCategoryIndex(2);
                          break;
                      }
                    })
                : Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: colorWhite,
                          child: AppButton(
                            title: 'back_to_asset'.tr,
                            horizontalPadding: dimen8,
                            onTap: () {
                              Get.back();
                            },
                            isPrimaryStyle: false,
                          ),
                        ),
                      ),
                      horizontalSpace8,
                      Expanded(
                        child: Container(
                          color: colorWhite,
                          child: AppButton(
                            title: 'unbox'.tr,
                            onTap: () {
                              boxDetailController.unbox(boxDetailId);

                              // Get.back();
                            },
                          ),
                        ),
                      ),
                    ],
                  )))
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        ConfettiWidget(
          confettiController: _confettiController,
          blastDirectionality: BlastDirectionality.explosive,
          shouldLoop: true,
          numberOfParticles: 20,
        ),
      ]),
      Obx(() => boxDetailController.isFetchingBoxDetail()
          ? FullScreenProgress()
          : Container()),
    ]);
  }
}
