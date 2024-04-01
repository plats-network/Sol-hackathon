part of 'home_page.dart';

extension HomePageAction on _HomePageState {
  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
            critical: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      final bool? granted = await androidImplementation?.requestPermission();
      appNotificationController.notificationsEnabled.value = granted ?? false;
    }
  }
}

void _configureDidReceiveLocalNotificationSubject() {
  didReceiveLocalNotificationStream.stream
      .listen((ReceivedNotification receivedNotification) async {
    await GetXDefaultDialog.notifyDialog(
        title: 'Notification', middleText: 'Notification clicked');
  });
}

void _configureSelectNotificationSubject() {
  selectNotificationStream.stream.listen((String? payload) async {
    if (payload != null) {
      try {
        final payloadJson = jsonDecode(payload);
        if (payloadJson['page'] != null) {
          Get.toNamed(payloadJson['page']);
        }
      } catch (e) {
        e.printError();
      }
    }
  });
}
