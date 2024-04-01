import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class GiftProvider extends ActionProvider {
  Future<Response<dynamic>> fetchGiftList(int page) async {
    return await get('/gifts?type=gift&page=$page');
  }

  Future<Response<dynamic>> fetchVoucherDetail(int id) async {
    return await get('/gifts/$id');
  }

  Future<Response<dynamic>> fetchVoucherHistoryList(int page) async {
    return await get('/gifts?type=used&page=$page');
  }

  Future<Response<dynamic>> fetchVoucherExpiredList(int page) async {
    return await get('/gifts?type=expired&page=$page');
  }

  Future<Response<dynamic>> fetchVoucherQRCode(int id) async {
    return await get('/gifts/$id/qr_code');
  }
}
