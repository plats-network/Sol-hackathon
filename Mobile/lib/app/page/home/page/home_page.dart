import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/home/children/task_perform/controller/task_perform_controller.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/page/home/model/home_nav_badge.dart';
import 'package:plat_app/app/page/home/page/assets/view/assets_page.dart';
import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
import 'package:plat_app/app/page/home/page/home_tab/view/home_tab_page.dart';
import 'package:plat_app/app/page/home/page/index/view/index_screen.dart';
import 'package:plat_app/app/page/home/page/qrcode/view/qrcode_screen.dart';
import 'package:plat_app/app/page/home/page/setting/view/setting_tab_page.dart';
import 'package:plat_app/app/page/home/page/tickets/view/ticket_screen.dart';
import 'package:plat_app/app/page/home/widgets/active_icon_nav.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/app/widgets/animations/bouncing_effects.dart';
import 'package:plat_app/base/component/dialog/getx_default_dialog.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:plat_app/main.dart';

part 'home_page_action.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final TaskPerformController taskPerformController = Get.find();
  final AppNotificationController appNotificationController = Get.find();
  final HomeTabController homeTabController = Get.find();
  final Rx<TabController?> _tabController = Rx<TabController?>(null);

  //example badge for further use
  final _badge = const NavBadge('hot',
      badgeColor: Colors.orange,
      padding: EdgeInsets.only(left: dimen7, right: dimen7));

  final List<TabItem<dynamic>> _tabItems = [
    // TabItem<dynamic>(
    //   icon: Image.asset(getAssetImage(AssetImagePath.icon_home_inactive)),
    //   activeIcon: ActiveIcon(
    //     //TODO: waiting for design
    //     icon: Image.asset(getAssetImage(AssetImagePath.icon_home_active)),
    //   ),
    //   title: 'home'.tr,
    // ),
    TabItem<dynamic>(
      icon: Image.asset(getAssetImage(AssetImagePath.icon_task_pool_inactive)),
      activeIcon: ActiveIcon(
        //TODO: waiting for design
        icon: Image.asset(getAssetImage(AssetImagePath.icon_task_pool_active)),
      ),
      title: 'task_pool'.tr,
    ),
    TabItem<dynamic>(
      icon: Image.asset(getAssetImage(AssetImagePath.icon_group_inactive)),
      activeIcon: ActiveIcon(
        //TODO: waiting for design
        icon: Image.asset(getAssetImage(AssetImagePath.icon_group_active)),
      ),
      title: 'groups'.tr,
    ),
    TabItem<dynamic>(
      icon: Image.asset(getAssetImage(AssetImagePath.icon_asset_inactive)),
      activeIcon: ActiveIcon(
        icon: Image.asset(getAssetImage(AssetImagePath.icon_asset_active)),
      ),
      title: 'assets'.tr,
    ),
    TabItem<dynamic>(
      icon: Image.asset(getAssetImage(AssetImagePath.icon_settings_inactive)),
      activeIcon: ActiveIcon(
        //TODO: waiting for design
        icon: Image.asset(getAssetImage(AssetImagePath.icon_settings_active)),
      ),
      title: 'settings'.tr,
    ),
  ];

  final List<StatefulWidget> _tabPages = [
    const IndexScreen(),
    const HomeTabPage(),
    const QRCodeScreen(),
    const TicketPage(isBack: false),
    const SettingTabPage(),
  ];

  Future<void> initAssetsTab(bool isAssetsActive) async {
    if (!isAssetsActive) {
      _tabItems.removeWhere((element) => element.title == 'assets'.tr);
      _tabPages.removeWhere((element) => element is AssetsPage);
    }

    _tabController.value = TabController(
        length: _tabItems.length,
        vsync: this,
        animationDuration: const Duration(microseconds: 1));

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Start at tab
      final startTab = Get.arguments?['start_tab'];
      if (startTab == 'assets') {
        final index =
            _tabItems.indexWhere((element) => element.title == 'assets'.tr);

        if (index != -1) {
          _tabController.value?.animateTo(index);
        }
      }
    });
  }

  static TextStyle optionStyle =
      GoogleFonts.quicksand(fontSize: 10, fontWeight: FontWeight.w600);
  int selectedItemPosition = 0;
  void onTap(int index) {
    setState(() {
      selectedItemPosition = index;
    });
  }

  @override
  void initState() {
    super.initState();

    initRemoteConfig().then((value) {
      homeTabController.fetchRemoteConfigForAssets().then(initAssetsTab);
      appNotificationController.fetchRemoteConfig();
    });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (pendingRemoteMessage != null) {
        appNotificationController.handleFcmNotificationMessage(
            pendingRemoteMessage!,
            isFromBackground: true);
        pendingRemoteMessage = null;
      }
    });
    // Config app notification
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
    _configureSelectNotificationSubject();

    // Listening to foreground FCM noti
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // Handle FCM noti
      appNotificationController.handleFcmNotificationMessage(message);
    });

    // Handle background fcm open app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      String result = 'Message data: ${message.data}';
      if (message.notification != null) {
        result +=
            '\nNotification: ${message.notification?.title}, ${message.notification?.body}';
      }
      print('Receive FCM Noti onMessageOpenedApp: $result');
      appNotificationController.handleFcmNotificationMessage(message,
          isFromBackground: true);
    });
  }

  @override
  void dispose() {
    _tabController.value?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget draggableFloatButton = DraggableFab(
      initPosition: Offset(Get.width, Get.height / 2),
      securityBottom: dimen100,
      child: GestureDetector(
        onTap: () {
          Get.toNamed(Routes.taskPerform);
        },
        child: Container(
          width: dimen50,
          height: dimen50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dimen50),
            color: colorD13E45,
            boxShadow: [
              BoxShadow(
                color: color1266B5.withOpacity(0.4),
                spreadRadius: dimen8,
                blurRadius: dimen40,
                offset:
                    const Offset(dimen0, dimen8), // changes position of shadow
              ),
            ],
          ),
          child: Image.asset(
            getAssetImage(AssetImagePath.clipboard_alt),
            width: dimen24,
            height: dimen24,
          ),
        ),
      ),
    );

    return Obx(() => _tabController.value != null
        ? WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
              body: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle.dark,
                child: Stack(children: [
                  _tabPages.elementAt(selectedItemPosition),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: dimen0,
                            right: dimen0,
                            // top: dimen10,
                            bottom: dimen0,
                          ),
                          padding: EdgeInsets.only(
                            top: dimen14,
                            left: dimen30,
                            right: dimen30,
                            bottom: Platform.isIOS &&
                                    MediaQuery.of(context).size.height >= 812
                                ? dimen25
                                : dimen15,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: colorWhite.withOpacity(0.6),
                            border: const Border(
                              top: BorderSide(
                                color: colorE5E5E5,
                                width: 0.5,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Bouncing(
                                onPress: () {
                                  onTap(0);
                                },
                                child: Image.asset(
                                  selectedItemPosition == 0
                                      ? getAssetImage(
                                          AssetImagePath.home_icon_bold)
                                      : getAssetImage(
                                          AssetImagePath.home_icon_line),
                                  color: selectedItemPosition == 0
                                      ? color1266B5
                                      : color4E4E4E,
                                  width: dimen24,
                                  height: dimen24,
                                ),
                              ),
                              Bouncing(
                                onPress: () {
                                  onTap(1);
                                },
                                child: Image.asset(
                                  selectedItemPosition == 1
                                      ? getAssetImage(
                                          AssetImagePath.search_icon_bold)
                                      : getAssetImage(
                                          AssetImagePath.search_icon_line),
                                  color: selectedItemPosition == 1
                                      ? color1266B5
                                      : color4E4E4E,
                                  width: dimen23,
                                  height: dimen23,
                                ),
                              ),
                              const SizedBox(
                                width: dimen30,
                                height: dimen30,
                              ),
                              Bouncing(
                                onPress: () {
                                  onTap(3);
                                },
                                child: Image.asset(
                                  selectedItemPosition == 3
                                      ? getAssetImage(
                                          AssetImagePath.ticket_icon_bold)
                                      : getAssetImage(
                                          AssetImagePath.ticket_icon_line),
                                  color: selectedItemPosition == 3
                                      ? color1266B5
                                      : color4E4E4E,
                                  width: dimen23,
                                  height: dimen23,
                                ),
                              ),
                              Bouncing(
                                onPress: () {
                                  onTap(4);
                                },
                                child: Image.asset(
                                  selectedItemPosition == 4
                                      ? getAssetImage(
                                          AssetImagePath.user_icon_bold)
                                      : getAssetImage(
                                          AssetImagePath.user_icon_line),
                                  color: selectedItemPosition == 4
                                      ? color1266B5
                                      : color4E4E4E,
                                  width: dimen23,
                                  height: dimen23,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: Platform.isIOS &&
                            MediaQuery.of(context).size.height >= 812
                        ? dimen20
                        : dimen10,
                    child: Bouncing(
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const QRCodeScreen()),
                        );
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            const Spacer(),
                            Container(
                              height: dimen44,
                              width: dimen44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: color177FE2,
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.1, 0.5, 0.7],
                                  colors: [
                                    Color.fromARGB(255, 54, 130, 230),
                                    Color.fromARGB(255, 69, 173, 225),
                                    Color.fromARGB(255, 40, 191, 194),
                                  ],
                                ),
                              ),
                              // margin: const EdgeInsets.only(top: 8.0),
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Image.asset(
                                  getAssetImage(AssetImagePath.scan),
                                  color: colorWhite,
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              //   bottomNavigationBar: SizedBox(
              //     height:
              //         Platform.isIOS && MediaQuery.of(context).size.height >= 812
              //             ? dimen70
              //             : dimen50, //70
              //     child: BottomNavigationBar(
              //       selectedLabelStyle: optionStyle,
              //       type: BottomNavigationBarType.fixed,
              //       enableFeedback: true,
              //       unselectedFontSize: 10,
              //       items: <BottomNavigationBarItem>[
              //         BottomNavigationBarItem(
              //           icon: Padding(
              //             padding: const EdgeInsets.only(bottom: dimen2),
              //             child: Image.asset(
              //               getAssetImage(AssetImagePath.home_icon_line),
              //               color: selectedItemPosition == 0
              //                   ? color1266B5
              //                   : color4E4E4E,
              //               width: dimen20,
              //               height: dimen20,
              //             ),
              //           ),
              //           activeIcon: Padding(
              //             padding: const EdgeInsets.only(bottom: dimen2),
              //             child: Image.asset(
              //               getAssetImage(AssetImagePath.home_icon_bold),
              //               color: color1266B5,
              //               width: dimen20,
              //               height: dimen20,
              //             ),
              //           ),
              //           label: 'Home',
              //         ),
              //         BottomNavigationBarItem(
              //           icon: Padding(
              //             padding: const EdgeInsets.only(bottom: dimen2),
              //             child: Image.asset(
              //               getAssetImage(AssetImagePath.checklist),
              //               color: color4E4E4E,
              //               width: dimen20,
              //               height: dimen20,
              //             ),
              //           ),
              //           activeIcon: Padding(
              //             padding: const EdgeInsets.only(bottom: dimen2),
              //             child: Image.asset(
              //               getAssetImage(AssetImagePath.checklist_bold),
              //               color: color1266B5,
              //               width: dimen20,
              //               height: dimen20,
              //             ),
              //           ),
              //           label: 'Quests',
              //         ),
              //         BottomNavigationBarItem(
              //           icon: Align(
              //             alignment: Alignment.bottomCenter,
              //             child: Container(
              //               height: 40,
              //               width: 40,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(15),
              //                 color: color177FE2,
              //                 gradient: const LinearGradient(
              //                   begin: Alignment.topLeft,
              //                   end: Alignment.bottomRight,
              //                   stops: [0.1, 0.5, 0.7],
              //                   colors: [
              //                     Color.fromARGB(255, 54, 130, 230),
              //                     Color.fromARGB(255, 69, 173, 225),
              //                     Color.fromARGB(255, 40, 191, 194),
              //                   ],
              //                 ),
              //               ),
              //               // margin: const EdgeInsets.only(top: 8.0),
              //               child: Padding(
              //                 padding: const EdgeInsets.all(6),
              //                 child: Image.asset(
              //                   getAssetImage(AssetImagePath.scan),
              //                   color: colorWhite,
              //                 ),
              //               ),
              //             ),
              //           ),
              //           label: '',
              //         ),
              //         BottomNavigationBarItem(
              //           icon: Padding(
              //             padding: const EdgeInsets.only(bottom: dimen2),
              //             child: Image.asset(
              //               getAssetImage(AssetImagePath.ticket_icon_line),
              //               color: selectedItemPosition == 3
              //                   ? color1266B5
              //                   : color4E4E4E,
              //               width: dimen20,
              //               height: dimen20,
              //             ),
              //           ),
              //           activeIcon: Padding(
              //             padding: const EdgeInsets.only(bottom: dimen2),
              //             child: Image.asset(
              //               getAssetImage(AssetImagePath.ticket_icon_bold),
              //               color: color1266B5,
              //               width: dimen20,
              //               height: dimen20,
              //             ),
              //           ),
              //           label: 'Tickets',
              //         ),
              //         BottomNavigationBarItem(
              //           icon: Padding(
              //             padding: const EdgeInsets.only(bottom: dimen2),
              //             child: Image.asset(
              //               getAssetImage(AssetImagePath.user_icon),
              //               color: selectedItemPosition == 4
              //                   ? color1266B5
              //                   : color4E4E4E,
              //               width: dimen20,
              //               height: dimen20,
              //             ),
              //           ),
              //           activeIcon: Padding(
              //             padding: const EdgeInsets.only(bottom: dimen2),
              //             child: Image.asset(
              //               getAssetImage(AssetImagePath.user_bold),
              //               color: color1266B5,
              //               width: dimen20,
              //               height: dimen20,
              //             ),
              //           ),
              //           label: 'Profile',
              //         ),
              //       ],
              //       onTap: onTap,
              //       currentIndex: selectedItemPosition,
              //       selectedItemColor: color1266B5,
              //       unselectedItemColor: color4E4E4E,
              //       backgroundColor: colorWhite,
              //     ),
              //   ),
            ),
          )
        : const Scaffold(body: FullScreenProgress()));
  }
}

class Style extends StyleHook {
  @override
  double get activeIconSize => dimen55;

  @override
  double get activeIconMargin => dimen10;

  @override
  double get iconSize => dimen22;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return TextStyle(
        fontSize: dimen10,
        color: color,
        height: dimen2,
        fontFamily: fontFamily);
  }
}
