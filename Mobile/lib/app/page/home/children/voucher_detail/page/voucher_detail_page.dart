import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/controller/voucher_detail_controller.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VoucherDetailPage extends StatefulWidget {
  const VoucherDetailPage({super.key});

  @override
  State<VoucherDetailPage> createState() => _VoucherDetailPageState();
}

class _VoucherDetailPageState extends State<VoucherDetailPage> {
  final String? voucherId = Get.arguments['voucher_id'];
  final isWebViewLoaded = false.obs;
  final _voucherDetailController = Get.find<VoucherDetailController>();

  @override
  Widget build(BuildContext context) {
    return CommonAppPage(children: [
      Column(children: [
        verticalSpace26,
        Row(
          children: [
            Expanded(
              child: Text('details'.tr,
                  style: text28_0E4C88_700, textAlign: TextAlign.center),
            ),
          ],
        ),
        verticalSpace24,
        Expanded(
            child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
          child: WebView(
            initialUrl: _voucherDetailController
                .fetchWebViewVoucherUrl(voucherId ?? ''),
            zoomEnabled: false,
            backgroundColor: colorBackground,
            onPageFinished: (value) {
              isWebViewLoaded.value = true;
            },
          ),
        )),
        Container(
          color: colorBackground,
          padding: const EdgeInsets.only(
              bottom: dimen16, left: dimen16, right: dimen16),
          child: Container(
            color: colorWhite,
            child: AppButton(
              title: 'apply_now'.tr,
              onTap: () {
                logEvent(
                    eventName: 'VOUCHER_DETAIL_APPLY_NOW',
                    eventParameters: {
                      'voucher_id': voucherId,
                    });

                Get.offNamed(Routes.voucherDetailQr, arguments: {
                  'voucher_id': voucherId,
                });
              },
            ),
          ),
        )
      ]),
      Obx(() => isWebViewLoaded.value ? Container() : FullScreenProgress())
    ]);
  }
}
