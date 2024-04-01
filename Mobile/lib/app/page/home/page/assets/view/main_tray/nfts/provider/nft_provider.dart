import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class NftProvider extends ActionProvider {
  Future<Response<dynamic>> fetchNftList(int page) async {
    return await get('/gifts?type=nft&page=$page');
  }
}
