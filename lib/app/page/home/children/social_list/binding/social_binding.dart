import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_list/controller/social_list_controller.dart';
import 'package:plat_app/app/page/home/children/social_list/provider/social_list_provider.dart';

class SocialListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocialListProvider());
    Get.lazyPut(() => SocialListController());
  }
}
