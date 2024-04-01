import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class ChangePasswordProvider extends UserProvider {
  Future<Response<dynamic>> postChangePassword(body) =>
      post('/profile/password', body);
}
