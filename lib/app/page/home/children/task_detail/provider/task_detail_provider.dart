import 'package:get/get_connect.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class TaskDetailProvider extends ActionProvider {
  Future<Response<dynamic>> fetchTaskDetail(String taskId) =>
      get('/tasks/$taskId');

  Future<Response<dynamic>> postStartTask(String taskId, String locationId,
          {bool force = false}) =>
      post('/tasks/$taskId/start/$locationId', {'start_task': force});
}
