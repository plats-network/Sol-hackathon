import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/children/preview_photo/controller/preview_photo_controller.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/children/preview_photo/provider/preview_photo_provider.dart';

class PreviewPhotoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PreviewPhotoProvider());
    Get.lazyPut(() => PreviewPhotoController());
  }
}