part of 'change_password_page.dart';

extension ChangePasswordPageAction on _ChangePasswordPageState {
  void _validate(bool isNavigate) {
    final newPassword = newPasswordController.text.trim();
    var isError = false;

    var testErrorList = [
      _validateNewPassword(),
      _validateConfirmPassword(),
    ];

    if (testErrorList.contains(true)) {
      isError = true;
    }

    if (isError) {
      _isError.value = true;
      return;
    } else {
      newPasswordValidationMessage.value = '';
      confirmPasswordValidationMessage.value = '';
      _isError.value = false;
    }
    if (isNavigate) {
      Get.focusScope?.unfocus();
      _changePassword(newPassword);
    }
  }

  bool _validateNewPassword() {
    final newPassword = newPasswordController.text.trim();
    var isError = false;
    if (!validatePassword(newPassword)) {
      if (isShowError) {
        newPasswordValidationMessage.value =
            validatePasswordMessage(newPassword);
      }
      isError = true;
    } else {
      newPasswordValidationMessage.value = '';
    }
    return isError;
  }

  bool _validateConfirmPassword() {
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    var isError = false;
    if (confirmPassword != newPassword) {
      if (isShowError) {
        confirmPasswordValidationMessage.value = 'invalid_password'.tr;
      }
      isError = true;
    } else {
      confirmPasswordValidationMessage.value = '';
    }
    return isError;
  }

  void _changePassword(newPassword) {
    changePasswordController.postChangePassword(newPassword);
  }

  void onChangePasswordSuccess() {
    GetXDefaultBottomSheet.rawBottomSheet(Container(
      margin: const EdgeInsets.all(dimen16),
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
            title: 'back_to_task_pool'.tr,
            isPrimaryStyle: false,
            onTap: () {
              Get.offAllNamed(Routes.home);
            },
          ),
          verticalSpace24,
        ],
      ),
    ));
  }
}
