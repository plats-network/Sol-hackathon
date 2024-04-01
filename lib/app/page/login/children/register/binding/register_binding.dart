import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/register/controller/register_controller.dart';
import 'package:plat_app/app/page/login/children/register/provider/register_provider.dart';

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterProvider());
    Get.lazyPut(() => RegisterController());
  }
}
