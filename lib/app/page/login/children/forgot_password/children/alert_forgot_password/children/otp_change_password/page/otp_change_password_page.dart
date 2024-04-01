import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/children/change_password/controller/change_password_controller.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/children/otp_change_password/controller/otp_change_password_controller.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:get_storage/get_storage.dart';

part 'otp_change_password_page_action.dart';

class OTPChangePasswordPage extends StatefulWidget {
  const OTPChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<OTPChangePasswordPage> createState() => _OTPChangePasswordPageState();
}

class _OTPChangePasswordPageState extends State<OTPChangePasswordPage> {
  bool isShowError = false;
  final _isError = true.obs;
  final OtpChangePasswordController changePasswordController = Get.find();

  final TextEditingController newPasswordController = TextEditingController();
  final newPasswordValidationMessage = ''.obs;
  final hideNewPassword = true.obs;
  final FocusNode _nodeNewPassword = FocusNode();

  final TextEditingController confirmPasswordController =
      TextEditingController();
  final confirmPasswordValidationMessage = ''.obs;
  final hideConfirmPassword = true.obs;
  final FocusNode _nodeConfirmPassword = FocusNode();
  late Worker changePasswordWorker;
  final String _email = Get.arguments['email'];
  final String _code = Get.arguments['code'];
   final storage = GetStorage();

  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(() {
      _validate(false);
    });
    confirmPasswordController.addListener(() {
      _validate(false);
    });
    changePasswordWorker = ever(changePasswordController.changePasswordData,
        (NetworkResource data) {
      if (data.isSuccess()) {
        GetXDefaultBottomSheet.rawBottomSheet(Container(
          margin: EdgeInsets.all(dimen16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'change_password'.tr,
                style: text22_32302D_700,
              ),
              verticalSpace24,
              Image.asset(
                getAssetImage(AssetImagePath.ic_success),
                width: dimen96,
                height: dimen96,
              ),
              verticalSpace24,
              Text(
                'your_password_changed'.tr,
                style: text16_32302D_400,
              ),
              verticalSpace24,
              AppButton(
                title: storage.read(keyAccessToken) != null ? 'back_to_task_pool'.tr : 'back_to_login'.tr,
                isPrimaryStyle: false,
                onTap: () {
                  Get.offAllNamed(Routes.login, arguments: {
                    'email': _email,
                  });
                },
              ),
              verticalSpace24,
            ],
          ),
        ));
      }
    });
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    _nodeNewPassword.dispose();
    confirmPasswordController.dispose();
    _nodeConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget newPasswordWidget = Obx(() {
      return AppInputView(
        controller: newPasswordController,
        hint: 'enter_new_password'.tr,
        obscureText: hideNewPassword.value,
        label: 'enter_new_password'.tr,
        isRequired: true,
        suffixImage: (hideNewPassword.value)
            ? InkWell(
                child: Image(
                  image: AssetImage(getAssetImage(AssetImagePath.eye_disabled)),
                  width: dimen24,
                  height: dimen24,
                ),
                onTap: () {
                  hideNewPassword.value = !hideNewPassword.value;
                })
            : InkWell(
                child: Image(
                  image: AssetImage(getAssetImage(AssetImagePath.eye)),
                  width: dimen24,
                  height: dimen24,
                ),
                onTap: () {
                  hideNewPassword.value = !hideNewPassword.value;
                }),
        validationMessage: newPasswordValidationMessage.value,
        textInputAction: TextInputAction.next,
        onSubmitted: (value) {
          _nodeConfirmPassword.requestFocus();
        },
        nodeTextField: _nodeNewPassword,
      );
    });

    Widget confirmPasswordWidget = Obx(() {
      return AppInputView(
        controller: confirmPasswordController,
        hint: 'confirm_new_password'.tr,
        obscureText: hideConfirmPassword.value,
        label: 'confirm_new_password'.tr,
        isRequired: true,
        suffixImage: (hideConfirmPassword.value)
            ? InkWell(
                child: Image(
                  image: AssetImage(getAssetImage(AssetImagePath.eye_disabled)),
                  width: dimen24,
                  height: dimen24,
                ),
                onTap: () {
                  hideConfirmPassword.value = !hideConfirmPassword.value;
                })
            : InkWell(
                child: Image(
                  image: AssetImage(getAssetImage(AssetImagePath.eye)),
                  width: dimen24,
                  height: dimen24,
                ),
                onTap: () {
                  hideConfirmPassword.value = !hideConfirmPassword.value;
                }),
        validationMessage: confirmPasswordValidationMessage.value,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) {
          // Validate
          isShowError = true;
          _validate(true);
        },
        nodeTextField: _nodeConfirmPassword,
      );
    });

    return Stack(
      children: [
        CommonAppBarPage(
            title: 'change_password'.tr,
            child: Container(
              decoration: BoxDecoration(
                color: colorWhite,
              ),
              padding: EdgeInsets.fromLTRB(dimen16, dimen0, dimen16, dimen16),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: dimen16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpace24,
                        newPasswordWidget,
                        verticalSpace24,
                        confirmPasswordWidget,
                        verticalSpace24,
                      ],
                    ),
                  )),
                  Obx(() {
                    return AppButton(
                      title: 'send'.tr,
                      onTap: () {
                        // Validate
                        isShowError = true;
                        _validate(true);
                      },
                      isEnable: !_isError.value,
                    );
                  })
                ],
              ),
            )),
        Obx(() => (changePasswordController.isChangingPassword()
            ? FullScreenProgress()
            : Container())),
      ],
    );
  }
}
