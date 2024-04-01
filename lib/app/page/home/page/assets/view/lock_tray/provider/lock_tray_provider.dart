import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class LockTrayProvider extends ActionProvider {
  Future<Response<dynamic>> fetchLockItemList(int page) async {
    return get('/lock_tray?page=$page');
  }

  Future<Response<dynamic>> putSendToMainTray(String id) {
    return put('/lock_tray/$id', {});
  }
    Future<Response<dynamic>> fetchRewrdList() async {
    return get('/user-rewards');
  }
}
