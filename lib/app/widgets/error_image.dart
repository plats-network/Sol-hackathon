import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';

Widget imageErrorWidgetBuilderWidthHeight(context, error, stackTrace,
    {double? width, double? height, BorderRadius? borderRadius}) {
  return Container(
    width: width,
    height: height,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
        color: colorF5F7F9, borderRadius: borderRadius ?? border8),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: AssetImage(getAssetImage(AssetImagePath.image_error)),
          width: width ?? dimen40,
          height: height ?? dimen40,
        ),
      ],
    ),
  );
}
