import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/about/controller/about_app_controller.dart';
import 'package:plat_app/app/page/home/page/setting/children/about/provider/about_app_provider.dart';

class AboutAppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AboutAppProvider());
    Get.lazyPut(() => AboutAppController());
  }
}
