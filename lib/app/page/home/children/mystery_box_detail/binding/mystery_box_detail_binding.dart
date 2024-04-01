import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/mystery_box_detail/controller/mystery_box_detail_controller.dart';
import 'package:plat_app/app/page/home/children/mystery_box_detail/provider/mystery_box_detail_provider.dart';

class MysteryBoxDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MysteryBoxDetailProvider());
    Get.lazyPut(() => MysteryBoxDetailController());
  }
}