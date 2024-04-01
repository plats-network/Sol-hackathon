import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/controller/take_photo_controller.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/provider/take_photo_provider.dart';

class TakePhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TakePhotoProvider());
    Get.lazyPut(() => TakePhotoController());
  }
}