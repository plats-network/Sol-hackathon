import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plat_app/development.dart';

const keySavedPolyLines = 'keySavedPolyLines';

String playStoreUrl() {
  if (Platform.isAndroid) {
    return 'https://play.google.com/';
  } else {
    return 'https://www.apple.com/app-store/';
  }
}

class ErrorCode {
  static const UNKNOWN_ERROR = 0;
  static const COMMON_ERROR = 1;
  static const CREDENTIALS_NOT_MATCH = 2;
  static const RESET_CODE_INVALID = 3;
  static const CONFIRM_CODE_INVALID = 4;
  static const EMAIL_UNVERIFIED = 5;
  static const TIME_INVALID = 6;
  static const ACCOUNT_ACTIVED = 7;
  static const REQUIRE_LOGIN_SOCIAL = 8;
  static const VALIDATE_FAILED = 9;
  static const MODEL_NOT_FOUND = 10;
  static const UNAUTHENTICATED_OR_TOKEN_EXPIRED = 11;
  static const QUERY_EXCEPTION = 12;
  static const INTERNAL_ERROR = 13;
  static const LOGIN_FACEBOOK_ERROR = 14;
  static const LOGIN_GOOGLE_ERROR = 15;
  static const LOGIN_APPLE_ERROR = 16;
  static const LOGIN_SOCIAL_ERROR = 17;
}

class AppStorageKey {
  static const assets_category = 'assets_category';
  static const home_tab_category = 'home_tab_category';
}

Future<XFile> resizeImage(XFile img) async {
  ImageProperties properties =
      await FlutterNativeImage.getImageProperties(img.path);

  File compressedFile = await FlutterNativeImage.compressImage(img.path,
      quality: 90,
      targetWidth: 1080,
      targetHeight: (properties.height! * 1080 / properties.width!).round());

  // delete original file
  try {
    final file = File(img.path);
    if (await file.exists()) {
      await file.delete();
    }
  } catch (e) {
    e.printError();
  }

  return XFile(compressedFile.path);
}

const REMOTE_CONFIG_FETCH_TIME_OUT = Duration(minutes: 1);
const REMOTE_CONFIG_FETCH_INTERVAL = Duration.zero;

Future<void> initRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  debugMock(
    () async {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: REMOTE_CONFIG_FETCH_TIME_OUT,
        minimumFetchInterval: Duration.zero,
      ));

      print('Remote config: ${remoteConfig.lastFetchTime}');
    },
    onProduction: () async {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: REMOTE_CONFIG_FETCH_TIME_OUT,
        minimumFetchInterval: REMOTE_CONFIG_FETCH_INTERVAL,
      ));
    },
  );
  await remoteConfig.setDefaults(const {
    'app_config': '{}',
    'show_assets_tab': false,
  });
  await remoteConfig.fetchAndActivate();
}
