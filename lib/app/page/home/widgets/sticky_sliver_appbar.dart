import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/notification/controller/notification_controller.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/page/home/page/setting/controller/setting_controller.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class StickySliverAppBar extends StatelessWidget {
  const StickySliverAppBar({
    Key? key,
    required this.settingController,
  }) : super(key: key);

  final SettingController settingController;

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController = Get.find();

    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: colorWhite,
      title: Row(
        children: [
          Obx(() {
            if (settingController
                    .userProfile.value.data?.data?.avatarPath?.isEmpty ==
                true) {
              return const SizedBox();
            } else {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.editProfile);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(dimen60),
                  child: SizedBox(
                      width: dimen50,
                      height: dimen50,
                      child: AppCachedImage(
                          imageUrl: settingController
                                  .userProfile.value.data?.data?.avatarPath ??
                              '',
                          cornerRadius: dimen5,
                          width: dimen56,
                          height: dimen56)),
                ),
              );
            }
          }),
          const SizedBox(
            width: dimen15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text(
              //   'hello'.tr,
              //   textAlign: TextAlign.left,
              //   style: text16_625F5C_400,
              // ),
              Obx(() {
                return Text(
                  settingController.userProfile.value.data?.data?.name ?? '',
                  textAlign: TextAlign.left,
                  style: text16_black_700,
                );
              })
            ],
          )
        ],
      ),
      centerTitle: false,
      floating: true,
      pinned: false,
      snap: false,
      actions: const [
        // GestureDetector(
        //   child: Obx(() => Badge(
        //         position: BadgePosition.topEnd(top: dimen3, end: -6),
        //         showBadge: notificationController.unreadNotificationCount.value > 0,
        //         badgeContent: Padding(
        //           padding: const EdgeInsets.all(dimen0),
        //           child: Text(
        //             notificationController.unreadNotificationCount.value.toString(),
        //             style: text10_white_600,
        //           ),
        //         ),
        //         badgeColor: color27AE60,
        //         child: Image(
        //           image: AssetImage(getAssetImage(AssetImagePath.icon_bell)),
        //           width: dimen24,
        //           height: dimen24,
        //         ),
        //       )),
        //   onTap: () {
        //     logEvent(eventName: 'NOTIFICATION_VIEW', eventParameters: {});
        //     Get.toNamed(Routes.notification);
        //   },
        // ),
        // horizontalSpace15,
        //TODO: add language change with user.language
        // GestureDetector(
        //   child: Image(
        //       //TODO: change language icon with user.language
        //       image: AssetImage(
        //           getAssetImage(AssetImagePath.en_flag)),
        //       width: dimen24,
        //       height: dimen24),
        //   onTap: () => {print("change language")},
        // ),
        // horizontalSpace15,
      ],
    );
  }
}
