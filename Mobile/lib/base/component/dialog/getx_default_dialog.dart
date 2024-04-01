import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class GetXDefaultDialog {
  static Future notifyDialog(
      {required String title, required String middleText}) {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    return Get.defaultDialog(
      title: title,
      middleText: middleText,
      radius: dimen8,
      titlePadding:
          EdgeInsets.only(top: dimen12, left: dimen16, right: dimen16),
      contentPadding: EdgeInsets.only(
          top: dimen8, bottom: dimen4, left: dimen16, right: dimen16),
    );
  }

  static Future alertDialog(
      {required String title,
      required String middleText,
      required String textConfirm,
      onConfirm}) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    return await Get.defaultDialog(
        title: title,
        middleText: middleText,
        titlePadding: EdgeInsets.all(dimen16),
        contentPadding:
            EdgeInsets.only(left: dimen16, right: dimen16, bottom: dimen16),
        confirm: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              title: textConfirm,
              horizontalPadding: dimen20,
              onTap: () {
                Get.back();
                (onConfirm ?? () {})();
              },
            ),
          ],
        ),
        confirmTextColor: colorWhite,
        radius: dimen8);
  }

  static Future successDialog(
      {required String title,
      required String middleText,
      textConfirm,
      onConfirm,
      textStyle}) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    return await Get.defaultDialog(
        title: title,
        titleStyle: textStyle,
        middleText: middleText,
        titlePadding: const EdgeInsets.all(dimen16),
        contentPadding: const EdgeInsets.only(
            left: dimen16, right: dimen16, bottom: dimen16),
        confirm: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppButton(
              title: textConfirm,
              horizontalPadding: dimen20,
              onTap: () {
                Get.back();
                (onConfirm ?? () {})();
              },
            ),
          ],
        ),
        confirmTextColor: colorWhite,
        radius: dimen8);
  }

  static Future defaultDialog(
      {required String title,
      required String middleText,
      textConfirm,
      onConfirm,
      textCancel,
      onCancel,
      onWillPop}) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    return await Get.defaultDialog(
        title: title,
        middleText: middleText,
        contentPadding: EdgeInsets.all(dimen16),
        titlePadding: EdgeInsets.all(dimen16),
        actions: [
          Container(
            width: Get.size.width,
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    title: textCancel,
                    isPrimaryStyle: false,
                    onTap: () {
                      Get.back();
                      (onCancel ?? () {})();
                    },
                  ),
                ),
                horizontalSpace16,
                Expanded(
                  child: AppButton(
                      title: textConfirm,
                      isPrimaryStyle: true,
                      onTap: () {
                        Get.back();
                        (onConfirm ?? () {})();
                      }),
                ),
              ],
            ),
          )
        ],
        radius: dimen16);
  }

  static void demoDefaultDialog() {
    final language = Rx<String>('english');
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.defaultDialog(
      title: 'Choose a language',
      content: Column(
        children: <Widget>[
          RadioListTile(
            title: const Text('Tiếng Việt'),
            value: 'vietnamese',
            groupValue: language.value,
            onChanged: (String? value) {
              if (value != null) {
                Get.back();
                language.value = value;
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('English'),
            value: 'english',
            groupValue: language.value,
            onChanged: (String? value) {
              if (value != null) {
                Get.back();
                language.value = value;
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('Japanese'),
            value: 'japanese',
            groupValue: language.value,
            onChanged: (String? value) {
              if (value != null) {
                Get.back();
                language.value = value;
              }
            },
          ),
        ],
      ),
      radius: dimen8,
    );
  }
}
