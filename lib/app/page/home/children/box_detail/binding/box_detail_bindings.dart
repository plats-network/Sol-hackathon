import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/box_detail/controller/box_detail_controller.dart';
import 'package:plat_app/app/page/home/children/box_detail/provider/box_detail_provider.dart';

class BoxDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoxDetailProvider>(() => BoxDetailProvider());
    Get.create(() => BoxDetailController(), permanent: false);
  }
}
