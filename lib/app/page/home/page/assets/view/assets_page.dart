import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/assets/controller/assets_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/widgets/asset.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/nfts/widgets/nft_scrollview.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/token/widgets/token_scrollview.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/widgets/gift_scrollview.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/category_model.dart';
import 'package:plat_app/app/page/home/page/home_tab/widgets/widgets.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/app/widgets/app_modern_tabbar.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class AssetsPage extends StatefulWidget {
  const AssetsPage({super.key});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> with TickerProviderStateMixin {
  final currentIndex = 0.obs;
  final AssetsController controller = Get.find();
  final selectedIndex = 0.obs;

  late TabController topController;
  final List<String> menuItemList = [
    'lock_tray'.tr,
    'main_tray'.tr,
  ];
  final isHideBalance = false.obs;

  final List<Category> categories = [
    Category(name: 'token'.tr, isComingSoon: false),
    Category(name: 'nft'.tr, isComingSoon: false),
    Category(name: 'gift'.tr, isComingSoon: false),
    Category(name: 'wallet'.tr),
  ];

  @override
  void initState() {
    super.initState();
    topController = TabController(length: menuItemList.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final appBar = PreferredSize(
      preferredSize: const Size.fromHeight(dimen148),
      child: Container(
          margin: const EdgeInsets.only(
              left: dimen16, right: dimen16, top: dimen16),
          child: AppModernTabBar(
              controller: topController, menuItemList: menuItemList)),
    );

    final Widget headerNavigator = SliverToBoxAdapter(
      child: Container(
        color: colorWhite,
        child: Column(
          children: [
            verticalSpace24,
            Obx(
              () => CategoryWidget(
                  categories: categories,
                  selectedIndex: controller.mainTrayCategoryIndex.value,
                  setSelectedIndex: controller.setMainTrayCategoryIndex,
                  paddingHorizontal: dimen4,
                  listViewKey:
                      const PageStorageKey(AppStorageKey.assets_category)),
            ),
            verticalSpace24,
          ],
        ),
      ),
    );

    final backButton = Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: dimen16, vertical: dimen4),
      child: AppBackButton(
        onTab: () {
          Get.back();
        },
      ),
    );
    final titleWidget = Text(
      'assets'.tr,
      style: text24_0E4C88_700.copyWith(fontSize: 18),
    );
    final headerWidget = Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: [
          backButton,
          titleWidget,
        ],
      ),
    );

    final Widget mainTray =
        Obx(() => controller.mainTrayCategoryIndex.value == 0
            ? TokenScrollView(headerNavigator: headerNavigator)
            : controller.mainTrayCategoryIndex.value == 1
                ? NftScrollView(headerNavigator: headerNavigator)
                : controller.mainTrayCategoryIndex.value == 2
                    ? GiftScrollView(headerNavigator: headerNavigator)
                    : const SizedBox());

    // final Widget tabsView = TabBarView(
    //   controller: topController,
    //   physics: const NeverScrollableScrollPhysics(),
    //   children: [LockTray(topController: topController), mainTray],
    // );

    return Scaffold(
      backgroundColor: colorWhite,
      // appBar: appBar,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            headerWidget,
            const Expanded(child: Asset()),
          ],
        ),
      ),
    );
  }
}
