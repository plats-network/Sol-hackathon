import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
import 'package:plat_app/app/page/home/page/index/provider/index_provider.dart';

class IndexBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => IndexProvider());
    Get.put(IndexController());
  }
}
