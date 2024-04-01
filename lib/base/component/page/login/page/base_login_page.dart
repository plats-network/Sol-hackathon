import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';
import 'package:plat_app/base/component/dialog/getx_default_dialog.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/controllers/language/language_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class BaseLoginPage extends StatefulWidget {
  const BaseLoginPage({Key? key}) : super(key: key);

  @override
  State<BaseLoginPage> createState() => _BaseLoginPageState();
}

class _BaseLoginPageState extends State<BaseLoginPage> {
  final variant = dotenv.env['VARIANT'];

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final emailValidationMessage = ''.obs;
  final passwordValidationMessage = ''.obs;
  bool remember = false;
  final hidePassword = true.obs;
  final FocusNode _nodeEmail = FocusNode();
  final FocusNode _nodePassword = FocusNode();
  bool isShowError = false;
  final _isError = true.obs;
  final AuthController authController = Get.find();
  final storage = GetStorage();
  late Worker loginWorker;

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
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      final langCode = Get.parameters?['langCode'];
      if (langCode != null) {
        LanguageController languageController = Get.find();
        languageController.setLanguage(fetchLanguageByCode(langCode));
      }
    });
    // Load saved username and password
    final email = storage.read(keyEmail);
    final password = storage.read(keyPassword);
    emailController.text = email ?? '';
    passwordController.text = password ?? '';
    loginWorker = ever(authController.authData, (NetworkResource callback) {
      if (authController.isLogInError()) {
        GetXDefaultDialog.notifyDialog(
            title: 'error'.tr,
            middleText:
                callback.message?.trim() ?? 'invalid_email_or_password'.tr);
      } else if (authController.isLoggedIn()) {
        Get.toNamed(Routes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget emailWidget = Obx(() {
      return AppInputView(
        controller: emailController,
        hint: 'email'.tr,
        validationMessage: emailValidationMessage.value,
        autoFocus: true,
        textInputAction: TextInputAction.next,
        onSubmitted: (value) {
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
          _validate(true);
        },
        nodeTextField: _nodePassword,
      );
    });

    Widget loginButtonWidget = Obx(() {
      return AppButton(
        title: 'login'.tr,
        onTap: () {
          // Validate
          isShowError = true;
          _validate(true);
        },
        isEnable: !_isError.value,
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
                padding: EdgeInsets.symmetric(horizontal: dimen16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace120,
                    emailWidget,
                    verticalSpace12,
                    passwordWidget,
                    verticalSpace24,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.toNamed(Routes.forgotPassword);
                            },
                            child: Container(
                              padding: EdgeInsets.all(dimen8),
                              child: Text(
                                'forgot_password'.tr + '?',
                                style: text14_primary_600,
                              ),
                            )),
                        loginButtonWidget,
                      ],
                    ),
                    verticalSpace100,
                    AppButton(
                      title: 'Show bottom sheet',
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ),
          ),
          Obx(() => (authController.isLoggingIn())
              ? FullScreenProgress()
              : Container())
        ],
      )),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nodeEmail.dispose();
    _nodePassword.dispose();
    emailController.dispose();
    passwordController.dispose();
    loginWorker.dispose();
  }

  void _validate(bool isNavigate) {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
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
    // Validate password
    if (password.isBlank == true) {
      if (isShowError) {
        passwordValidationMessage.value = 'invalid_password'.tr;
      }
      isError = true;
    } else {
      passwordValidationMessage.value = '';
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
}
