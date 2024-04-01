import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BaseRadioButton extends StatelessWidget {
  final String text;
  final bool checked;
  final Function(bool) onCheckChanged;

  BaseRadioButton(
      {Key? key,
      required this.text,
      required this.checked,
      required this.onCheckChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onCheckChanged(checked);
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: dimen20,
            height: dimen20,
            child: checked
                ? Icon(
                    Icons.radio_button_checked_outlined,
                    color: colorPrimary,
                    size: dimen20,
                  )
                : Icon(
                    Icons.radio_button_off_outlined,
                    color: colorPrimary,
                    size: dimen20,
                  ),
          ),
          SizedBox(
            width: dimen20,
          ),
          Text(
            text,
            style: TextStyle(
                color: color495057, fontSize: dimen16, fontFamily: 'Inter'),
          ),
        ],
      ),
    );
  }
}
