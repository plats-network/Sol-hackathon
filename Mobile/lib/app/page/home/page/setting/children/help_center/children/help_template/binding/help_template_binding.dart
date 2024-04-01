import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/children/help_template/controller/help_template_controller.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/children/help_template/provider/help_template_provider.dart';

class HelpTemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HelpTemplateProvider());
    Get.lazyPut(() => HelpTemplateController());
  }
}
