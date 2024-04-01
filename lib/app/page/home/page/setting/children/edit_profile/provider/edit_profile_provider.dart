import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class EditProfileProvider extends UserProvider {
  Future<Response<dynamic>> patchUpdateProfile(body) => patch('/profile', body);
}
