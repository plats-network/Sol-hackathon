import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/token_info/controller/token_info_controller.dart';
import 'package:plat_app/app/page/home/children/token_info/provider/token_info_provider.dart';

class TokenInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TokenInfoProvider());
    Get.lazyPut(() => TokenInfoController());
  }
}
