import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/check_in_list/controller/check_in_list_controller.dart';
import 'package:plat_app/app/page/home/children/check_in_list/provider/check_in_list_provider.dart';

class CheckInListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CheckInListProvider());
    Get.lazyPut(() => CheckInListController());
  }
}
