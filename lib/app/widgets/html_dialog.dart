import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/app/widgets/app_button.dart';

class HtmlDialog {
  static Future notifyDialog({title, middleText}) {
    return Get.defaultDialog(
        title: title,
        middleText: middleText,
        content: Html(data: middleText),
        confirmTextColor: colorWhite,
        buttonColor: colorPrimary,
        contentPadding: EdgeInsets.all(dimen10),
        titlePadding: EdgeInsets.all(dimen10),
        radius: dimen8,);
  }

  static void alertDialog({title, middleText, textConfirm, onConfirm}) {
    Get.defaultDialog(
        title: title,
        middleText: middleText,
        content: Container(
          height: dimen300,
          child: SingleChildScrollView(
            child: Html(data: middleText),
          ),
        ),
        textConfirm: textConfirm,
        confirmTextColor: colorWhite,
        onConfirm: () {
          Get.back();
          (onConfirm ?? () {})();
        },
        buttonColor: colorPrimary,
        contentPadding: EdgeInsets.all(dimen10),
        titlePadding: EdgeInsets.all(dimen10),
        confirm: Container(
          margin: EdgeInsets.symmetric(horizontal: dimen60, vertical: dimen10),
          child: AppButton(
            onTap: () {
              Get.back();
              (onConfirm ?? () {})();
            },
            title: textConfirm ?? 'close'.tr,
          ),
        ),
        radius: dimen8);
  }
}
