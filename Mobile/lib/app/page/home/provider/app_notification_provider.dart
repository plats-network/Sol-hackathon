import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/notify_provider.dart';

class AppNotificationProvider extends NotifyProvider {
  Future<Response<dynamic>> postCreateDeviceToken(body) =>
      post('/devices', body);

  Future<Response<dynamic>> deleteToken(token) => delete('/devices/$token');

  Future<Response<dynamic>> postTestNoti(body) => post('/test_noti', body);
}
