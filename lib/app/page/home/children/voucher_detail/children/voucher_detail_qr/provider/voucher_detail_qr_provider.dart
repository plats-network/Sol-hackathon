import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class VoucherDetailQrProvider extends ActionProvider {
  Future<Response<dynamic>> getVoucherDetailQr(String id) async {
    return await get('/$id/qr_code');
  }
}
