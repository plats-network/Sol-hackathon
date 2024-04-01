import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

/// Require image assets: ```assets/images/btn_toggle_on.png```, ```assets/images/btn_toggle_off.png```
class BaseToggleButton extends StatefulWidget {
  final String text;
  bool checked;
  final Function(bool) onCheckChanged;

  BaseToggleButton(
      {Key? key,
      required this.text,
      required this.checked,
      required this.onCheckChanged})
      : super(key: key);

  @override
  State<BaseToggleButton> createState() => _BaseToggleButtonState();
}

class _BaseToggleButtonState extends State<BaseToggleButton> {
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
          widget.checked
              ? Image.asset(
                  'assets/images/btn_toggle_on.png',
                  width: dimen44,
                )
              : Image.asset(
                  'assets/images/btn_toggle_off.png',
                  width: dimen44,
                ),
          horizontalSpace16,
          Expanded(
            child: Text(
              widget.text,
            ),
          ),
        ],
      ),
    );
  }
}
