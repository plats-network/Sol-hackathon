import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/children/voucher_detail_qr/controller/voucher_detail_qr_controller.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:qr_flutter/qr_flutter.dart';

class VoucherDetailQrPage extends StatefulWidget {
  VoucherDetailQrPage({super.key});

  @override
  State<VoucherDetailQrPage> createState() => _VoucherDetailQrPageState();
}

class _VoucherDetailQrPageState extends State<VoucherDetailQrPage> {
  final String? voucherId = Get.arguments['voucher_id'];

  final VoucherDetailQrController voucherDetailQrController = Get.find();

  @override
  void initState() {
    super.initState();

    voucherDetailQrController.fetchVoucherDetailQr(voucherId!);
  }

  @override
  Widget build(BuildContext context) {
    return CommonAppPage(children: [
      Container(
        margin: EdgeInsets.symmetric(horizontal: dimen16),
        child: Column(children: [
          verticalSpace26,
          Row(
            children: [
              Expanded(
                child: Text('details'.tr,
                    style: text28_0E4C88_700, textAlign: TextAlign.center),
              ),
            ],
          ),
          verticalSpace40,
          Obx(
            () => voucherDetailQrController.isGettingVoucherDetailQr()
                ? AppShimmer(width: dimen200, height: dimen24)
                : Text(
                    voucherDetailQrController
                            .voucherDetailQrData.value.data?.data?.name ??
                        '',
                    style: text24_32302D_700),
          ),
          verticalSpace16,
          Container(
            width: context.width,
            padding:
                EdgeInsets.symmetric(horizontal: dimen72, vertical: dimen32),
            decoration: BoxDecoration(
              color: colorWhite,
              border: Border.all(color: colorC8E9CF, width: 1),
              borderRadius: border16,
            ),
            child:
                Obx(() => voucherDetailQrController.isGettingVoucherDetailQr()
                    ? AppShimmer(width: dimen200, height: dimen200)
                    : Center(
                        child: QrImage(
                        data: voucherDetailQrController
                                .voucherDetailQrData.value.data?.data?.qrCode ??
                            '',
                        version: QrVersions.auto,
                        size: 200.0,
                      ))),
          )
        ]),
      ),
    ]);
  }
}
