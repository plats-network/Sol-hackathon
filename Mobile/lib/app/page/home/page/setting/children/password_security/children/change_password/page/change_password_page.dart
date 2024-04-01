import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/children/change_password/controller/change_password_controller.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';

part 'change_password_page_action.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  bool isShowError = false;
  final _isError = true.obs;
  final ChangePasswordController changePasswordController = Get.find();

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
        onChangePasswordSuccess();
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
        autoFocus: true,
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
          // Validate
          isShowError = true;
          _validate(true);
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
            // unfocus when pressing out textinput
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.focusScope?.unfocus();
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: colorWhite,
                ),
                padding: const EdgeInsets.fromLTRB(
                    dimen16, dimen0, dimen16, dimen16),
                child: Column(
                  children: [
                    Expanded(
                        child: SingleChildScrollView(
                      padding: const EdgeInsets.only(top: dimen16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'password_to_secure'.tr,
                            style: text14_625F5C_400,
                          ),
                          verticalSpace30,
                          newPasswordWidget,
                          verticalSpace24,
                          confirmPasswordWidget,
                          verticalSpace24,
                        ],
                      ),
                    )),
                    GestureDetector(
                      onTap: () {
                        isShowError = true;
                        _validate(true);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        decoration: BoxDecoration(
                          borderRadius: border8,
                          color: colorPrimary,
                          boxShadow: [
                            BoxShadow(
                                color: colorPrimary.withOpacity(0.5),
                                blurRadius: dimen5,
                                offset: const Offset(0, 2)),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            'send'.tr,
                            style: const TextStyle(
                              color: colorWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    verticalSpace24,
                  ],
                ),
              ),
            )),
        Obx(() => (changePasswordController.isChangingPassword()
            ? const FullScreenProgress()
            : Container())),
      ],
    );
  }
}
