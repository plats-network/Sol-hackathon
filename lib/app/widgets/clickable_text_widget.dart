import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';

class ClickableTextWidget extends StatelessWidget {
  const ClickableTextWidget({Key? key, required this.text, required this.onTap})
      : super(key: key);
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: colorTransparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(dimen8),
          child: Text(
            text,
            style: text12_primary_400.copyWith(
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }
}
