import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class HomeTaskProvider extends ActionProvider {
  Future<Response<dynamic>> fetchSearch(String keyword) => get('/tasks?keyword=$keyword');
}
