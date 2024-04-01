import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class SettingUserProvider extends UserProvider {
  Future<Response<dynamic>> fetchUserProfile() => get('/profile');

  Future<Response<dynamic>> postUpdateAvatar(FormData body) =>
      post('/profile/upload-avatar', body);
}
