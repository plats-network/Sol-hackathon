import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/login/controller/login_datasource.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/controllers/language/language_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:plat_app/development.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final variant = dotenv.env['VARIANT'];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailValidationMessage = ''.obs;
  final passwordValidationMessage = ''.obs;
  bool remember = true;
  final hidePassword = true.obs;
  final FocusNode _nodeEmail = FocusNode();
  final FocusNode _nodePassword = FocusNode();
  bool isShowError = false;
  final _isError = true.obs;
  final AuthController authController = Get.find();
  final storage = GetStorage();
  late Worker loginWorker;
  final emailArgument = Get.arguments?['email'] ?? '';

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      _validate(false);
    });
    passwordController.addListener(() {
      _validate(false);
    });
    // Set app language
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final langCode = Get.parameters['langCode'];
      if (langCode != null) {
        LanguageController languageController = Get.find();
        languageController.setLanguage(
          fetchLanguageByCode(langCode),
        );
      }
    });
    // Load saved username and password
    final email = storage.read(keyEmail);
    final password = storage.read(keyPassword);
    emailController.text = email ?? '';
    passwordController.text = password ?? '';
    // TODO: Mock login
    devDebugMock(() {
      emailController.text = mockLoginAccount['email'] ?? '';
      passwordController.text = mockLoginAccount['password'] ?? '';
    });

    if (emailArgument.isNotEmpty) {
      emailController.text = emailArgument;
    }

    loginWorker = ever(authController.authData, (NetworkResource data) {
      if (authController.isLogInError()) {
        switch (authController.errorCode.value) {
          case ErrorCode.CREDENTIALS_NOT_MATCH:
          case ErrorCode.MODEL_NOT_FOUND:
            showCustomDialog(context, 'invalid_credentials'.tr, false);
            break;
          case ErrorCode.REQUIRE_LOGIN_SOCIAL:
            showCustomDialog(
                context, 'please_login_with_social_network'.tr, false);
            break;
          case ErrorCode.EMAIL_UNVERIFIED:
            Get.toNamed(Routes.otpVerification, arguments: {
              'email': emailController.text,
              'password': passwordController.text
            });
            break;
          default:
            showCustomDialog(context, data.message, true);
            break;
        }
      } else if (authController.isLoggedIn()) {
        // TODO: Currently disable OTP for login
        Get.offAllNamed(Routes.home);
      }
    });
  }

  void showLoginFail(String? message) {
    return GetXDefaultBottomSheet.errorBottomSheet(
        title: 'login_failed'.tr,
        text: Text(
          message ?? 'username_or_password_is_incorrect'.tr,
          style: text16_625F5C_400,
          textAlign: TextAlign.center,
        ),
        bottomWidgets: [
          verticalSpace10,
          InkWell(
            onTap: () {
              Get.toNamed(Routes.forgotPassword);
            },
            child: Text('forgot_password'.tr, style: text14_177FE2_400),
          ),
          verticalSpace24,
        ]);
  }

  @override
  Widget build(BuildContext context) {
    Widget emailWidget = Obx(() {
      return AppInputView(
        controller: emailController,
        hint: 'email'.tr,
        validationMessage: emailValidationMessage.value,
        // prefixImage: Image(
        //   image: AssetImage(
        //     getAssetImage(AssetImagePath.user_icon),
        //   ),
        //   color: color878998,
        //   width: dimen24,
        //   height: dimen24,
        // ),
        textInputAction: TextInputAction.next,
        onSubmitted: (value) {
          isShowError = true;
          resetValidationMessage();
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
        controller: passwordController,
        hint: 'password'.tr,
        obscureText: hidePassword.value,
        // prefixImage: Image(
        //   image: AssetImage(
        //     getAssetImage(AssetImagePath.ic_lock),
        //   ),
        //   color: color878998,
        //   width: dimen24,
        //   height: dimen24,
        // ),
        suffixImage: (hidePassword.value)
            ? InkWell(
                child: Image(
                  image: AssetImage(getAssetImage(AssetImagePath.eye_disabled)),
                  width: dimen24,
                  height: dimen24,
                  color: color878998,
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
          _validate(true);
        },
        nodeTextField: _nodePassword,
      );
    });

    Widget loginButtonWidget = GestureDetector(
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
            'login'.tr,
            style: GoogleFonts.quicksand(
              color: colorWhite,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );

    Widget forgotButtonWidget = InkWell(
      onTap: () {
        Get.toNamed(Routes.forgotPassword);
      },
      child: Container(
        alignment: Alignment.bottomRight,
        // padding: const EdgeInsets.all(dimen8),
        child: Text(
          '${'forgot_password'.tr}?',
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500, fontSize: 14, color: colorPrimary),
        ),
      ),
    );

    Widget registerBottomText = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${'create_a_new_account'.tr}? ',
          style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500, fontSize: 14, color: color32302D),
        ),
        InkWell(
            onTap: () {
              Get.toNamed(Routes.register);
            },
            child: Container(
              margin: const EdgeInsets.only(left: dimen2),
              child: Text(
                'register'.tr,
                style: GoogleFonts.quicksand(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                    color: colorPrimary),
              ),
            )),
      ],
    );

    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: GestureDetector(
                  onTap: () {
                    Get.focusScope?.unfocus();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: dimen24),
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            getAssetImage(AssetImagePath.backgroud_plats)),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // AppAuthHeader(title: 'lets_sign_you_in'.tr),
                        verticalSpace10,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image(
                              image: AssetImage(
                                  getAssetImage(AssetImagePath.logo_plats_07)),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Welcome to',
                              style: GoogleFonts.quicksand(
                                color: color171716,
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            horizontalSpace8,
                            Container(
                              alignment: Alignment.bottomCenter,
                              child: Image(
                                image: AssetImage(getAssetImage(
                                    AssetImagePath.logo_plats_08)),
                                height: 20,
                              ),
                            ),
                          ],
                        ),
                        verticalSpace6,
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Please enter your address below to start \nusing app.',
                            style: GoogleFonts.quicksand(
                              color: color8A8E9C,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        verticalSpace35,
                        emailWidget,
                        verticalSpace18,
                        passwordWidget,
                        verticalSpace10,
                        forgotButtonWidget,
                        verticalSpace24,
                        loginButtonWidget,
                        verticalSpace30,
                        registerBottomText,

                        // Expanded(
                        //   child: Column(
                        //     crossAxisAlignment: CrossAxisAlignment.end,
                        //     mainAxisAlignment: MainAxisAlignment.end,
                        //     children: [
                        //       Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         crossAxisAlignment: CrossAxisAlignment.center,
                        //         children: [
                        //           const Expanded(
                        //             child: Divider(
                        //               thickness: dimen1,
                        //               color: colorE5E5E5,
                        //               indent: dimen10,
                        //             ),
                        //           ),
                        //           Padding(
                        //             padding: const EdgeInsets.symmetric(
                        //                 horizontal: 10),
                        //             child: Text(
                        //               'Or sigin in with',
                        //               style: text14_primary_600.copyWith(
                        //                   fontWeight: FontWeight.w500,
                        //                   color: color32302D),
                        //             ),
                        //           ),
                        //           const Expanded(
                        //             child: Divider(
                        //               thickness: dimen1,
                        //               color: colorE5E5E5,
                        //               endIndent: dimen10,
                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       verticalSpace24,
                        //       Row(
                        //         mainAxisAlignment: MainAxisAlignment.center,
                        //         children: [
                        //           Expanded(
                        //             child: button(
                        //               child: Row(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.center,
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   Image.asset(
                        //                     getAssetImage(
                        //                         AssetImagePath.google),
                        //                     width: dimen28,
                        //                     height: dimen28,
                        //                   ),
                        //                   Text(
                        //                     'Google',
                        //                     style: text14_primary_600.copyWith(
                        //                         fontWeight: FontWeight.w500,
                        //                         color: color32302D),
                        //                   ),
                        //                 ],
                        //               ),
                        //               onTap: () {
                        //                 _loginWithGoogle();
                        //               },
                        //               color: colorWhite,
                        //             ),
                        //           ),
                        //           horizontalSpace10,
                        //           Expanded(
                        //             child: button(
                        //               child: Row(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.center,
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   Image.asset(
                        //                     getAssetImage(
                        //                         AssetImagePath.facebook),
                        //                     width: dimen28,
                        //                     height: dimen28,
                        //                   ),
                        //                   Text(
                        //                     'Facebook',
                        //                     style: text14_primary_600.copyWith(
                        //                         fontWeight: FontWeight.w500,
                        //                         color: colorWhite),
                        //                   ),
                        //                 ],
                        //               ),
                        //               onTap: () {
                        //                 _loginWithFacebook();
                        //               },
                        //               color: color1266B5,
                        //             ),
                        //           ),
                        //           if (Platform.isIOS)
                        //             Expanded(
                        //               child: Padding(
                        //                 padding: const EdgeInsets.only(
                        //                     left: dimen10),
                        //                 child: button(
                        //                   child: Row(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.center,
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.center,
                        //                     children: [
                        //                       Image.asset(
                        //                         getAssetImage(
                        //                             AssetImagePath.apple),
                        //                         width: dimen28,
                        //                         height: dimen28,
                        //                       ),
                        //                       Text(
                        //                         'Apple',
                        //                         style:
                        //                             text14_primary_600.copyWith(
                        //                                 fontWeight:
                        //                                     FontWeight.w500,
                        //                                 color: colorWhite),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                   onTap: () {
                        //                     _loginWithApple();
                        //                   },
                        //                   color: color171716,
                        //                 ),
                        //               ),
                        //             ),
                        //         ],
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        verticalSpace65,
                        // registerBottomText,
                        // verticalSpace30,
                      ],
                    ),
                  ),
                ),
              ),
              Obx(() => (authController.isLoggingIn())
                  ? const FullScreenProgress()
                  : Container())
            ],
          )),
    );
  }

  Widget button({
    Widget? child,
    VoidCallback? onTap,
    Color? color,
    bool isBorder = false,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: dimen15),
        // width: dimen50,
        height: dimen50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dimen8),
            color: color,
            border: Border.all(
              width: isBorder ? dimen1 : dimen0,
              color: color9C9896,
            )),
        child: child,
      ),
    );
  }

  @override
  void dispose() {
    _nodeEmail.dispose();
    _nodePassword.dispose();
    emailController.dispose();
    passwordController.dispose();
    loginWorker.dispose();
    super.dispose();
  }

  // return true if email is not valid
  bool _validateEmail() {
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
    return isError;
  }

  // return true if email is not valid
  bool _validatePassword() {
    final password = passwordController.text.trim();
    var isError = false;
    if (password.isBlank == true) {
      if (isShowError) {
        passwordValidationMessage.value = 'invalid_password'.tr;
      }
      isError = true;
    } else {
      passwordValidationMessage.value = '';
    }
    return isError;
  }

  void resetValidationMessage() {
    emailValidationMessage.value = '';
    passwordValidationMessage.value = '';
  }

  void _validate(bool isNavigate) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    var isError = false;

    var testList = [
      _validateEmail(),
      _validatePassword(),
    ];

    if (testList.contains(true)) {
      isError = true;
    }

    if (isError) {
      _isError.value = true;
      return;
    } else {
      emailValidationMessage.value = '';
      passwordValidationMessage.value = '';
      _isError.value = false;
    }
    if (isNavigate) {
      Get.focusScope?.unfocus();
      _login(email, password);
    }
  }

  void _login(email, password) {
    authController.login(email, password, remember);
  }

  void _loginWithGoogle() {
    authController.loginWithGoogle();
  }

  void _loginWithFacebook() {
    authController.loginWithFacebook();
  }

  void _loginWithApple() {
    authController.loginWithApple();
  }

  void showCustomDialog(
      BuildContext context, String? message, bool isShowForgotButton) {
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
                  // Image.asset(
                  //   'assets/images/sending.gif',
                  //   width: dimen160,
                  //   height: dimen160,
                  // ),
                  Text(
                    'login_failed'.tr,
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: color1D93E3,
                    ),
                  ),
                  verticalSpace6,
                  Expanded(
                    child: Text(
                      message ?? 'username_or_password_is_incorrect'.tr,
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: color1D93E3,
                      ),
                      textAlign: TextAlign.center,
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
                      child: Center(
                        child: Text(
                          'Got it',
                          style: GoogleFonts.quicksand(
                            color: colorWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  isShowForgotButton
                      ? Padding(
                          padding: const EdgeInsets.only(top: dimen10),
                          child: InkWell(
                            onTap: () {
                              Get.back();
                              Get.toNamed(Routes.forgotPassword);
                            },
                            child: Text(
                              'forgot_password'.tr,
                              style: GoogleFonts.quicksand(
                                color: color177FE2,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
