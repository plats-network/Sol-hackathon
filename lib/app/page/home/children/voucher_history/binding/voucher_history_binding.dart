import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/voucher_history/controller/voucher_history_controller.dart';
import 'package:plat_app/app/page/home/children/voucher_history/provider/voucher_history_provider.dart';

class VoucherHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoucherHistoryProvider>(() => VoucherHistoryProvider());
    Get.lazyPut<VoucherHistoryController>(() => VoucherHistoryController());
  }
}
