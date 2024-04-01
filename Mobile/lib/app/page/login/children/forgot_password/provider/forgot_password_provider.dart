import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class ForgotPasswordProvider extends UserProvider {
  Future<Response<dynamic>> postForgotPassword(email) =>
      //form data
      post('/reset-password', {
        'email': email,
      });

  Future<Response<dynamic>> verifyCode(code, email) =>
      post('/check-recovery-code', {'email': email, 'code': code});
}
