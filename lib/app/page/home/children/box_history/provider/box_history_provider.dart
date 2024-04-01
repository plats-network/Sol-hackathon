import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class BoxHistoryProvider extends ActionProvider {
  Future<Response> fetchBoxHistory(page) async {
    return await get(
      '/boxes?type=unbox&page=$page',
    );
  }
}
