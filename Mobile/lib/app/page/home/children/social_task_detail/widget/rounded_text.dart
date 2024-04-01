import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class RoundedText extends StatelessWidget {
  final bool? isActive;
  final String text;

  const RoundedText({
    Key? key,
    this.isActive,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dimen40,
      height: dimen40,
      decoration: BoxDecoration(
        color: isActive == true ? color469B59 : colorF3F1F1,
        borderRadius: border80,
      ),
      child: Center(
        child: isActive == true
            ? Image.asset(
                getAssetImage(AssetImagePath.check),
                width: dimen24,
                height: dimen24,
              )
            : Text(
                text,
                style: text16_32302D_700,
              ),
      ),
    );
  }
}
