import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/notification/controller/notification_controller.dart';
import 'package:plat_app/app/page/home/children/notification/widget/notification_all_tab.dart';
import 'package:plat_app/app/page/home/children/notification/widget/notification_new_task_tab.dart';
import 'package:plat_app/app/page/home/children/notification/widget/notification_unbox_tab.dart';
import 'package:plat_app/app/widgets/app_modern_tabbar.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class NotificationPage extends StatefulWidget {
  final bool isBack;
  const NotificationPage({Key? key, this.isBack = true}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage>
    with TickerProviderStateMixin {
  final NotificationController notificationController = Get.find();
  late TabController tabController;
  final menuItemList = ['all'.tr, 'new_tasks'.tr, 'unbox'.tr];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: menuItemList.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget tabBar = AppModernTabBar(
      controller: tabController,
      menuItemList: menuItemList,
    );

    const allTab = NotificationAllTab();
    const newTasksTab = NotificationNewTaskTab();
    const unboxTab = NotificationUnboxTab();

    final Widget tabViews = TabBarView(
      controller: tabController,
      children: [
        allTab,
        newTasksTab,
        unboxTab,
      ],
    );

    return Stack(
      children: [
        CommonAppBarPage(
          title: 'notification'.tr,
          isBack: widget.isBack,
          child: Container(
            decoration: const BoxDecoration(
              color: colorWhite,
            ),
            child: Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(top: dimen2),
                    child: tabBar),
                Expanded(child: tabViews),
              ],
            ),
          ),
        ),
        Obx(() => (notificationController.isGettingListNotifications() ||
                notificationController.isGettingListNewTaskNotifications() ||
                notificationController.isGettingListUnboxNotifications() ||
                notificationController.isFetchingTaskType())
            ? const FullScreenProgress()
            : Container()),
      ],
    );
  }
}
