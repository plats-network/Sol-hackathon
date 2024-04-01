import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/model/social_task_detail_response.dart';
import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/app/widgets/reward_item.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class TaskRewardPage extends StatefulWidget {
  const TaskRewardPage({Key? key}) : super(key: key);

  @override
  State<TaskRewardPage> createState() => _TaskRewardPageState();
}

class _TaskRewardPageState extends State<TaskRewardPage> {
  final HomeTabController _homeTabController = Get.find();
  RxBool isAssetsActive = false.obs;

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments?['reward'];
    final Rewards? reward =
        (args != null && args! is Rewards) ? args as Rewards : null;
    final Widget bottomButtons = Container(
      color: colorBackground,
      padding: EdgeInsets.all(dimen16),
      child: Row(
        children: [
          Expanded(
            child: AppButton(
              isPrimaryStyle: false,
              title: 'back_to_task_pool'.tr,
              onTap: () => Get.offAllNamed(Routes.home),
              horizontalPadding: dimen4,
            ),
          ),
          Builder(builder: (context) {
            return Obx(() => isAssetsActive.value == true
                ? Expanded(
                    child: Row(children: [
                      horizontalSpace8,
                      Expanded(
                        child: AppButton(
                          title: 'assets'.tr,
                          onTap: () => Get.offAllNamed(Routes.home,
                              arguments: {'start_tab': 'assets'}),
                        ),
                      )
                    ]),
                  )
                : Container());
          }),
        ],
      ),
    );

    return CommonAppPage(
      //fix realtime progress task
      onTap:() => {
        // _homeTabController.fetchSocialTask(),
         Get.back(),
      },
      children: [
      SingleChildScrollView(
        child: SizedBox(
          height: Get.height,
          child: Column(
            children: [
              Image.asset(
                getAssetImage(AssetImagePath.task_success_image),
                width: context.width,
              ),
              Text(
                'congratulations'.tr,
                style: text28_0E4C88_700,
              ),
              verticalSpace4,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: dimen34),
                child: Text(
                  'congratulations_text'.tr,
                  style: text16_32302D_400,
                  textAlign: TextAlign.center,
                ),
              ),
              verticalSpace24,
              ListView.separated(
                separatorBuilder: (context, index) => verticalSpace16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return RewardItem(
                    name: reward?.name,
                    image: reward?.image,
                    // TODO: Backend should return the amount
                    // amount: 1,
                    onSeeDetailTap: () {
                      Get.toNamed(Routes.mysteryBoxDetail, arguments: {
                        'reward': reward,
                      });
                    },
                  );
                },
                // TODO: currently there just one reward returned
                itemCount: reward != null ? 1 : 0,
              ),
              verticalSpace80,
            ],
          ),
        ),
      ),
      Positioned(
          bottom: dimen0, left: dimen0, right: dimen0, child: bottomButtons)
    ]);
  }

  @override
  void initState() {
    super.initState();
    _homeTabController.fetchRemoteConfigForAssets().then((value) {
      isAssetsActive.value = value;
    });
  }
}
