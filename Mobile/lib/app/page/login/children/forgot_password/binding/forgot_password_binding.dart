import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/forgot_password/controller/forgot_password_controller.dart';
import 'package:plat_app/app/page/login/children/forgot_password/provider/forgot_password_provider.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/provider/auth/auth_provider.dart';

class ForgotPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ForgotPasswordProvider());
    Get.lazyPut(() => ForgotPasswordController());
  }
}
