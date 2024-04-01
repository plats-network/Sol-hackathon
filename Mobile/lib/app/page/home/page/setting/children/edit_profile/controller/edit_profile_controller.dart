import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/model/update_profile_response.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/provider/edit_profile_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class EditProfileController extends GetxController {
  final EditProfileProvider editProfileProvider = Get.find();

  final updateProfileData = Rx(NetworkResource<UpdateProfileResponse>.init());

  Future<void> patchUpdateProfile(
      String fullName, String? email, int? gender, String? birth) async {
    updateProfileData.value = NetworkResource<UpdateProfileResponse>.loading();
    final body = {
      'name': fullName,
    };
    if (email?.isNotEmpty == true) {
      body['email'] = email!;
    }
    if (gender != null) {
      body['gender'] = gender.toString();
    }
    if (birth?.isNotEmpty == true) {
      body['birth'] = birth!;
    }
    final result = await editProfileProvider.patchUpdateProfile(body);
    NetworkResource.handleResponse(
        result, UpdateProfileResponse.fromJson, updateProfileData,
        isShowError: true);
  }

  bool isUpdatingProfile() {
    return updateProfileData.value.isLoading();
  }

  bool isUpdateProfileSuccess() {
    return updateProfileData.value.isSuccess();
  }

  bool isUpdateProfileError() {
    return updateProfileData.value.isError();
  }
}
