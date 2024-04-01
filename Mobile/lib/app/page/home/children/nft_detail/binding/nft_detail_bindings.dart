import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/nft_detail/controller/nft_detail_controller.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/controller/voucher_detail_controller.dart';

class NftDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NftDetailController>(() => NftDetailController());
  }
}
