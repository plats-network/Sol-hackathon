import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class PasswordSecurityProvider extends UserProvider {
  Future<Response<dynamic>> deleteAccount() async {
    return delete(
      '/delete-account',
    );
  }
}
