import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class SocialListProvider extends ActionProvider {
  // get check in task list
  Future<Response<dynamic>> fetchSocialTaskWithPageProvider(int page) =>
      get('/socials?limit=4&page=$page');
}
