import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class QrCodeProvider extends UserProvider {
  Future<Response<dynamic>> scanQrCode(String type, String code) => post('/qr/qr-event',  {
        'type': type,
        'code': code,
      });
  Future<Response<dynamic>> resultScanQrCode(String taskId) => get('/tasks/$taskId');
    Future<Response<dynamic>> getTicket(String taskId) => get('/ticket/$taskId');
}
