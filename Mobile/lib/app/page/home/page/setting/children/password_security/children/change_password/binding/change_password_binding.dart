import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/children/change_password/controller/change_password_controller.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/children/change_password/provider/change_password_provider.dart';

class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordProvider());
    Get.lazyPut(() => ChangePasswordController());
  }
}
