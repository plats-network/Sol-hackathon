import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        verticalSpace74,
        Image(
          image: AssetImage(getAssetImage(AssetImagePath.no_data)),
          width: dimen200,
        ),
        Text(
          'no_data'.tr,
          style: text16_2C2C2C_600,
        )
      ],
    );
  }
}
