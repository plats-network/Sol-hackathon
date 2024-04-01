import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/login/children/register/controller/register_controller.dart';
import 'package:plat_app/app/page/login/children/register/controller/register_datasource.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/button/base_checkbox.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/development.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final variant = dotenv.env['VARIANT'];

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  bool isTermsChecked = false;

  final fullNameValidationMessage = ''.obs;
  final emailValidationMessage = ''.obs;
  final passwordValidationMessage = ''.obs;
  final confirmPasswordValidationMessage = ''.obs;
  final isTermsCheckedValidationMessage = ''.obs;
  bool remember = false;
  final hidePassword = true.obs;
  final FocusNode _nodeFullName = FocusNode();
  final FocusNode _nodeEmail = FocusNode();
  final FocusNode _nodePassword = FocusNode();
  final FocusNode _nodeConfirmPassword = FocusNode();
  bool isShowError = false;
  final _isError = true.obs;
  final RegisterController registerController = Get.find();
  final AuthController authController = Get.find();
  late Worker registerWorker;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      _validate(false);
    });
    passwordController.addListener(() {
      _validate(false);
    });
    fullNameController.addListener(() {
      _validate(false);
    });
    confirmPasswordController.addListener(() {
      _validate(false);
    });

    devDebugMock(() {
      fullNameController.text = mockRegisterAccount['fullName']!;
      emailController.text = mockRegisterAccount['email']!;
      passwordController.text = mockRegisterAccount['password']!;
      confirmPasswordController.text = mockRegisterAccount['confirmPassword']!;
    });

    registerWorker = ever(
      registerController.registerData,
      (dynamic callback) {
        if (registerController.isRegisterError()) {
          // showRegisterFail(callback.message ?? 'error'.tr);
          showCustomDialog(context, callback.message ?? 'error'.tr);
        } else if (registerController.isRegisterSuccess()) {
          OverlayState? state = Overlay.of(context);
          showTopSnackBar(
            state!,
            CustomSnackBar.info(
              message: callback.message ?? 'Successful account registration.',
              textStyle: GoogleFonts.quicksand(
                fontSize: 14,
                color: colorWhite,
                fontWeight: FontWeight.w600,
              ),
              icon: Image.asset(
                getAssetImage(
                  AssetImagePath.plats_logo,
                ),
              ),
              backgroundColor: colorPrimary,
              iconRotationAngle: -30,
              iconPositionTop: 10,
              iconPositionLeft: -10,
            ),
          );
          authController.login(emailController.text.trim(),
              passwordController.text.trim(), remember);
          // Get.toNamed(Routes.otpVerification, arguments: {
          //   'email': emailController.text.trim(),
          //   'password': passwordController.text.trim(),
          // });
        }
      },
    );
  }

  void showRegisterFail(String? message) {
    return GetXDefaultBottomSheet.errorBottomSheet(
      title: 'register_failed'.tr,
      text: Text(
        message ?? '',
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
            height: 180,
            child: Padding(
              padding: const EdgeInsets.all(dimen24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Image.asset(
                  //   'assets/images/sending.gif',
                  //   width: dimen160,
                  //   height: dimen160,
                  // ),
                  Text(
                    'register_failed'.tr,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: color1D93E3,
                    ),
                  ),
                  verticalSpace10,
                  Expanded(
                    child: Text(
                      message ?? '',
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
    Widget fullNameWidget = Obx(() {
      return AppInputView(
          // label: 'fullname'.tr,
          isRequired: true,
          controller: fullNameController,
          hint: 'fullname'.tr,
          validationMessage: fullNameValidationMessage.value,
          autoFocus: true,
          textInputAction: TextInputAction.next,
          onSubmitted: (value) {
            isShowError = true;
            _validateFullName();
            isShowError = false;
            _nodeEmail.requestFocus();
          },
          keyboardType: TextInputType.name,
          nodeTextField: _nodeFullName);
    });

    Widget emailWidget = Obx(() {
      return AppInputView(
        // label: 'email'.tr,
        isRequired: true,
        controller: emailController,
        hint: 'email'.tr,
        validationMessage: emailValidationMessage.value,
        autoFocus: true,
        textInputAction: TextInputAction.next,
        onSubmitted: (value) {
          isShowError = true;
          _validateEmail();
          isShowError = false;
          _nodePassword.requestFocus();
        },
        keyboardType: TextInputType.emailAddress,
        nodeTextField: _nodeEmail,
      );
    });

    Widget passwordWidget = Obx(() {
      return AppInputView(
        // label: 'password'.tr,
        isRequired: true,
        controller: passwordController,
        hint: 'password'.tr,
        obscureText: hidePassword.value,
        suffixImage: (hidePassword.value)
            ? InkWell(
                child: Image(
                  image: AssetImage(getAssetImage(AssetImagePath.eye_disabled)),
                  width: dimen24,
                  height: dimen24,
                ),
                onTap: () {
                  hidePassword.value = !hidePassword.value;
                })
            : InkWell(
                child: Image(
                  image: AssetImage(getAssetImage(AssetImagePath.eye)),
                  width: dimen24,
                  height: dimen24,
                ),
                onTap: () {
                  hidePassword.value = !hidePassword.value;
                }),
        validationMessage: passwordValidationMessage.value,
        textInputAction: TextInputAction.done,
        onSubmitted: (value) {
          // Validate
          isShowError = true;
          _validatePassword();
          isShowError = false;
          _nodeConfirmPassword.requestFocus();
        },
        nodeTextField: _nodePassword,
      );
    });

    Widget passwordConfirmWidget = Obx(() {
      return AppInputView(
        // label: 'confirm_password'.tr,
        isRequired: true,
        controller: confirmPasswordController,
        hint: 'confirm_password'.tr,
        obscureText: hidePassword.value,
        suffixImage: (hidePassword.value)
            ? InkWell(
                child: Image(
                  image: AssetImage(getAssetImage(AssetImagePath.eye_disabled)),
                  width: dimen24,
                  height: dimen24,
                ),
                onTap: () {
                  hidePassword.value = !hidePassword.value;
                })
            : InkWell(
                child: Image(
                  image: AssetImage(getAssetImage(AssetImagePath.eye)),
                  width: dimen24,
                  height: dimen24,
                ),
                onTap: () {
                  hidePassword.value = !hidePassword.value;
                }),
        validationMessage: confirmPasswordValidationMessage.value,
        textInputAction: TextInputAction.done,
        nodeTextField: _nodeConfirmPassword,
        onSubmitted: (value) {
          // Validate
          isShowError = true;
          _validateConfirmPassword();
          isShowError = false;
        },
      );
    });

    Widget registerButtonWidget = GestureDetector(
      onTap: () {
        // Validate
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
            'register'.tr,
            style: GoogleFonts.quicksand(
              color: colorWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );

    Widget termsWidget = Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BaseCheckBox(
              checked: isTermsChecked,
              onCheckChanged: (bool value) {
                isTermsChecked = value;
                isShowError = true;
                _validate(false);
              },
              child: Flexible(
                child: RichText(
                  softWrap: true,
                  text: TextSpan(
                    text: 'i_agree_with_the_plats_network'.tr,
                    style: GoogleFonts.quicksand(
                        fontSize: 13,
                        color: color625F5C,
                        fontWeight: FontWeight.w400),
                    children: [
                      TextSpan(
                        text: ' ${'terms_of_service'.tr}',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            // open url
                            final url = await registerController
                                .fetchRemoteConfigForTermsAndConditions();

                            devDebugMock(() {
                              print('url: $url');
                            });
                            if (await canLaunchUrlString(url)) {
                              await launchUrlString(url);
                            }
                          },
                        style: GoogleFonts.quicksand(
                            fontSize: 13,
                            color: colorPrimary,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: dimen4),
              child: Text(isTermsCheckedValidationMessage.value,
                  style: text12_error_600),
            ),
          ],
        ));

    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
          bottom: false,
          child: GestureDetector(
            onTap: () {
              Get.focusScope?.unfocus();
            },
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: dimen16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // AppAuthHeader(
                            //   title: 'create_a_new_account'.tr,
                            // ),
                            verticalSpace40,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  image: AssetImage(getAssetImage(
                                      AssetImagePath.logo_plats_07)),
                                  height: 55,
                                ),
                                horizontalSpace10,
                                Container(
                                  alignment: Alignment.center,
                                  child: Image(
                                    image: AssetImage(getAssetImage(
                                        AssetImagePath.logo_plats_08)),
                                    height: 35,
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace40,
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'create_a_new_account'.tr,
                                style: GoogleFonts.quicksand(
                                  color: color171716,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            verticalSpace6,
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Please put your information below to create \na new account for using app.',
                                style: GoogleFonts.quicksand(
                                  color: color8A8E9C,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            verticalSpace35,
                            fullNameWidget,
                            verticalSpace18,
                            emailWidget,
                            verticalSpace18,
                            passwordWidget,
                            verticalSpace18,
                            passwordConfirmWidget,
                            verticalSpace24,
                            termsWidget,
                          ],
                        ),
                      ),

                      // Register button
                      Container(
                        color: colorWhite,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 22),
                        child: registerButtonWidget,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: dimen14,
                  top: dimen4,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            getAssetImage(
                              AssetImagePath.arrow_left,
                            ),
                            width: dimen12,
                            height: dimen12,
                            color: colorPrimary,
                          ),
                          horizontalSpace4,
                          Text(
                            'Login',
                            style: GoogleFonts.quicksand(
                              color: colorPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          horizontalSpace10,
                        ],
                      ),
                    ),
                  ),
                ),
                Obx(() => (registerController.isRegistering())
                    ? const FullScreenProgress()
                    : Container())
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    _nodeEmail.dispose();
    _nodePassword.dispose();
    emailController.dispose();
    passwordController.dispose();
    registerWorker.dispose();
    super.dispose();
  }

  bool _validateFullName() {
    final fullName = fullNameController.text.trim();
    try {
      // Required full name
      if (fullName.isBlank == true) {
        throw 'invalid_full_name'.tr;
      }

      // if nothing wrong, clear error message
      fullNameValidationMessage.value = '';
      return false;
    } on String catch (errorText) {
      // if something wrong, and show error, set error message
      if (isShowError) {
        fullNameValidationMessage.value = errorText;
      }

      // return true because of error
      return true;
    }
  }

  bool _validateEmail() {
    final email = emailController.text.trim();
    try {
      // Required email
      if (email.isBlank == true) {
        throw 'invalid_email'.tr;
      }

      // Email must be valid
      if (!emailRegex.hasMatch(email)) {
        throw 'invalid_email'.tr;
      }

      // if nothing wrong, clear error message
      emailValidationMessage.value = '';
      return false;
    } on String catch (errorText) {
      // if something wrong, and show error, set error message
      if (isShowError) {
        emailValidationMessage.value = errorText;
      }

      // return true because of error
      return true;
    }
  }

  bool _validatePassword() {
    final newPassword = passwordController.text.trim();
    var isError = false;
    if (!validatePassword(newPassword)) {
      if (isShowError) {
        passwordValidationMessage.value = validatePasswordMessage(newPassword);
      }
      isError = true;
    } else {
      passwordValidationMessage.value = '';
    }
    return isError;
  }

  bool _validateConfirmPassword() {
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    try {
      // Required confirm password
      if (confirmPassword.isBlank == true) {
        throw 'invalid_confirm_password'.tr;
      }

      // Confirm password must be same with password
      if (password != confirmPassword) {
        throw 'password_not_match'.tr;
      }

      // if nothing wrong, clear error message
      confirmPasswordValidationMessage.value = '';
      return false;
    } on String catch (errorText) {
      // if something wrong, and show error, set error message
      if (isShowError) {
        confirmPasswordValidationMessage.value = errorText.toString();
      }

      // return true because of error
      return true;
    }
  }

  bool _validateTerms() {
    try {
      // Required terms
      if (isTermsChecked == false) {
        throw 'please_accept_terms_and_conditions'.tr;
      }

      // if nothing wrong, clear error message
      isTermsCheckedValidationMessage.value = '';
      return false;
    } on String catch (errorText) {
      // if something wrong, and show error, set error message
      if (isShowError) {
        isTermsCheckedValidationMessage.value = errorText.toString();
      }

      // return true because of error
      return true;
    }
  }

  void resetValidationMessage() {
    fullNameValidationMessage.value = '';
    emailValidationMessage.value = '';
    passwordValidationMessage.value = '';
    confirmPasswordValidationMessage.value = '';
    isTermsCheckedValidationMessage.value = '';
  }

  void _validate(bool isNavigate) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final fullName = fullNameController.text.trim();

    var isError = false;

    var testList = [
      _validateFullName(),
      _validateEmail(),
      _validatePassword(),
      _validateConfirmPassword(),
      _validateTerms()
    ];

    if (testList.contains(true)) {
      isError = true;
    }

    if (isError) {
      _isError.value = true;
      return;
    } else {
      resetValidationMessage();
      _isError.value = false;
    }
    if (isNavigate) {
      Get.focusScope?.unfocus();
      _register(email, password, fullName);
    }
  }

  void _register(email, password, fullName) {
    registerController.register(email, password, fullName);
  }
}
