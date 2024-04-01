import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/children/otp_change_password/controller/otp_change_password_controller.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/children/otp_change_password/provider/otp_change_password_provider.dart';

class OtpChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OtpChangePasswordProvider());
    Get.lazyPut(() => OtpChangePasswordController());
  }
}
