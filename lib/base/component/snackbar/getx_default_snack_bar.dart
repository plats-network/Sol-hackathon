import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class GetXDefaultSnackBar {
  static successSnackBar(
      {String? title,
      required String message,
      duration = const Duration(seconds: 3),
      snackPosition: SnackPosition.TOP}) {
    return Get.rawSnackbar(
        icon: Container(
          decoration: BoxDecoration(shape: BoxShape.circle, color: colorWhite,),
          child: Center(
            child: Image(
              image:
                  AssetImage(getAssetImage(AssetImagePath.check)),
              width: dimen20,
              height: dimen20,
              color: color27AE60,
            ),
          ),
        ),
        title: title,
        message: message,
        duration: duration,
        snackPosition: snackPosition,
        backgroundColor: color27AE60,
        padding: EdgeInsets.symmetric(horizontal: dimen22, vertical: dimen16),
        margin: EdgeInsets.symmetric(horizontal: dimen4, vertical: dimen2),
        borderRadius: dimen8,
      );
  }

  static errorSnackBar(
      {String? title,
      String? message,
      duration = const Duration(seconds: 3),
      backgroundColor,
      snackPosition: SnackPosition.TOP}) {
    return Get.rawSnackbar(
        icon: Image(
          image: AssetImage(getAssetImage(AssetImagePath.close_ring)),
          width: dimen20,
          height: dimen20,
        ),
        // message: message,
        messageText: Text(message ?? '', style: text14_white_400),
        duration: duration,
        snackPosition: snackPosition,
        backgroundColor: backgroundColor ??colorDA656A,
        padding: EdgeInsets.symmetric(horizontal: dimen22, vertical: dimen16),
        margin: EdgeInsets.symmetric(horizontal: dimen4, vertical: dimen2),
        borderRadius: dimen8,
      );
  }

  static rawSnackBar(
      {required String title,
      duration = const Duration(seconds: 3),
      widget = const SizedBox(),
      snackPosition: SnackPosition.BOTTOM}) {
    return Get.rawSnackbar(
      titleText: Padding(
        padding: const EdgeInsets.only(top: dimen8),
        child: Text(title,
            style: text22_32302D_700, textAlign: TextAlign.center, maxLines: 1),
      ),
      backgroundColor: colorWhite,
      overlayColor: colorSnackbarOverlay,
      overlayBlur: 1,
      animationDuration: const Duration(milliseconds: 500),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: 24,
      messageText: widget,
      duration: duration,
      snackPosition: snackPosition,
    );
  }

  static defaultSnackBar(
      {title = '',
      message = '',
      duration = const Duration(seconds: 2),
      snackPosition: SnackPosition.BOTTOM}) {
    return Get.rawSnackbar(
        icon: Image(
          image: AssetImage(getAssetImage(AssetImagePath.icon_bell)),
          width: dimen28,
          height: dimen28,
        ),
        // message: message,
        messageText: Text(message, style: text14_white_400),
        duration: duration,
        snackPosition: snackPosition,
        backgroundColor: color625F5C);
  }

  static fcmNotiSnackbar(
      {required String title, required String text, VoidCallback? onTap}) {
    return Get.rawSnackbar(
      backgroundColor: colorWhite,
      animationDuration: const Duration(milliseconds: 500),
      snackStyle: SnackStyle.FLOATING,
      borderRadius: dimen16,
      messageText: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: text14_32302D_600,
          ),
          Text(
            text,
            style: text14_32302D_400,
          ),
        ],
      ),
      duration: Duration(seconds: 3),
      snackPosition: SnackPosition.TOP,
      onTap: (GetSnackBar snack) {
        Get.back();
        onTap?.call();
      },
    );
  }
}
