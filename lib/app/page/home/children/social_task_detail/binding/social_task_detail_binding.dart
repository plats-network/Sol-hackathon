import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/controller/social_task_detail_controller.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/provider/social_account_provider.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/provider/social_task_detail_provider.dart';

class SocialTaskDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SocialTaskDetailProvider());
    Get.lazyPut(
      () => SocialTaskDetailController(),
    );
    Get.lazyPut(
      () => SocialAccountProvider(),
    );
  }
}
