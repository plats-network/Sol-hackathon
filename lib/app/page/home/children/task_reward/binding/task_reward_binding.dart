import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/task_reward/controller/task_reward_controller.dart';
import 'package:plat_app/app/page/home/children/task_reward/provider/task_reward_provider.dart';

class TaskRewardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskRewardProvider());
    Get.lazyPut(() => TaskRewardController());
  }
}
