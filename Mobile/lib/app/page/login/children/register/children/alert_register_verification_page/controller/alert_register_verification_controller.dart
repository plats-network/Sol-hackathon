import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/register/children/alert_register_verification_page/model/alert_register_verification_response.dart';
import 'package:plat_app/app/page/login/children/register/children/alert_register_verification_page/model/resend_otp_verification_response.dart';
import 'package:plat_app/app/page/login/children/register/children/alert_register_verification_page/provider/alert_register_verification_provider.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class AlertRegisterVerificationController extends GetxController {
  final otpVerificationData =
      Rx(NetworkResource<AlertRegisterVerificationResponse>.init());
  final resendOtpData =
      Rx(NetworkResource<ResendOtpVerificationResponse>.init());
  final AlertRegisterVerificationProvider alertRegisterVerificationProvider =
      Get.find();
  final RxInt errorCode = ErrorCode.UNKNOWN_ERROR.obs;

  bool isVerifyRequestError() {
    return otpVerificationData.value.isError();
  }

  bool isVerifyRequestSuccess() {
    return otpVerificationData.value.isSuccess();
  }

  bool isVerifyRequesting() {
    return otpVerificationData.value.isLoading();
  }

  bool isResendOtpRequestError() {
    return resendOtpData.value.isError();
  }

  bool isResendOtpRequestSuccess() {
    return resendOtpData.value.isSuccess();
  }

  bool isResendOtpRequesting() {
    return resendOtpData.value.isLoading();
  }

  void triggerResendCode(email) async {
    resendOtpData.value = NetworkResource.loading();

    final result =
        await alertRegisterVerificationProvider.postTriggerResend(email);

    errorCode.value = result.body?['errorCode'] ?? ErrorCode.UNKNOWN_ERROR;

    NetworkResource.handleResponse(
        result, ResendOtpVerificationResponse.fromJson, resendOtpData);
  }

  void verifyCode(email, code) async {
    otpVerificationData.value = NetworkResource.loading();

    final result =
        await alertRegisterVerificationProvider.verifyCode(code, email);

    errorCode.value = result.body?['errorCode'] ?? ErrorCode.UNKNOWN_ERROR;

    NetworkResource.handleResponse(
        result, AlertRegisterVerificationResponse.fromJson, otpVerificationData,
        isShowError: false);
  }
}
