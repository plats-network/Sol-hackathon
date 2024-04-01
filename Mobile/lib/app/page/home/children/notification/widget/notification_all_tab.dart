import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/home/children/notification/controller/notification_controller.dart';
import 'package:plat_app/app/page/home/children/notification/controller/notification_datasource.dart';
import 'package:plat_app/app/page/home/children/notification/widget/notification_item.dart';
import 'package:plat_app/app/page/home/children/notification/widget/notification_item_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class NotificationAllTab extends StatefulWidget {
  const NotificationAllTab({Key? key}) : super(key: key);

  @override
  State<NotificationAllTab> createState() => _NotificationAllTabState();
}

class _NotificationAllTabState extends State<NotificationAllTab> {
  final NotificationController notificationController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notificationController.fetchListNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Obx(() {
        if (notificationController.isGettingListNotifications()) {
          return Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(
                      left: dimen16, right: dimen16, top: dimen12),
                  alignment: Alignment.topRight,
                  child: Text('${"unread".tr} (0)', style: text14_9C9896_600)),
              verticalSpace20,
              ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: List.generate(
                  mockNotifications.length,
                  (index) => const NotificationItemShimmer(),
                ),
              ),
            ],
          );
        } else {
          return notificationController.unreadNotificationCount.value != 0
              ? Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: dimen16, right: dimen16, top: dimen12),
                      alignment: Alignment.topRight,
                      child: Obx(() => Text(
                          '${"unread".tr} (${notificationController.unreadNotificationCount.value})',
                          style: notificationController
                                      .unreadNotificationCount.value >
                                  0
                              ? text14_A73237_600
                              : text14_9C9896_600)),
                    ),
                    verticalSpace20,
                    Obx(() {
                      final notifications = notificationController
                          .listNotificationsData.value.data?.data;
                      return ListView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: dimen24),
                        itemCount: notifications?.length ?? 0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final notification = notifications?[index];
                          return NotificationItem(
                            notification: notification,
                            type: null,
                          );
                        },
                      );
                    }),
                  ],
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image(
                          image: AssetImage(
                            getAssetImage(AssetImagePath.no_notification),
                          ),
                          width: MediaQuery.of(context).size.width * 0.7,
                        ),
                      ),
                      Text(
                        'No Notifications Yet',
                        style: GoogleFonts.quicksand(
                          color: colorBlack,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace4,
                      Text(
                        'You have no notifications right now.\nCome back later',
                        style: GoogleFonts.quicksand(
                          color: color4E5260,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
        }
      }),
    );
  }
}
