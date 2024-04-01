import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/box_history/controller/box_history_controller.dart';
import 'package:plat_app/app/page/home/children/box_history/provider/box_history_provider.dart';

class BoxHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoxHistoryProvider>(() => BoxHistoryProvider());
    Get.lazyPut<BoxHistoryController>(() => BoxHistoryController());
  }
}
