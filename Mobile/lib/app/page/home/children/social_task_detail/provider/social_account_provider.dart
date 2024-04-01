import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class SocialAccountProvider extends UserProvider {
  Future<Response<dynamic>> connectTwitter(String type, String accountId) =>
      post('/profile/update-social', {
        'type': type,
        'account': accountId,
      });

  Future<Response<dynamic>> fetchSocialAccount() => get('/account-socials');
}
