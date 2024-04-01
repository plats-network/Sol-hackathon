import 'dart:ui';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/controllers/language/language_controller.dart';
import 'package:plat_app/base/resources/strings/st_en_us.dart';
import 'package:plat_app/base/resources/strings/st_vi_vn.dart';

class LocalizationService extends Translations {
  static final LocalizationService _singleton = LocalizationService._internal();

  factory LocalizationService() {
    return _singleton;
  }

  LocalizationService._internal();

  // locale sẽ được get mỗi khi mới mở app (phụ thuộc vào locale hệ thống hoặc bạn có thể cache lại locale mà người dùng đã setting và set nó ở đây)
  static final locale = getLocaleFromStorage();

  // fallbackLocale là locale default nếu locale được set không nằm trong những Locale support
  static const fallbackLocale = Locale('en', 'US');

  // language code của những locale được support
  static final langCodes = [
    'vi',
    'en',
  ];

  // các Locale được support
  static final locales = [
    const Locale('vi', 'VN'),
    const Locale('en', 'US'),
  ];

  // function change language nếu bạn không muốn phụ thuộc vào ngôn ngữ hệ thống
  void changeLocale(String langCode) async {
    final locale = getLocaleFromLanguage(langCode: langCode);
    await Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
      };

  static Locale getLocaleFromStorage() {
    final storage = GetStorage();
    final langCode = Language.values
        .firstWhere((e) => e.toString() == storage.read(keyLanguage),
            orElse: () => defaultLanguage)
        .name;
    for (var i = 0; i < langCodes.length; i++) {
      if (langCode == langCodes[i]) return locales[i];
    }
    return defaultLocale;
  }

  Locale getLocaleFromLanguage({String? langCode}) {
    if (langCode == null) {
      final LanguageController languageController = Get.find();
      langCode = languageController.language.value.name;
    }
    for (var i = 0; i < langCodes.length; i++) {
      if (langCode == langCodes[i]) return locales[i];
    }
    final locale = Get.locale ?? defaultLocale;
    return locale;
  }
}
