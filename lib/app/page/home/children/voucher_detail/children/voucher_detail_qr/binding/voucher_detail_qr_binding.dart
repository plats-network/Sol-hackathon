import 'package:get/instance_manager.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/children/voucher_detail_qr/controller/voucher_detail_qr_controller.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/children/voucher_detail_qr/provider/voucher_detail_qr_provider.dart';

class VoucherDetailQrBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VoucherDetailQrProvider());
    Get.lazyPut(() => VoucherDetailQrController());
  }
}
