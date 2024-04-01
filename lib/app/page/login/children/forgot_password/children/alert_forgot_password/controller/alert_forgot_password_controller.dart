import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/forgot_password/model/forgot_password_model.dart';
import 'package:plat_app/app/page/login/children/forgot_password/provider/forgot_password_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class AlertForgotPasswordController extends GetxController {
  final ForgotPasswordProvider forgotPasswordProvider = Get.find();
  final alertForgotPasswordData =
      Rx(NetworkResource<ForgotPasswordModel>.init());
  final resendOtpData = Rx(NetworkResource<ForgotPasswordModel>.init());

  bool isVerifyRequestError() {
    return alertForgotPasswordData.value.isError();
  }

  bool isResendOtpRequestError() {
    return resendOtpData.value.isError();
  }

  bool isVerifyRequestSuccess() {
    return alertForgotPasswordData.value.isSuccess();
  }

  bool isResendOtpRequestSuccess() {
    return resendOtpData.value.isSuccess();
  }

  bool isRequestingVerify() {
    return alertForgotPasswordData.value.isLoading();
  }

  bool isRequestingResend() {
    return resendOtpData.value.isLoading();
  }

  void triggerResendCode(email) async {
    resendOtpData.value = NetworkResource.loading();

    final result = await forgotPasswordProvider.postForgotPassword(email);

    NetworkResource.handleResponse(
        result, ForgotPasswordModel.fromJson, resendOtpData);
  }

  void verifyCode(email, code) async {
    alertForgotPasswordData.value = NetworkResource.loading();

    final result = await forgotPasswordProvider.verifyCode(code, email);

    NetworkResource.handleResponse(
        result, ForgotPasswordModel.fromJson, alertForgotPasswordData,
        isShowError: false);
  }
}
