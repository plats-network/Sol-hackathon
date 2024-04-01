import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/children/voucher_detail_qr/model/voucher_detail_qr_response.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/children/voucher_detail_qr/provider/voucher_detail_qr_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class VoucherDetailQrController extends GetxController {
  final voucherDetailQrData =
      Rx(NetworkResource<VoucherDetailQrResponse>.init());
  final VoucherDetailQrProvider voucherDetailQrProvider = Get.find();

  Future<void> fetchVoucherDetailQr(String voucherId) async {
    voucherDetailQrData.value =
        NetworkResource<VoucherDetailQrResponse>.loading();

    final result = await voucherDetailQrProvider.getVoucherDetailQr(voucherId);

    NetworkResource.handleResponse(
      result,
      VoucherDetailQrResponse.fromJson,
      voucherDetailQrData,
      isShowError: true,
    );
  }

  bool isGettingVoucherDetailQr() {
    return voucherDetailQrData.value.isLoading();
  }
}
