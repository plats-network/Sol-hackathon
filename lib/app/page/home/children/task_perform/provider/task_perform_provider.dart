import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class TaskPerformProvider extends ActionProvider {
  Future<Response<dynamic>> fetchDoingTask() => get('/tasks/doing');

  Future<Response<dynamic>> patchCancelTask(String taskId) =>
      patch('/tasks/$taskId/cancel', null);
}
