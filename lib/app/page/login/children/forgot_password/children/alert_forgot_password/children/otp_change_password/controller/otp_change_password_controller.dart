import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/children/change_password/model/change_password_response.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/children/otp_change_password/provider/otp_change_password_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class OtpChangePasswordController extends GetxController {
  final OtpChangePasswordProvider changePasswordProvider = Get.find();
  final changePasswordData = Rx(NetworkResource<ChangePasswordResponse>.init());

  Future<void> postChangePassword(newPassword, email, code) async {
    changePasswordData.value =
        NetworkResource<ChangePasswordResponse>.loading();
    final body = {
      'password': newPassword,
      'email': email,
      'code': code,
    };
    final result = await changePasswordProvider.postChangePassword(body);
    NetworkResource.handleResponse(
        result, ChangePasswordResponse.fromJson, changePasswordData,
        isShowError: true);
  }

  bool isChangingPassword() {
    return changePasswordData.value.isLoading();
  }

  bool isChangePasswordSuccess() {
    return changePasswordData.value.isSuccess();
  }

  bool isChangePasswordError() {
    return changePasswordData.value.isError();
  }
}
