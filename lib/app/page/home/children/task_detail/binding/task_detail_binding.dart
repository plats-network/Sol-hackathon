import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/task_detail/controller/task_detail_controller.dart';
import 'package:plat_app/app/page/home/children/task_detail/provider/task_detail_provider.dart';

class TaskDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TaskDetailProvider());
    Get.create(() => TaskDetailController(), permanent: false);
  }
}
