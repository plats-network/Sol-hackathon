import 'dart:ui';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/controllers/language/localization_service.dart';

enum Language { japanese, english, vietnamese, philippines, chinese }

extension LanguageExtension on Language {
  String get name {
    switch (this) {
      case Language.vietnamese:
        return 'vi';
      case Language.english:
        return 'en';
      default:
        return 'vi';
    }
  }
}

const defaultLanguage = Language.english;
const defaultLocale = Locale('vi', 'VN');

class LanguageController extends GetxController {
  final storage = GetStorage();
  final language = Rx<Language>(Language.english);

  LanguageController() {
    final _language = Language.values.firstWhere(
        (e) => e.toString() == storage.read(keyLanguage),
        orElse: () => defaultLanguage);
    setLanguage(_language);
  }

  void setLanguage(Language _language) {
    final langCode = _language.name;
    language.value = _language;
    storage.write(keyLanguage, language.value.toString());
    LocalizationService().changeLocale(langCode);
  }

  String currentLanguageCode() => language.value.name;
}
