import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/component/spacer/assets_spacer.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class MainTrayCommonHeader extends StatelessWidget {
  const MainTrayCommonHeader({
    Key? key,
    this.onHistoryTap,
  }) : super(key: key);

  final VoidCallback? onHistoryTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AppSpacer(),
        verticalSpace24,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: dimen16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: onHistoryTap,
                child: Row(
                  children: [
                    Text(
                      'history'.tr,
                      style: text16_177FE2_600,
                    ),
                    horizontalSpace8,
                    Image.asset(
                      getAssetImage(AssetImagePath.ic_refresh_gray),
                      width: dimen24,
                      height: dimen24,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
        verticalSpace24,
      ],
    );
  }
}
