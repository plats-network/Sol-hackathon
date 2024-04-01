import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class PreviewPhotoProvider extends ActionProvider {
  Future<Response<dynamic>> postCheckInLocationInTask(
      String taskId, String locationId, FormData body) =>
      post('/tasks/$taskId/check-in/$locationId', body);
}