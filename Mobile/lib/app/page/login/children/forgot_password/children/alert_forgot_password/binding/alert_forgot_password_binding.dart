import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/controller/alert_forgot_password_controller.dart';

class AlertForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlertForgotPasswordController());
  }
}
