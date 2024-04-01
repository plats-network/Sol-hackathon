import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class CheckInListProvider extends ActionProvider {
  // get check in task list
  Future<Response<dynamic>> fetchCheckInTaskWithPageProvider(int page) =>
      get('/tasks?limit=4&page=$page');
}
