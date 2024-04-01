import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class AuthProvider extends UserProvider {
  // Login request
  Future<Response<dynamic>> postLogin(body) => post('/login', body);

  // Logout request
  Future<Response<dynamic>> postLogout() {
    return post('/logout', null);
  }

  // Login with Facebook
  Future<Response<dynamic>> postLoginFacebook(accessToken) {
    return post('/login/social', {
      'access_token': accessToken,
      'provider_name': 'facebook',
    });
  }

  Future<Response<dynamic>> postLoginGoogle(String accessToken) {
    return post('/login/social', {
      'access_token': accessToken,
      'provider_name': 'google',
    });
  }

  Future<Response<dynamic>> postLoginApple(String accessToken) {
    return post('/login/social', {
      'access_token': accessToken,
      'provider_name': 'apple',
    });
  }
}
