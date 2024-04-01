import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class NftDetailPage extends StatelessWidget {
  const NftDetailPage({super.key});

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
      ]),
      Stack(
        children: [
          Positioned(
              bottom: dimen4,
              left: dimen16,
              right: dimen16,
              child: Container(
                color: colorWhite,
                child: AppButton(
                  title: 'apply_now'.tr,
                  onTap: () {
                    Get.offNamed(Routes.voucherDetailQr);
                  },
                ),
              )),
        ],
      )
    ]);
  }
}
