import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/qrcode/controller/qrcode_controller.dart';
import 'package:plat_app/app/page/home/page/qrcode/provider/qr_code_provider.dart';

class QrCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QrCodeProvider());
    Get.lazyPut(() => QrCodeController());
  }
}
