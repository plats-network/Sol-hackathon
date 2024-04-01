import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/controller/help_center_controller.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/provider/help_center_provider.dart';

class HelpCenterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpCenterProvider());
    Get.lazyPut(() => HelpCenterController());
  }
}
