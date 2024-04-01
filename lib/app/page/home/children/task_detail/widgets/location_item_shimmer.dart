import 'package:flutter/material.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class LocationItemShimmer extends StatelessWidget {
  const LocationItemShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppShimmer(width: dimen48, height: dimen40, cornerRadius: dimen8),
        horizontalSpace24,
        Expanded(
          child:
              AppShimmer(width: dimen48, height: dimen54, cornerRadius: dimen8),
        )
      ],
    );
  }
}
