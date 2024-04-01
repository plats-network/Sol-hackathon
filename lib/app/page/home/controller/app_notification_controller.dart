import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:plat_app/app/page/home/children/notification/model/create_fcm_device_token_response.dart';
import 'package:plat_app/app/page/home/children/task_perform/controller/task_perform_controller.dart';
import 'package:plat_app/app/page/home/children/task_perform/model/doing_task_response_extension.dart';
import 'package:plat_app/app/page/home/model/fcm_noti_response.dart';
import 'package:plat_app/app/page/home/provider/app_notification_provider.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/base/component/snackbar/getx_default_snack_bar.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/controllers/language/language_controller.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:plat_app/main.dart';

class AppNotificationController extends GetxController {
  late TaskPerformController taskPerformController = Get.find();
  final AppNotificationProvider appNotificationProvider = Get.find();
  final notificationsEnabled = false.obs;
  static String NOTIFICATION_CHANNEL_ID = 'Plats Network Channel Id';
  static String NOTIFICATION_CHANNEL_NAME = 'Plats Network Doing Task';
  static String NOTIFICATION_CHANNEL_DESCRIPTION = 'Plats Network Notification';
  final countDownNotificationId = 999999;
  bool isCountingDown = false;

  Future<void> showDoingTaskNotification() async {
    await cancelCountDownNotification();
    int timeRemaining = 1;
    int maxTime = 1;
    isCountingDown = true;
    final doingTask = taskPerformController.doingTask.value.data;
    if (doingTask?.timeEndOrginalDateTime != null &&
        doingTask?.timeStartOrginalDateTime != null) {
      final startTimeMillis =
          doingTask?.timeStartOrginalDateTime?.millisecondsSinceEpoch as int;
      final endTimeMillis =
          doingTask?.timeEndOrginalDateTime?.millisecondsSinceEpoch as int;
      maxTime = (endTimeMillis - startTimeMillis) ~/ 1000;
      if (maxTime == 0) {
        maxTime = 1;
      }
      final nowMillis = DateTime.now().toLocal().millisecondsSinceEpoch;
      if (nowMillis > endTimeMillis) {
        timeRemaining = 0;
      } else {
        timeRemaining = (endTimeMillis - nowMillis) ~/ 1000;
      }
    }
    if (timeRemaining > 0) {
      int i = timeRemaining;
      while (i >= 0 && isCountingDown == true) {
        await Future<void>.delayed(const Duration(seconds: 1), () async {
          if (isCountingDown == true) {
            final AndroidNotificationDetails androidNotificationDetails =
                AndroidNotificationDetails(
                    NOTIFICATION_CHANNEL_ID, NOTIFICATION_CHANNEL_NAME,
                    channelDescription: NOTIFICATION_CHANNEL_DESCRIPTION,
                    importance: Importance.max,
                    priority: Priority.high,
                    ongoing: true,
                    onlyAlertOnce: true,
                    showProgress: true,
                    maxProgress: maxTime,
                    progress: timeRemaining,
                    autoCancel: false);
            bool iosShowAlert = false;
            // If there are 15 minutes left, play iOS sound
            if (i == timeRemaining ||
                (i == 15 * 60 + 1) ||
                (i == 10 * 60 + 1) ||
                (i == 5 * 60 + 1) ||
                (i == 3 * 60 + 1)) {
              iosShowAlert = true;
            }
            final DarwinNotificationDetails iosNotificationDetails =
                DarwinNotificationDetails(
              presentSound: iosShowAlert,
              presentBadge: iosShowAlert,
              presentAlert: iosShowAlert,
            );
            final NotificationDetails notificationDetails = NotificationDetails(
                android: androidNotificationDetails,
                iOS: iosNotificationDetails);
            if (Platform.isAndroid || iosShowAlert) {
              await flutterLocalNotificationsPlugin.show(
                  countDownNotificationId,
                  'Your task is running',
                  'Time remaining: ${formatDoingTaskTime(i)}',
                  notificationDetails,
                  payload: jsonEncode({'page': Routes.taskPerform}));
            }
          }
        });
        i--;
      }
    }
  }

  Future<void> cancelCountDownNotification() async {
    isCountingDown = false;
    await flutterLocalNotificationsPlugin.cancel(countDownNotificationId);
  }

  Future<List<ActiveNotification>> fetchActiveNotifications() async {
    final List<ActiveNotification> activeNotifications =
        await flutterLocalNotificationsPlugin.getActiveNotifications();
    return activeNotifications;
  }

  final Rx<NetworkResource<CreateFcmDeviceTokenResponse>>
      createFCMDeviceTokenData =
      Rx(NetworkResource<CreateFcmDeviceTokenResponse>.init());

  void createFCMDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    String? deviceName;
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceName = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceName = iosInfo.utsname.machine;
    }
    final body = {'token': token, 'device_name': deviceName};
    createFCMDeviceTokenData.value =
        NetworkResource<CreateFcmDeviceTokenResponse>.loading();
    Response result;
    result = await appNotificationProvider.postCreateDeviceToken(body);
    NetworkResource.handleResponse(
        result, CreateFcmDeviceTokenResponse.fromJson, createFCMDeviceTokenData,
        isShowError: false);
  }

  bool isCreatingFCMDeviceToken() {
    return createFCMDeviceTokenData.value.isLoading();
  }

  bool isCreateFCMDeviceTokenSuccess() {
    return createFCMDeviceTokenData.value.isSuccess();
  }

  bool isCreateFCMDeviceTokenError() {
    return createFCMDeviceTokenData.value.isError();
  }

  final Rx<NetworkResource<FcmNotiResponse>> deleteTokenData =
      Rx(NetworkResource<FcmNotiResponse>.init());

  Future<void> deleteToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    deleteTokenData.value = NetworkResource<FcmNotiResponse>.loading();
    Response result;
    result = await appNotificationProvider.deleteToken(token);
    NetworkResource.handleResponse(
        result, FcmNotiResponse.fromJson, deleteTokenData,
        isShowError: false);
  }

  bool isDeletingDeviceToken() {
    return deleteTokenData.value.isLoading();
  }

  bool isDeleteDeviceTokenSuccess() {
    return deleteTokenData.value.isSuccess();
  }

  bool isDeleteDeviceTokenError() {
    return deleteTokenData.value.isError();
  }

  final Rx<NetworkResource<FcmNotiResponse>> testFCMNotiData =
      Rx(NetworkResource<FcmNotiResponse>.init());

  void testFCMNoti(String action) async {
    testFCMNotiData.value = NetworkResource<FcmNotiResponse>.loading();
    final AuthController authController = Get.find();
    final body = {'action': action, 'user_id': authController.fetchUserId()};
    final result = await appNotificationProvider.postTestNoti(body);
    NetworkResource.handleResponse(
        result, FcmNotiResponse.fromJson, testFCMNotiData,
        isShowError: false);
  }

  bool isTestingFCMNoti() {
    return testFCMNotiData.value.isLoading();
  }

  bool isTestFCMNotiSuccess() {
    return testFCMNotiData.value.isSuccess();
  }

  bool isTestFCMNotiError() {
    return testFCMNotiData.value.isError();
  }

  Future<void> fetchRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    // try {
      // final appConfig = jsonDecode(remoteConfig.getString('app_config'));
      // print('Firebase Remote Config: $appConfig');
      // PackageInfo packageInfo = await PackageInfo.fromPlatform();
      // // App info
      // String appVersionCode = packageInfo.buildNumber;
      // String appVersionName = packageInfo.version;
      // final currentConfig =
      //     (Platform.isAndroid) ? appConfig['android'] : appConfig['ios'];
      // // Config info
      // final configVersionCode = currentConfig['version_code'] as int;
      // final configVersionName = currentConfig['version_name'] as String;
      // if (appVersionName != configVersionName ||
      //     int.parse(appVersionCode) < configVersionCode) {
      //   final LanguageController languageController = Get.find();
      //   final currentLanguageCode = languageController.currentLanguageCode();
      //   final title = appConfig['title'][currentLanguageCode];
      //   final content = appConfig['content'][currentLanguageCode];
      //   String? url = currentConfig['url'] as String?;
      //   if (url?.isEmpty == true) {
      //     url = playStoreUrl();
      //   }
      //   final forceUpdate = currentConfig['force_update'] as bool?;
        //Show update dialog
        // GetXDefaultDialog.defaultDialog(
        //     title: title,
        //     middleText: content,
        //     textCancel: 'cancel'.tr,
        //     textConfirm: 'update'.tr,
        //     onCancel: () {
        //       if (forceUpdate == true) {
        //         exit(0);
        //       }
        //     },
        //     onConfirm: () async {
        //       if (url != null) {
        //         final uri = Uri.parse(url);
        //         if (await canLaunchUrl(uri)) {
        //           await launchUrl(uri, mode: LaunchMode.externalApplication);
        //         } else {
        //           GetXDefaultSnackBar.errorSnackBar(
        //               message: "Could not launch $url");
        //         }
        //       }
        //       if (forceUpdate == true) {
        //         exit(0);
        //       }
        //     },
        //     onWillPop: (value) {
        //       // if (forceUpdate == true) {
        //       //   exit(0);
        //       // }
        //     });
    //   }
    // } catch (e) {
    //   e.printError();
    // }
  }

  Future<void> handleFcmNotificationMessage(RemoteMessage message,
      {bool isFromBackground = false}) async {
    String result = 'Message data: ${message.data}';
    if (message.notification != null) {
      result +=
          '\nNotification: ${message.notification?.title}, ${message.notification?.body}';
    }
    print('Receive FCM Noti onMessage.listen: $result');
    // Handle FCM noti
    handleFcmNotificationResponse(
        messageData: message.data,
        notificationTitle: message.notification?.title,
        notificationBody: message.notification?.body,
        isFromBackground: isFromBackground);
  }

  /// {
  ///   "notification": {
  ///     "title": "Có task mới",
  ///     "description": "Mô tả task mới",
  ///     "icon": "https://i.imgur.com/UuCaWFA.png"
  ///   },
  ///   "data": {"action": "TASK_INPROGRESS", "task_id": "96be3494-f808-468a-a977-6672239561ae"}
  /// }
  Future<void> handleFcmNotificationResponse(
      {Map? messageData,
      String? notificationTitle,
      String? notificationBody,
      bool isFromBackground = false}) async {
    if (messageData != null) {
      final action = messageData['action'] as String?;
      if (action == FcmAction.NEW_TASK.name) {
        final taskId = messageData['task_id'] as String?;
        if (taskId != null) {
          if (isFromBackground) {
            Get.toNamed(Routes.taskDetail,
                arguments: {'task_id': taskId}, preventDuplicates: false);
          } else {
            GetXDefaultSnackBar.fcmNotiSnackbar(
                title: notificationTitle ?? '',
                text: notificationBody ?? '',
                onTap: () {
                  Get.toNamed(Routes.taskDetail,
                      arguments: {'task_id': taskId}, preventDuplicates: false);
                });
          }
        }
      } else if (action == FcmAction.TASK_INPROGRESS.name) {
        final taskId = messageData['task_id'] as String?;
        if (taskId != null) {
          if (isFromBackground) {
            Get.toNamed(Routes.taskDetail,
                arguments: {'task_id': taskId}, preventDuplicates: false);
          } else {
            GetXDefaultSnackBar.fcmNotiSnackbar(
                title: notificationTitle ?? '',
                text: notificationBody ?? '',
                onTap: () {
                  Get.toNamed(Routes.taskDetail,
                      arguments: {'task_id': taskId}, preventDuplicates: false);
                });
          }
        }
      } else if (action == FcmAction.BOX.name) {
        final boxId = messageData['box_id'] as String?;
        if (boxId != null) {
          if (isFromBackground) {
            logEvent(
                eventName: 'GIFT_BOX_DETAIL_VIEW',
                eventParameters: {'box_id': boxId});
            Get.toNamed(Routes.boxDetail,
                arguments: {'box_id': boxId}, preventDuplicates: false);
          } else {
            GetXDefaultSnackBar.fcmNotiSnackbar(
                title: notificationTitle ?? '',
                text: notificationBody ?? '',
                onTap: () {
                  logEvent(
                      eventName: 'GIFT_BOX_DETAIL_VIEW',
                      eventParameters: {'box_id': boxId});
                  Get.toNamed(Routes.boxDetail,
                      arguments: {'box_id': boxId}, preventDuplicates: false);
                });
          }
        }
      } else if (action == FcmAction.VOUCHER.name) {}
    }
  }

  Future<void> copyFCMDeviceToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    await Clipboard.setData(ClipboardData(text: token));
    print('Device token: $token');
    GetXDefaultSnackBar.successSnackBar(title: 'Copied', message: token ?? '');
  }
}

enum FcmAction { NEW_TASK, TASK_INPROGRESS, BOX, VOUCHER }

extension ParseToString on FcmAction {
  String get name {
    switch (this) {
      case FcmAction.NEW_TASK:
        return 'NEW_TASK';
      case FcmAction.TASK_INPROGRESS:
        return 'TASK_INPROGRESS';
      case FcmAction.BOX:
        return 'BOX';
      case FcmAction.VOUCHER:
        return 'VOUCHER';
    }
  }
}

Future<void> logEvent(
    {required String eventName,
    required Map<String, dynamic> eventParameters}) async {
  try {
    print('logEvent: name: $eventName, parameters: $eventParameters');
    await FirebaseAnalytics.instance.logEvent(
      name: eventName,
      parameters: eventParameters,
    );
  } catch (e) {
    e.printError();
  }
}
