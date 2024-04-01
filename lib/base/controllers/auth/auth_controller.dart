import 'dart:async';

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plat_app/app/widgets/shared_preferences.dart';
import 'package:twitter_login/twitter_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/base/component/snackbar/getx_default_snack_bar.dart';
import 'package:plat_app/base/model/login_response.dart';
import 'package:plat_app/base/provider/auth/auth_provider.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends GetxController {
  final storage = GetStorage();
  final authData = Rx(NetworkResource<LoginResponse>.init());
  late AuthProvider authProvider = Get.find();
  final AppNotificationController appNotificationController = Get.find();
  final RxInt errorCode = ErrorCode.UNKNOWN_ERROR.obs;

  void login(email, password, remember) async {
    authData.value = NetworkResource<LoginResponse>.loading();
    final body = {'email': email, 'password': password};
    var result = await authProvider.postLogin(body);
    errorCode.value = result.body?['error_code'] ?? ErrorCode.UNKNOWN_ERROR;
    NetworkResource.handleLoginResponse(result, onSuccess: (response) {
      _setLoggedIn(isLoggedIn: true, data: response);
      // Save email and password
      if (remember) {
        storage.write(keyEmail, email);
        storage.write(keyPassword, password);
      } else {
        storage.remove(keyEmail);
        storage.remove(keyPassword);
      }
    }, onFail: (errorMessage) {
      _setLoggedIn(isLoginError: true, message: errorMessage);
    });
  }

  bool isLoggingIn() {
    return authData.value.isLoading();
  }

  bool isLogInError() {
    return authData.value.isError();
  }

  bool isLoggedIn() {
    final accessToken = storage.read(keyAccessToken);
    return accessToken != null || authData.value.isSuccess();
  }

  Future<void> logout() async {
    _setLoggedIn(isLoggedIn: false);
    saveToRecentSearches(isCleanData: true);
  }

  bool isNotLoggedIn() {
    return authData.value.isInit();
  }

  void _setLoggedIn(
      {isLoggedIn = false,
      isLoginError = false,
      message,
      LoginResponse? data}) async {
    if (isLoggedIn) {
      // Save access token
      await storage.write(keyAccessToken, data?.data?.jwt?.accessToken);
      // Save user id
      await storage.write(keyUserId, data?.data?.id);
      // Set login success
      authData.value = NetworkResource<LoginResponse>.success(data: data);
      // Create FCM device token
      appNotificationController.createFCMDeviceToken();
    } else if (isLoginError) {
      // Login error
      authData.value = NetworkResource<LoginResponse>.error(
        message: message,
      );
    } else {
      // Delete access token
      await storage.write(keyAccessToken, null);
      // Delete user id
      await storage.write(keyUserId, null);
      // Logout
      authData.value = NetworkResource<LoginResponse>.init();
    }
  }

  void loginWithGoogle() async {
    authData.value = NetworkResource<LoginResponse>.loading();
    try {
      // // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      // // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final accessToken = googleAuth.accessToken;

      final result = await authProvider.postLoginGoogle(accessToken ?? "");

      NetworkResource.handleLoginResponse(result, onSuccess: (response) {
        _setLoggedIn(isLoggedIn: true, data: response);
      }, onFail: (errorMessage) {
        _setLoggedIn(isLoginError: true, message: errorMessage);
      });
    } catch (e) {
      //TODO: Catch fail case, Currently can't catch login fail when cancel pressed
      //Reference: https://github.com/flutter/flutter/issues/44431#issuecomment-751126499
      GetXDefaultSnackBar.errorSnackBar(
          title: 'login_error'.tr, message: 'user_cancel_login'.tr);

      _setLoggedIn(isLoginError: false, message: 'user_cancel_login'.tr);
    }
  }

  void loginWithFacebook() async {
    authData.value = NetworkResource<LoginResponse>.loading();
    final LoginResult sdkResult = await FacebookAuth.i.login();

    try {
      if (sdkResult.status != LoginStatus.success) {
        throw Exception('error ${sdkResult.message}');
      }

      // you are logged
      final String accessToken = sdkResult.accessToken!.token;
      final result = await authProvider.postLoginFacebook(accessToken);

      NetworkResource.handleLoginResponse(result, onSuccess: (response) {
        _setLoggedIn(isLoggedIn: true, data: response);
      }, onFail: (errorMessage) {
        _setLoggedIn(
          isLoginError: false,
          message: errorMessage,
        );
      });
    } catch (e) {
      GetXDefaultSnackBar.errorSnackBar(
          title: 'login_error'.tr, message: 'user_cancel_login'.tr);

      _setLoggedIn(isLoginError: false, message: 'error ${e.toString()}');
    }
  }

  void loginWithApple() async {
    authData.value = NetworkResource<LoginResponse>.loading();

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final idToken = credential.identityToken;
      final result = await authProvider.postLoginApple(idToken ?? "");

      NetworkResource.handleLoginResponse(result, onSuccess: (response) {
        _setLoggedIn(isLoggedIn: true, data: response);
      }, onFail: (errorMessage) {
        _setLoggedIn(isLoginError: false, message: errorMessage);
      });
    } catch (e) {
      GetXDefaultSnackBar.errorSnackBar(
          title: 'login_error'.tr, message: 'user_cancel_login'.tr);

      _setLoggedIn(isLoginError: false, message: 'error $e');
    }
  }

  String? fetchUserId() {
    return authData.value.data?.data?.id ?? storage.read(keyUserId);
  }

  Future<int> fetchTwitterId() async {
    final twitterLogin = TwitterLogin(
      // Consumer API keys
      apiKey: '0moDNcdZUwQ4UUMj7RH4pZKXw',
      // Consumer API Secret keys
      apiSecretKey: 'mQG8Jl7Bl5F1g6AZDFjOpdnbfclPVpfhq5uGH6lTv4U4ASii7w',
      // Registered Callback URLs in TwitterApp
      // Android is a deeplink
      // iOS is a URLScheme
      redirectURI: 'platsnetwork://',
    );
    final authResult = await twitterLogin.login();

    switch (authResult.status) {
      case TwitterLoginStatus.loggedIn:
        return authResult.user?.id ?? 0;
      case TwitterLoginStatus.cancelledByUser:
        throw Exception('Twitter login cancelled by user.');
      case TwitterLoginStatus.error:
        throw Exception('Twitter login error: ${authResult.errorMessage}');
      default:
        throw Exception('Twitter login error: ${authResult.errorMessage}');
    }
  }
}
