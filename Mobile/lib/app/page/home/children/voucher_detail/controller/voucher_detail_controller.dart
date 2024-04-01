import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/provider/voucher_detail_provider.dart';

class VoucherDetailController extends GetxController {
  final VoucherDetailProvider _voucherDetailProvider = Get.find();

  String fetchWebViewVoucherUrl(String voucherId) {
    return _voucherDetailProvider.fetchWebViewVoucherUrl(voucherId);
  }
}
