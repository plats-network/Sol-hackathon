import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class BoxDetailProvider extends ActionProvider {
  Future<Response<dynamic>> fetchBoxDetailProvider(String boxId) =>
      get('/boxes/$boxId');

  Future<Response<dynamic>> putUnbox(String boxId) => put('/boxes/$boxId', {});
}
