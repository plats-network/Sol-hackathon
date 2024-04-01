import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class OtpChangePasswordProvider extends UserProvider {
  Future<Response<dynamic>> postChangePassword(body) =>
      put('/reset-password', body);
}
