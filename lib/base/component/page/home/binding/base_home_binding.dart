import 'package:get/get.dart';
import 'package:plat_app/base/component/page/home/controller/base_bottom_controller.dart';

class BaseHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BaseBottomController());
  }
}