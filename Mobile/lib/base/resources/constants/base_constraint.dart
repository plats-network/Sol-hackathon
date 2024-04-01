import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plat_app/base/controllers/language/language_controller.dart';

part 'asset_image_constraint.dart';

const assetsImage = 'assets/images/';
const keyLanguage = 'keyLanguage';
const keyEmail = 'keyEmail';
const keyPassword = 'keyPassword';
const keyAccessToken = 'keyAccessToken';
const keyUserId = 'keyUserId';

const googleMapApiKey = 'AIzaSyBHepHW0kcFZddVB3uMtU4KM7JE7v4ZSVs';

const FIRST_PAGE = 1;
const PER_PAGE = 10;
const END_REACHED_THRESHOLD = 200;
const LOAD_MORE_THRESHOLD = Duration(milliseconds: 500);

String getAssetImage(String path) {
  return assetsImage + path + '.png';
}

final emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9]+");

bool validatePassword(password) =>
    RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
        .hasMatch(password);

String validatePasswordMessage(password) {
  var result = '';
  // Check 8 characters
  final match8Characters = RegExp(r'.{8,}').hasMatch(password);
  if (!match8Characters) {
    result += 'password_validation_8_characters'.tr;
  }
  // Check upper case, lower case
  final matchUpperLowerCase =
      RegExp(r'(?=.*?[A-Z])(?=.*?[a-z])').hasMatch(password);
  if (!matchUpperLowerCase) {
    result += '\n' + 'password_validation_upper_lower'.tr;
  }
  // Check special character
  final matchSpecialCharacter = RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(password);
  if (!matchSpecialCharacter) {
    result += '\n' + 'password_validation_special_character'.tr;
  }
  // Check number
  final matchNumber = RegExp(r'(?=.*?[0-9])').hasMatch(password);
  if (!matchNumber) {
    result += '\n' + 'password_validation_number'.tr;
  }
  return result.trim();
}

/// [dateTime]: '2022-06-24T10:26:28.000000Z'</br>
/// Returns the new flag
String formatDate(String? dateTime) {
  if (dateTime != null) {
    final dt = DateTime.parse(dateTime);
    DateFormat format = DateFormat('yyyy/MM/dd');
    return format.format(dt);
  } else {
    return '';
  }
}

final currencyFormatter = NumberFormat('#,##0', 'en_US');

String formatIntMoney(int? money) {
  if (money != null) {
    return formatMoney(currencyFormatter.format(money));
  } else {
    return '';
  }
}

String formatMoney(String? money) {
  return '$money ${'yen'.tr}';
}

class Languages {
  static const EN = {'key': 'en', 'value': 'English - 英語'};
  static const VI = {'key': 'vi', 'value': 'Tiếng Việt - ベトナム語'};
}

String? fetchLanguageTitleByCode(String? langCode) {
  switch (langCode) {
    case 'en':
      return Languages.EN['value'];
    case 'vi':
      return Languages.VI['value'];
    default:
      return null;
  }
}

Language fetchLanguageByCode(langCode) {
  switch (langCode) {
    case 'en':
      return Language.english;
    case 'vi':
      return Language.vietnamese;
    default:
      return Language.english;
  }
}

String formatDoingTaskTime(timeRemaining) {
  int h = (timeRemaining / 3600).floor();
  int min;
  if (h > 0) {
    min = ((timeRemaining - h * 3600) / 60).floor();
  } else {
    min = (timeRemaining / 60).floor();
  }
  int sec = timeRemaining % 60;
  String hour = h.toString().length <= 1 ? "0$h" : "$h";
  String minute = min.toString().length <= 1 ? "0$min" : "$min";
  String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
  return "$hour:$minute:$second";
}
