import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum BottomSheetType { error, warning }

class GetXDefaultBottomSheet {
  static void rawBottomSheet(content, {double? height}) {
    Get.bottomSheet(
      Container(
          height: height,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(dimen24),
                  topRight: Radius.circular(dimen24)),
              color: colorWhite),
          child: content),
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
    );
  }

  static void errorBottomSheet({
    required String title,
    required Widget text,
    List<Widget>? buttons,
    List<Widget>? bottomWidgets,
  }) {
    return GetXDefaultBottomSheet.rawBottomSheet(
      SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(dimen16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: text22_32302D_700,
                  textAlign: TextAlign.center,
                ),
                verticalSpace34,
                Image.asset(
                  getAssetImage(AssetImagePath.ic_error),
                  width: 54,
                  height: 76,
                ),
                verticalSpace34,
                text,
                verticalSpace24,
                buttons == null
                    ? AppButton(
                        title: 'try_again'.tr,
                        onTap: () {
                          Get.back();
                        },
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buttons,
                      ),
                verticalSpace16,
                bottomWidgets != null
                    ? Column(
                        children: bottomWidgets,
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }

  static void successBottomSheet({
    required String title,
    required Widget text,
    List<Widget>? buttons,
    List<Widget>? bottomWidgets,
  }) {
    return GetXDefaultBottomSheet.rawBottomSheet(
      SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(dimen16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: text22_32302D_700,
                  textAlign: TextAlign.center,
                ),
                verticalSpace34,
                Image.asset(
                  getAssetImage(AssetImagePath.ic_success),
                  width: dimen96,
                  height: dimen96,
                ),
                verticalSpace34,
                text,
                verticalSpace24,
                buttons == null
                    ? AppButton(
                        title: 'close'.tr,
                        onTap: () {
                          Get.back();
                        },
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buttons,
                      ),
                verticalSpace16,
                bottomWidgets != null
                    ? Column(
                        children: bottomWidgets,
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }

  static void warningBottomSheet({
    required String title,
    required Widget text,
    List<Widget>? buttons,
    List<Widget>? bottomWidgets,
  }) {
    return GetXDefaultBottomSheet.rawBottomSheet(
      SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.all(dimen16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: text22_32302D_700,
                  textAlign: TextAlign.center,
                ),
                verticalSpace34,
                Image.asset(
                  getAssetImage(AssetImagePath.ic_warning),
                  width: 76,
                  height: 94,
                ),
                verticalSpace34,
                text,
                verticalSpace24,
                buttons == null
                    ? AppButton(
                        title: 'try_again'.tr,
                        onTap: () {
                          Get.back();
                        },
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: buttons,
                      ),
                verticalSpace16,
                bottomWidgets != null
                    ? Column(
                        children: bottomWidgets,
                      )
                    : Container(),
              ],
            )),
      ),
    );
  }
}
