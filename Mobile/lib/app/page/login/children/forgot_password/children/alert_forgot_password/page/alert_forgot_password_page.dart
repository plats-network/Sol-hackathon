import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/controller/alert_forgot_password_controller.dart';
import 'package:plat_app/app/widgets/app_auth_header.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class AlertForgotPasswordPage extends StatefulWidget {
  const AlertForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<AlertForgotPasswordPage> createState() =>
      AlertForgotPasswordPageState();
}

class AlertForgotPasswordPageState extends State<AlertForgotPasswordPage> {
  final variant = dotenv.env['VARIANT'];

  final TextEditingController emailController = TextEditingController();

  final email = Get.arguments ?? '';
  final emailValidationMessage = ''.obs;
  final isShowError = false.obs;

  final AlertForgotPasswordController alertForgotPasswordController =
      Get.find();
  late Worker forgotPasswordWorker;
  late Worker resendOtpWorker;

  static int TOTAL_FIELDS = 6;
  static const int TIME_OUT = 600;
  final OtpFieldController otpController = OtpFieldController();
  late Timer _timer;
  int _start = TIME_OUT;
  final otpText = ''.obs;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      otpController.setFocus(0);
    });

    forgotPasswordWorker =
        ever(alertForgotPasswordController.alertForgotPasswordData,
            (NetworkResource callback) {
      if (alertForgotPasswordController.isVerifyRequestError()) {
        showCustomDialog(
            context, 'error'.tr, callback.message?.trim() ?? 'invalid_otp'.tr);
      } else if (alertForgotPasswordController.isVerifyRequestSuccess()) {
        Get.offAndToNamed(Routes.otpChangePassword,
            arguments: {'email': email, 'code': otpText.value});
      }
    });

    resendOtpWorker = ever(alertForgotPasswordController.resendOtpData,
        (NetworkResource callback) {
      if (alertForgotPasswordController.isResendOtpRequestError()) {
        showCustomDialog(
            context, 'error'.tr, callback.message?.trim() ?? 'invalid_otp'.tr);
      } else if (alertForgotPasswordController.isResendOtpRequestSuccess()) {
        showCustomDialog(context, 'success'.tr,
            callback.data.message?.trim() ?? 'otp_sent'.tr);
      }
    });
  }

  void showRequestFail(String? message) {
    return GetXDefaultBottomSheet.errorBottomSheet(
      title: 'error'.tr,
      text: Text(
        message ?? '',
        style: text16_625F5C_400,
        textAlign: TextAlign.center,
      ),
    );
  }

  void showCustomDialog(BuildContext context, String? title, String? message) {
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
                    title ?? '',
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

  void showRequestSuccess(String? message) {
    return GetXDefaultBottomSheet.successBottomSheet(
      title: 'success'.tr,
      text: Text(
        message ?? '',
        style: text16_625F5C_400,
        textAlign: TextAlign.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                    //TOO: OTP Fields
                    Text('please_enter_the_otp'.tr, style: text14_32302D_400),
                    verticalSpace24,

                    OTPTextField(
                      controller: otpController,
                      length: TOTAL_FIELDS,
                      width: MediaQuery.of(context).size.width,
                      fieldWidth: 48,
                      style: text16_171716_400,
                      textFieldAlignment: MainAxisAlignment.spaceAround,
                      spaceBetween: 10,
                      // hasError: true,
                      fieldStyle: FieldStyle.box,
                      outlineBorderRadius: 4,
                      onChanged: (otp) {
                        otpText.value = otp;
                      },
                      onCompleted: (val) {
                        onConfirmTapped(val);
                      },
                    ),

                    verticalSpace16,
                    //Have not received yet?  Resend (2:59)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                              text: '${'have_not_received_yet'.tr} ',
                              style: text14_625F5C_400,
                              children: [
                                TextSpan(
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        onResendPressed();
                                      },
                                    text: 'resend'.tr,
                                    style: text14_177FE2_400,
                                    children: [
                                      if (_start > 0)
                                        TextSpan(
                                          text: humanizeTime,
                                        )
                                    ]),
                              ]),
                        ),
                      ],
                    ),
                    verticalSpace120
                  ],
                ),
              ),
            ),
          ),
          Obx(() => (alertForgotPasswordController.isRequestingResend() ||
                  alertForgotPasswordController.isRequestingVerify())
              ? const FullScreenProgress()
              : Container())
        ],
      )),
    );
  }

  String get humanizeTime =>
      ' ${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}';

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    forgotPasswordWorker.dispose();
    resendOtpWorker.dispose();
    _timer.cancel();
  }

  void _triggerResendCode(email) {
    alertForgotPasswordController.triggerResendCode(email);
  }

  void onResendPressed() {
    if (_start > 0) {
      showCustomDialog(context, 'error'.tr, 'please_wait'.tr);
      return;
    }

    _triggerResendCode(email);

    setState(() {
      _start = TIME_OUT;
    });

    startTimer();
  }

  void onConfirmTapped(String val) async {
    alertForgotPasswordController.verifyCode(email, val);

    otpController.clear();
  }
}
