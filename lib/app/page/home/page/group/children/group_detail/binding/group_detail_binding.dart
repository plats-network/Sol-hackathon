import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/controller/social_task_detail_controller.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/provider/social_task_detail_provider.dart';
import 'package:plat_app/app/page/home/page/group/children/group_detail/controller/group_detail_controller.dart';

class GroupDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SocialTaskDetailController());
    Get.put(SocialTaskDetailProvider());
    Get.put(GroupDetailController());
  }
}
