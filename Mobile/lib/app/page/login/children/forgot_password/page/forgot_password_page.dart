import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/forgot_password/controller/forgot_password_controller.dart';
import 'package:plat_app/app/page/login/children/forgot_password/controller/forgot_password_datasource.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/app/widgets/app_auth_header.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:plat_app/development.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final variant = dotenv.env['VARIANT'];

  final TextEditingController emailController = TextEditingController();

  final emailValidationMessage = ''.obs;
  final FocusNode _nodeEmail = FocusNode();
  bool isShowError = false;
  final _isError = true.obs;
  final ForgotPasswordController forgotPasswordController = Get.find();
  late Worker forgotPasswordWorker;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      _validate(false);
    });

    devDebugMock(
      () {
        emailController.text = mockForgotPasswordEmail;
      },
    );

    forgotPasswordWorker =
        ever(forgotPasswordController.forgotPasswordData, (dynamic callback) {
      if (forgotPasswordController.isRequestError()) {
        switch (forgotPasswordController.errorCode.value) {
          case ErrorCode.TIME_INVALID:
            showCustomDialog(
                context, 'we_have_sent_an_email_please_check_your_email'.tr);
            break;
          default:
            showCustomDialog(context, callback.message ?? '');
        }
      } else if (forgotPasswordController.isRequestSuccess()) {
        Get.toNamed(Routes.alertForgotPassword,
            arguments: emailController.text);
      }
    });
  }

  void showForgotPasswordFail(String? message) {
    return GetXDefaultBottomSheet.errorBottomSheet(
      title: 'login_failed'.tr,
      text: Text(
        message ?? 'username_or_password_is_incorrect'.tr,
        style: text16_625F5C_400,
        textAlign: TextAlign.center,
      ),
    );
  }

  void showCustomDialog(BuildContext context, String? message) {
    showDialog(
      barrierColor: color565C6E.withOpacity(0.95),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(dimen24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'login_failed'.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: color1D93E3,
                    ),
                  ),
                  verticalSpace10,
                  Expanded(
                    child: Text(
                      message ?? ''.tr,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: color1D93E3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: border6,
                        color: colorPrimary,
                        boxShadow: [
                          BoxShadow(
                              color: colorPrimary.withOpacity(0.5),
                              blurRadius: dimen5,
                              offset: const Offset(0, 3)),
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Got it',
                          style: TextStyle(
                            color: colorWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget emailWidget = Obx(() {
      return AppInputView(
        label: 'registered_email_address'.tr,
        isRequired: true,
        controller: emailController,
        hint: 'enter_your_email'.tr,
        validationMessage: emailValidationMessage.value,
        autoFocus: true,
        textInputAction: TextInputAction.next,
        onSubmitted: (value) {
          isShowError = true;
          _validate(false);
        },
        keyboardType: TextInputType.emailAddress,
        nodeTextField: _nodeEmail,
      );
    });

    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
          child: Stack(
        children: [
          SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                Get.focusScope?.unfocus();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: dimen16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AppAuthHeader(
                      title: 'forgot_password'.tr,
                    ),
                    emailWidget,
                    verticalSpace40,
                    Row(
                      children: [
                        Expanded(
                            child: AppButton(
                          onTap: () {
                            Get.back();
                          },
                          title: 'cancel'.tr,
                          isPrimaryStyle: false,
                          disableBackgroundColor: colorWhite,
                        )),
                        horizontalSpace8,
                        Obx(() => Expanded(
                                child: AppButton(
                              title: 'reset_password'.tr,
                              horizontalPadding: dimen4,
                              onTap: () {
                                isShowError = true;
                                _validate(true);
                              },
                              isEnable: !_isError.value,
                            )))
                      ],
                    ),
                    verticalSpace120
                  ],
                ),
              ),
            ),
          ),
          Obx(() => (forgotPasswordController.isRequesting())
              ? const FullScreenProgress()
              : Container())
        ],
      )),
    );
  }

  @override
  void dispose() {
    _nodeEmail.dispose();
    emailController.dispose();
    forgotPasswordWorker.dispose();
    super.dispose();
  }

  void _validate(bool isNavigate) {
    final email = emailController.text.trim();
    var isError = false;
    bool emailValid = emailRegex.hasMatch(email);
    // Validate email
    if (email.isBlank == true || !emailValid) {
      if (isShowError) {
        emailValidationMessage.value = 'invalid_email'.tr;
      }
      isError = true;
    } else {
      emailValidationMessage.value = '';
    }

    if (isError) {
      _isError.value = true;
      return;
    } else {
      emailValidationMessage.value = '';
      _isError.value = false;
    }
    if (isNavigate) {
      Get.focusScope?.unfocus();
      _forgotPassword(email);
    }
  }

  void _forgotPassword(email) {
    forgotPasswordController.forgotPassword(email);
  }
}
