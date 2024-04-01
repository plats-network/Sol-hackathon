import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class SocialTaskDetailProvider extends ActionProvider {
  Future<Response<dynamic>> fetchTaskTaskDetail(String taskId) =>
      get('/tasks/$taskId');
  Future<Response<dynamic>> getTicket(String taskId) => get('/ticket/$taskId');

  Future<Response<dynamic>> LikeOrPinTask(String taskId, String type) {
    return post('/tasks/like-pin', {'task_id': taskId, 'type': type});
  }

  Future<Response<dynamic>> startSocialTask(String taskId, String type) {
    return post('/tasks/start-cancel', {'task_id': taskId, 'type': type});
  }

  Future<Response<dynamic>> postSubmitSocialTask(
          String taskId, String socialId, String type) =>
      post('/tasks/$taskId/social/$socialId', {
        'type': type,
      });

  Future<Response<dynamic>> postSubmitStartJob(
          String taskId, String jobId, String type) =>
      post('/tasks/start-job',
          {"task_id": taskId, "job_id": jobId, "type": type});
}
