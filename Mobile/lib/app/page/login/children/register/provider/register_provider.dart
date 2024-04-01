import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class RegisterProvider extends UserProvider {
  // Register request
  Future<Response<dynamic>> postRegister(body) => post('/register', body);
}
