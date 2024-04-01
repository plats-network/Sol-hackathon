import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class AppButton extends StatelessWidget {
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
  final Widget? leftIcon;
  final Border? border;
  static const DEFAULT_BUTTON_HEIGHT = dimen48;

  const AppButton(
      {Key? key,
      this.title = '',
      this.backgroundColor = colorPrimary,
      this.margin = dimen0,
      this.horizontalPadding = dimen32,
      this.onTap,
      this.textColor = colorWhite,
      this.isEnable = true,
      this.disableBackgroundColor = colorDisabledButton,
      this.disableTextColor = colorWhite,
      this.isPrimaryStyle = true,
      this.height = DEFAULT_BUTTON_HEIGHT,
      this.textStyle,
      this.leftIcon,
      this.border})
      : super(key: key);

  Color fetchBackgroundColor() {
    if (isEnable) {
      if (isPrimaryStyle) {
        return backgroundColor;
      } else {
        return colorWhite;
      }
    } else {
      if (isPrimaryStyle) {
        return disableBackgroundColor;
      } else {
        return colorWhite;
      }
    }
  }

  BoxBorder? fetchBorder() {
    if (isPrimaryStyle) {
      return border;
    } else {
      if (!isEnable) return Border.all(color: disableBackgroundColor);
      return border ?? Border.all(color: backgroundColor);
    }
  }

  TextStyle fetchTextStyle() {
    if (isPrimaryStyle) {
      return textStyle ?? text14_white_600;
    } else {
      if (!isEnable) return textStyle ?? text14_32171716_400;

      return textStyle ?? text14_primary_600;
    }
  }

  @override
  Widget build(BuildContext context) {
    BoxBorder? customBorder = fetchBorder();
    Color customBgColor = fetchBackgroundColor();
    TextStyle customTextStyle = fetchTextStyle();

    return InkWell(
      onTap: isEnable ? onTap : null,
      borderRadius:
          const BorderRadius.all(Radius.circular(DEFAULT_BUTTON_HEIGHT / 2)),
      child: Container(
        height: height,
        margin: EdgeInsets.all(margin),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
              Radius.circular(DEFAULT_BUTTON_HEIGHT / 2)),
          color: customBgColor,
          // for outline type of button
          border: customBorder,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (leftIcon != null) leftIcon!,
            if (leftIcon != null) const SizedBox(width: dimen16),
            Center(
              child: Text(title,
                  style: customTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
