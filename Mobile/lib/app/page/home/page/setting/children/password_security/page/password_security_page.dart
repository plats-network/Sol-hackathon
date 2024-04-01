import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/controller/password_security_controller.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class PasswordSecurityPage extends StatefulWidget {
  const PasswordSecurityPage({Key? key}) : super(key: key);

  @override
  State<PasswordSecurityPage> createState() => _PasswordSecurityPageState();
}

class _PasswordSecurityPageState extends State<PasswordSecurityPage> {
  final passwordSecurityController = Get.find<PasswordSecurityController>();
  late Worker _deleteAccountWorker;
  final authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    _deleteAccountWorker = ever(passwordSecurityController.deleteAccountData,
        (NetworkResource callback) {
      if (callback.isSuccess()) {
        authController.logout();
      } else {
        GetXDefaultBottomSheet.errorBottomSheet(
            title: 'error'.tr,
            text: Text('fail_to_delete_account'.tr, style: text14_32302D_400));
      }
    });
  }

  @override
  void dispose() {
    _deleteAccountWorker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final changePasswordWidget = passwordSecuritySection(
      text: 'change_password'.tr,
      onTap: () {
        Get.toNamed(Routes.changePassword);
      },
    );
    final forgetPasswordWidget = passwordSecuritySection(
      text: 'forgot_password'.tr,
      onTap: () {
        Get.toNamed(Routes.forgotPassword);
      },
    );
    // delete account
    final deleteAccountWidget = passwordSecuritySection(
      text: 'delete_account'.tr,
      textStyle: text16_error_600,
      onTap: () {
        GetXDefaultBottomSheet.warningBottomSheet(
            title: 'delete_account'.tr,
            text: Text(
              'delete_account_help_text'.tr,
              textAlign: TextAlign.center,
              style: text14_32302D_400,
            ),
            buttons: [
              Expanded(
                child: AppButton(
                  title: 'yes'.tr,
                  onTap: () async {
                    passwordSecurityController.deleteAccount();
                    Get.back();
                  },
                  isPrimaryStyle: false,
                ),
              ),
              horizontalSpace8,
              Expanded(
                child: AppButton(
                  title: 'no'.tr,
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ]);
      },
      showDivider: false,
    );

    return CommonAppBarPage(
        title: 'password_and_security'.tr,
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: colorFAF9F9,
                        blurRadius: dimen8,
                      ),
                    ],
                    border: Border(
                        bottom: BorderSide(width: dimen1, color: colorF3F1F1)),
                  ),
                  height: dimen8,
                ),
                Container(
                  decoration: BoxDecoration(color: colorWhite),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: colorFAF9F9,
                              blurRadius: dimen8,
                            ),
                          ],
                          border: Border(
                              bottom: BorderSide(
                                  width: dimen1, color: colorF3F1F1)),
                        ),
                        child: Column(
                          children: [
                            // changePasswordWidget,
                            // forgetPasswordWidget,
                            deleteAccountWidget
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Obx(() => passwordSecurityController.isDeleteAccountLoading()
                ? FullScreenProgress()
                : Container()),
          ],
        ));
  }

  Widget passwordSecuritySection(
      {required String text,
      required VoidCallback onTap,
      bool showDivider = true,
      TextStyle? textStyle}) {
    return Material(
      color: colorWhite,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: dimen12),
          margin: EdgeInsets.fromLTRB(dimen16, dimen16, dimen16, dimen16),
          decoration: BoxDecoration(
              border: showDivider
                  ? Border(
                      bottom: BorderSide(width: dimen1, color: colorF3F1F1))
                  : null),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: textStyle ?? text16_32302D_400,
                ),
              ),
              Image.asset(
                getAssetImage(AssetImagePath.ic_caret_right),
                width: dimen24,
                height: dimen24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
