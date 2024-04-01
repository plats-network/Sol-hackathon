import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseDropdown extends StatefulWidget {
  BaseDropdown(
      {Key? key,
      required this.title,
      required this.data,
      this.hint = '',
      this.isDarkTheme = true,
      this.dropdownValue = '',
      required this.callback})
      : super(key: key);

  final String title;
  final List<String> data;
  final String hint;
  var isDarkTheme = true;
  final Function(String x) callback;
  var dropdownValue = '';

  @override
  _BaseDropdownState createState() => _BaseDropdownState();
}

class _BaseDropdownState extends State<BaseDropdown> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.isDarkTheme
            ? Text(
                widget.title,
              )
            : Container(),
        verticalSpace4,
        widget.isDarkTheme
            ? Container(
                height: dimen40,
                decoration:
                    BoxDecoration(borderRadius: border8, color: colorF5F7F9),
                padding: const EdgeInsets.only(left: dimen16, right: dimen11),
                child: DropdownButton(
                  hint: Text(
                      widget.hint.isNotEmpty
                          ? widget.hint
                          : 'choose_an_option'.tr),
                  value:
                      widget.dropdownValue == '' ? null : widget.dropdownValue,
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
                  items:
                      widget.data.map<DropdownMenuItem<String>>((String value) {
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
            : Container(
                height: dimen48,
                decoration:
                    BoxDecoration(borderRadius: border8, color: colorWhite),
                padding: const EdgeInsets.all(dimen12),
                child: DropdownButton(
                  hint: Text(widget.hint),
                  value:
                      widget.dropdownValue == '' ? null : widget.dropdownValue,
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
                  items:
                      widget.data.map<DropdownMenuItem<String>>((String value) {
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
