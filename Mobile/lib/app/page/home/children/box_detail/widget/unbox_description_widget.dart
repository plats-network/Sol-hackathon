import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BoxType {
  static const token = 0;
  static const nft = 1;
  static const voucher = 2;
  static const coupon = 3;
}

class UnboxDescriptionWidget extends StatelessWidget {
  final String value;
  final int type;
  final String name;

  const UnboxDescriptionWidget(
      {Key? key, required this.value, required this.type, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      decoration: BoxDecoration(
          border: Border.all(color: colorC8E9CF),
          borderRadius: BorderRadius.circular(dimen24),
          color: colorBackground),
      padding: const EdgeInsets.symmetric(vertical: dimen12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (type == BoxType.token)
            Text(
              '$value ${'PSP'.tr}\n${'plats_network_points'.tr}',
              style: text18_469B59_700.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            )
          else if (type == BoxType.nft)
            Text(
              '1 NFT\n$name',
              style: text18_469B59_700.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            )
          else if (type == BoxType.voucher)
            Text(
              '1 Voucher\n$name',
              style: text18_469B59_700.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            )
          else if (type == BoxType.coupon)
            Text(
              '1 ${'coupon'.tr}\n$name',
              style: text18_469B59_700.copyWith(height: 1.5),
              textAlign: TextAlign.center,
            )
        ],
      ),
    );
  }
}
