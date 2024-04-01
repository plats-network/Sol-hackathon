import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BaseCheckBox extends StatefulWidget {
  bool checked;
  final Function(bool) onCheckChanged;
  final Widget? child;

  BaseCheckBox({
    Key? key,
    required this.child,
    required this.checked,
    required this.onCheckChanged,
  }) : super(key: key);

  @override
  State<BaseCheckBox> createState() => _BaseCheckBoxState();
}

class _BaseCheckBoxState extends State<BaseCheckBox> {
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
            width: dimen24,
            height: dimen24,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.checked ? colorPrimary : colorTransparent,
                border: Border.all(
                    width: dimen2,
                    color: widget.checked ? colorPrimary : colorDCDCDC)),
            child: widget.checked
                ? Icon(
                    Icons.check,
                    size: dimen12,
                    color: colorWhite,
                  )
                : SizedBox(width: dimen12, height: dimen12),
          ),
          horizontalSpace10,
          widget.child ?? widget.child!,
        ],
      ),
    );
  }
}
