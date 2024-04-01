import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/register/children/alert_register_verification_page/controller/alert_register_verification_controller.dart';
import 'package:plat_app/app/page/login/children/register/children/alert_register_verification_page/provider/alert_register_verification_provider.dart';

class AlertRegisterVerificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AlertRegisterVerificationProvider());
    Get.lazyPut(() => AlertRegisterVerificationController());
  }
}
