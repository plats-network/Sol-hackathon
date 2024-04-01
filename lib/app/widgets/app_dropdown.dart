import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class AppDropdown extends StatefulWidget {
  AppDropdown(
      {Key? key,
      required this.title,
      required this.data,
      this.hint = '',
      this.dropdownValue = '',
      required this.callback})
      : super(key: key);

  final String title;
  final List<String> data;
  final String hint;
  final Function(String x) callback;
  var dropdownValue = '';

  @override
  _AppDropdownState createState() => _AppDropdownState();
}

class _AppDropdownState extends State<AppDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: text16_32302D_700,
        ),
        verticalSpace4,
        Container(
          height: dimen44,
          decoration: BoxDecoration(
              borderRadius: border8,
              color: colorWhite,
              border: Border.all(color: colorF3F1F1, width: dimen1)),
          padding: const EdgeInsets.all(dimen12),
          child: DropdownButton(
            hint: Text(widget.hint),
            value: widget.dropdownValue == '' ? null : widget.dropdownValue,
            underline: Container(),
            icon: const Icon(
              Icons.keyboard_arrow_down,
              size: dimen20,
              color: color898989,
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.dropdownValue = newValue!;
                widget.callback(widget.dropdownValue);
              });
            },
            items: widget.data.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                ),
              );
            }).toList(),
            isExpanded: true,
          ),
        )
      ],
    );
  }
}
