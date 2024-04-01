import 'dart:async';
import 'dart:developer';
import 'package:plat_app/app/page/home/provider/app_notification_provider.dart';
import 'package:plat_app/firebase_options.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/controllers/language/language_controller.dart';
import 'package:plat_app/base/controllers/language/localization_service.dart';
import 'package:plat_app/base/provider/auth/auth_provider.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:plat_app/navigator_middleware.dart';

part 'main_action.dart';

late List<CameraDescription> cameras;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialised in the `main` function
final StreamController<ReceivedNotification> didReceiveLocalNotificationStream =
    StreamController<ReceivedNotification>.broadcast();
final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();
const MethodChannel platform =
    MethodChannel('dexterx.dev/Plats Network Notification Channel');
const String portName = 'notification_send_port';
String? selectedNotificationPayload;
RemoteMessage? pendingRemoteMessage;

/// A notification action which triggers a App navigation event
const String navigationActionId = 'id_3';

/// Defines a iOS/MacOS notification category for text input actions.
const String darwinNotificationCategoryText = 'textCategory';

/// Defines a iOS/MacOS notification category for plain actions.
const String darwinNotificationCategoryPlain = 'plainCategory';
NavigatorMiddleware middleware = NavigatorMiddleware();

Future main() async {
  print('User log 1');
  WidgetsFlutterBinding.ensureInitialized();
  // Load env
  await dotenv.load(fileName: '.env');
  final variant = dotenv.env['VARIANT'];
  await dotenv.load(fileName: '.env.$variant');
  await GetStorage.init();
  cameras = await availableCameras();
  print('User log 1.1');
  await Firebase.initializeApp(
    name: 'app_name'.tr,
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print('User log 2');

  await _initNotification();
  print('User log 3');

  // Request permisssion for iOS
  final messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: BindingsBuilder(() {
        Get.put(LanguageController(), permanent: true);
        Get.put(AppNotificationProvider());
        Get.put(AppNotificationController());
        Get.put(AuthProvider());
        Get.put(AuthController());
      }),
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
      initialRoute: Routes.splash,
      getPages: pages,
      navigatorObservers: <NavigatorObserver>[middleware],
      theme: ThemeData(
        fontFamily: 'OpenSans',
        scaffoldBackgroundColor: colorBackground,
        primaryColor: colorPrimary,
        toggleableActiveColor: colorPrimary,
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),
    );
  }
}
