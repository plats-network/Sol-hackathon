import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/controller/edit_profile_controller.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/provider/edit_profile_provider.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EditProfileProvider());
    Get.lazyPut(() => EditProfileController());
  }
}
