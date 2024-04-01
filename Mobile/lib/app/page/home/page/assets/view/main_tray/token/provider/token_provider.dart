import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class TokenProvider extends ActionProvider {
  Future<Response<dynamic>> fetchTokenList(int page) async {
    return await get('/gifts?type=token&page=$page');
  }
}
