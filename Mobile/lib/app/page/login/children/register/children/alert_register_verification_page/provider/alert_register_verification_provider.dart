import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class AlertRegisterVerificationProvider extends UserProvider {
  Future<Response<dynamic>> postTriggerResend(email) =>
      post('/register/resend-confirm-email', {
        'email': email,
      });

  Future<Response<dynamic>> verifyCode(code, email) {
    final body = {
      'email': email,
      'confirmation_code': code,
    };
    return post('/register/confirm-email', body);
  }
}
