import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/notify_provider.dart';

class NotificationProvider extends NotifyProvider {
  Future<Response<dynamic>> fetchListNotifications(type) =>
      get('/notifications?type=$type');

  Future<Response<dynamic>> fetchNotificationDetail(id) =>
      get('/notifications/$id');
}
