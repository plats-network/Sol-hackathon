import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';

class AppCheckBox extends StatefulWidget {
  final String text;
  bool checked;
  final Function(bool) onCheckChanged;

  AppCheckBox(
      {Key? key,
      required this.text,
      required this.checked,
      required this.onCheckChanged})
      : super(key: key);

  @override
  State<AppCheckBox> createState() => _AppCheckBoxState();
}

class _AppCheckBoxState extends State<AppCheckBox> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          widget.checked = !widget.checked;
          widget.onCheckChanged(widget.checked);
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: dimen20,
            height: dimen20,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: widget.checked ? colorPrimary : colorTransparent,
                border: Border.all(
                    width: dimen1,
                    color: colorPrimary),
            borderRadius: border4),
            child: widget.checked
                ? Icon(
                    Icons.check,
                    size: dimen16,
                    color: colorWhite,
                  )
                : SizedBox(width: dimen12, height: dimen12),
          ),
          horizontalSpace10,
          Text(
            widget.text,
            style: text12_898989_400,
          ),
          horizontalSpace20,
        ],
      ),
    );
  }
}
