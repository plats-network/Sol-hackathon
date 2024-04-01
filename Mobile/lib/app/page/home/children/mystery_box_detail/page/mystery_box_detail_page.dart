import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/mystery_box_detail/widgets/unbox_schedule_widget.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/model/social_task_detail_response.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
import 'package:plat_app/base/routes/base_pages.dart';

part 'mystery_box_detail_page_action.dart';

class MysteryBoxDetailPage extends StatefulWidget {
  const MysteryBoxDetailPage({Key? key}) : super(key: key);

  @override
  State<MysteryBoxDetailPage> createState() => _MysteryBoxDetailPageState();
}

class _MysteryBoxDetailPageState extends State<MysteryBoxDetailPage> {
  final HomeTabController _homeTabController = Get.find();
  RxBool isAssetsActive = false.obs;

  @override
  void initState() {
    super.initState();
    _homeTabController.fetchRemoteConfigForAssets().then((value) {
      isAssetsActive.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments?['reward'];
    final Rewards? reward =
        (args != null && args! is Rewards) ? args as Rewards : null;

    return CommonAppPage(children: [
      SingleChildScrollView(
        padding: EdgeInsets.all(dimen16),
        child: Column(
          children: [
            verticalSpace8,
            Text(
              'wait_to_unbox'.tr,
              style: text24_0E4C88_700,
            ),
            verticalSpace24,
            Text(
              'your_mystery_box_including'.tr,
              style: text16_32302D_400,
            ),
            verticalSpace24,
            Image.asset(
              getAssetImage(AssetImagePath.mystery_box_large),
              width: Get.width - dimen80,
            ),
            verticalSpace24,
            // TODO: backend should return time when mystery box will be unboxed
            UnboxScheduleWidget(),
            Builder(builder: (context) {
              return Obx(() => isAssetsActive.value == true
                  ? Column(children: [
                      verticalSpace60,
                      AppButton(
                        title: 'assets'.tr,
                        isPrimaryStyle: false,
                        onTap: () {
                          Get.offAllNamed(Routes.home,
                              arguments: {'start_tab': 'assets'});
                        },
                      )
                    ])
                  : Container());
            })
          ],
        ),
      )
    ]);
  }
}
