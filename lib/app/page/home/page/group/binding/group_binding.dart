import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/provider/social_task_detail_provider.dart';
import 'package:plat_app/app/page/home/page/group/controller/group_controller.dart';
import 'package:plat_app/app/page/home/page/group/provider/group_provider.dart';

class GroupBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroupProvider>(() => GroupProvider());
    Get.put(SocialTaskDetailProvider());
    Get.put<GroupController>(GroupController());
  }
}
