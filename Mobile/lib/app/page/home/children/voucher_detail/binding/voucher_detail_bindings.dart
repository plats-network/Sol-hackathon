import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/controller/voucher_detail_controller.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/provider/voucher_detail_provider.dart';

class VoucherDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherDetailProvider>(() => VoucherDetailProvider());
    Get.lazyPut<VoucherDetailController>(() => VoucherDetailController());
  }
}
