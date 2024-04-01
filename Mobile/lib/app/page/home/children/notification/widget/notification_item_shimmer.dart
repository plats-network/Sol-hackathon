import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class NotificationItemShimmer extends StatelessWidget {
  const NotificationItemShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: colorF3F1F1)),
          ),
          padding: EdgeInsets.symmetric(horizontal: dimen16, vertical: dimen8),
          child: Row(children: [
            AppShimmer(width: 48, height: 48, cornerRadius: dimen50),
            horizontalSpace20,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(width: double.infinity, height: dimen40),
                  verticalSpace8,
                  AppShimmer(width: double.infinity, height: dimen14),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
