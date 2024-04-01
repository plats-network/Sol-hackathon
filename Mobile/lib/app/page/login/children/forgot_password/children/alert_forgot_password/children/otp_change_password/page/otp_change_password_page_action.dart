part of 'otp_change_password_page.dart';

extension OtpChangePasswordPageAction on _OTPChangePasswordPageState {
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
      _changePassword(newPassword, _email, _code);
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

  void _changePassword(String newPassword, String email, String code) {
    changePasswordController.postChangePassword(newPassword, email, code);
  }
}
