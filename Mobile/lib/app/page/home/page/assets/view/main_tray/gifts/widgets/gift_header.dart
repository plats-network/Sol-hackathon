import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/main_tray_common_header.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class VoucherHeader extends StatelessWidget {
  const VoucherHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainTrayCommonHeader(onHistoryTap: () {
      logEvent(eventName: 'GIFT_HISTORY_VIEW', eventParameters: {});
      Get.toNamed(Routes.voucherHistory);
    });
  }
}
