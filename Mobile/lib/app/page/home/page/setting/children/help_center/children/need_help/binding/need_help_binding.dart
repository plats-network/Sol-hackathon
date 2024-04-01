import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/children/need_help/controller/need_help_controller.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/children/need_help/provider/need_help_provider.dart';

class NeedHelpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NeedHelpProvider());
    Get.lazyPut(() => NeedHelpController());
  }
}
