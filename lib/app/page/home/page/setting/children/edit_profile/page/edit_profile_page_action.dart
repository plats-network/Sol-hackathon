part of 'edit_profile_page.dart';

extension EditProfilePageAction on _EditProfilePageState {
  void _validate(bool isNavigate) {
    final fullName = fullNameController.text.trim();
    final email = emailController.text.trim();
    final gender = sex.value?.key;
    final birth = dateOfBirth.value?.replaceAll('/', '-');
    var isError = false;

    var testErrorList = [
      _validateFullName(fullName),
      _validateEmail(email),
    ];

    if (testErrorList.contains(true)) {
      isError = true;
    }

    if (isError) {
      _isError.value = true;
      return;
    } else {
      fullNameValidationMessage.value = '';
      emailValidationMessage.value = '';
      _isError.value = false;
    }
    if (isNavigate) {
      Get.focusScope?.unfocus();
      _updateProfile(fullName, email, gender, birth);
    }
  }

  bool _validateFullName(String? fullName) {
    var isError = false;
    if (fullName.isBlank == true) {
      if (isShowError) {
        fullNameValidationMessage.value = 'please_enter_your_name'.tr;
      }
      isError = true;
    } else {
      fullNameValidationMessage.value = '';
    }
    return isError;
  }

  bool _validateEmail(String? email) {
    var isError = false;
    if (email?.isNotEmpty == true) {
      bool emailValid = emailRegex.hasMatch(email!);
      if (emailValid == false) {
        if (isShowError) {
          emailValidationMessage.value = 'invalid_email'.tr;
        }
        isError = true;
      } else {
        emailValidationMessage.value = '';
      }
    } else {
      if (isShowError) {
        emailValidationMessage.value = 'invalid_email'.tr;
      }
      isError = true;
    }
    return isError;
  }

  void _updateProfile(
      String fullName, String? email, int? gender, String? birth) {
    editProfileController.patchUpdateProfile(fullName, email, gender, birth);
  }

  void onUpdateProfileSuccess() {
    GetXDefaultBottomSheet.rawBottomSheet(Container(
      margin: const EdgeInsets.all(dimen16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'edit_profile'.tr,
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
            'your_information_has_been_updated'.tr,
            style: text14_32302D_400,
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

  void onBackButtonClick() {
    if (!_isError.value) {
      // Has changed, show warning dialog
      GetXDefaultBottomSheet.warningBottomSheet(
          title: 'leave_app'.tr,
          text: Text(
            'change_you_made'.tr,
            style: text16_32302D_400,
          ),
          buttons: [
            Expanded(
              child: AppButton(
                title: 'leave'.tr,
                isPrimaryStyle: false,
                onTap: () {
                  Get.back();
                  Get.back();
                },
              ),
            ),
            horizontalSpace8,
            Expanded(
              child: AppButton(
                title: 'cancel'.tr,
                onTap: () async {
                  Get.back();
                },
              ),
            )
          ]);
    } else {
      // Not changed, just back
      Get.back();
    }
  }
}
