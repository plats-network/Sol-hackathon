import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class IndexProvider extends UserProvider {
  // Future<Response<dynamic>> topEvents(String type) =>
  //     get('/top-events', query: {
  //       'type': type,
  //     });
  Future<Response<dynamic>> allEvents() => get('/tasks');
  Future<Response<dynamic>> trendingEvents() => get('/tasks?type=uptrend');
  Future<Response<dynamic>> upcomingEvents() => get('/tasks?type=upcoming');
  Future<Response<dynamic>> registeredEvents() => get('/tasks?type=regised');
  Future<Response<dynamic>> eventImprgress() => get('/event-imprgress');
  Future<Response<dynamic>> ongoingEvent(String eventId) =>
      get('/jobs/$eventId');
  Future<Response<dynamic>> LikeOrPinTask(String taskId, String type) {
    return post('/tasks/like-pin', {'task_id': taskId, 'type': type});
  }
}
