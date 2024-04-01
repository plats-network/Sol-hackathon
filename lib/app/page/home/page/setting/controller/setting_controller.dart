import 'dart:io';

import 'package:camera/camera.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plat_app/app/page/home/page/setting/model/update_avatar_response.dart';
import 'package:plat_app/app/page/home/page/setting/model/user_profile_response.dart';
import 'package:plat_app/app/page/home/page/setting/provider/setting_user_provider.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class SettingController extends GetxController {
  final storage = GetStorage();
  final AuthController authController = Get.find();
  final SettingUserProvider settingUserProvider = Get.find();
  final userProfile = Rx(NetworkResource<UserProfileResponse>.init());

  Future<void> fetchUserProfile() async {
    userProfile.value = NetworkResource<UserProfileResponse>.loading(
        data: userProfile.value.data);
    final userId = authController.fetchUserId();
    if (userId != null) {
      final result = await settingUserProvider.fetchUserProfile();
      NetworkResource.handleResponse(
          result, UserProfileResponse.fromJson, userProfile);
    } else {
      userProfile.value = NetworkResource<UserProfileResponse>.error(
          data: userProfile.value.data);
    }
  }

  bool isGettingUserProfile() {
    return userProfile.value.isLoading();
  }

  bool isGetUserProfileSuccess() {
    return userProfile.value.isSuccess();
  }

  bool isGetUserProfileError() {
    return userProfile.value.isError();
  }

  final updateAvatarData = Rx(NetworkResource<UpdateAvatarResponse>.init());

  void postUpdateAvatar(XFile image) async {
    updateAvatarData.value = NetworkResource<UpdateAvatarResponse>.loading();
    final body = FormData({
      'avatar': MultipartFile(File(image.path), filename: image.name),
    });
    final result = await settingUserProvider.postUpdateAvatar(body);
    NetworkResource.handleResponse(
        result, UpdateAvatarResponse.fromJson, updateAvatarData,
        isShowError: true);
  }

  bool isUpdatingAvatar() => updateAvatarData.value.isLoading();

  bool isUpdateAvatarSuccess() => updateAvatarData.value.isSuccess();

  bool isUpdateAvatarError() => updateAvatarData.value.isError();
}
