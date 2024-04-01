import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final double margin;
  final double horizontalPadding;
  final VoidCallback? onTap;
  final Color textColor;
  final bool isEnable;
  final bool isPrimaryStyle;
  final Color disableBackgroundColor;
  final Color disableTextColor;
  final double height;
  final TextStyle? textStyle;

  const BaseButton(
      {Key? key,
      this.title = '',
      this.backgroundColor = colorPrimary,
      this.margin = 0,
      this.horizontalPadding = dimen4,
      this.onTap,
      this.textColor = colorWhite,
      this.isEnable = true,
      this.disableBackgroundColor = colorDisabledButton,
      this.disableTextColor = colorWhite,
      this.isPrimaryStyle = true,
      this.height = dimen46,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? onTap : null,
      child: Container(
        height: height,
        margin: EdgeInsets.all(margin),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          borderRadius: border4,
          color: !isEnable
              ? disableBackgroundColor
              : isPrimaryStyle
                  ? backgroundColor
                  : colorDisabledButton,
        ),
        child: Center(
          child: Text(
            title,
            style: textStyle ??
                TextStyle(
                    fontSize: dimen14,
                    color: !isEnable
                        ? disableTextColor
                        : isPrimaryStyle
                            ? textColor
                            : colorWhite,
                    fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
