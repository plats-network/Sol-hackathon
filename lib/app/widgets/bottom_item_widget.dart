import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BottomItem extends StatefulWidget {
  const BottomItem(
      {Key? key,
      required this.iconDefault,
      required this.iconSelected,
      required this.text,
      required this.isSelected,
      this.notification = 0})
      : super(key: key);

  final Widget iconDefault;
  final Widget iconSelected;
  final String text;
  final bool isSelected;
  final int notification;

  @override
  State<BottomItem> createState() => _BottomItemState();
}

class _BottomItemState extends State<BottomItem> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 3;
    return SizedBox(
      height: 60,
      width: width,
      child: Column(
        children: [
          Container(
            color: widget.isSelected ? colorPrimary : colorWhite,
            height: 2.0,
            margin: const EdgeInsets.symmetric(horizontal: 36.0),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.isSelected ? widget.iconSelected : widget.iconDefault,
                verticalSpace4,
                Text(widget.text,
                    style: TextStyle(
                        color: widget.isSelected ? colorBlack : colorTextMain,
                        fontSize: dimen12))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
