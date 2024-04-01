import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/controller/password_security_controller.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/provider/password_security_provider.dart';

class PasswordSecurityBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PasswordSecurityProvider());
    Get.put(PasswordSecurityController());
  }
}