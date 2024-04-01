import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:plat_app/base/component/button/base_radio_button.dart';

import 'base_checkbox.dart';

class RadioButtonList extends StatefulWidget {
  Map<String, bool> values;

  RadioButtonList({Key? key, required this.values}) : super(key: key) {
    // Validate values
    var checked = false;
    for (var key in values.keys) {
      if (checked == true) {
        values[key] = false;
      } else if(values[key] == true) {
        checked = true;
      }
    }
  }

  @override
  State<RadioButtonList> createState() => _RadioButtonListState();
}

class _RadioButtonListState extends State<RadioButtonList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.values.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: index == widget.values.length - 1
                  ? const EdgeInsets.only()
                  : const EdgeInsets.only(bottom: 12),
              child: BaseRadioButton(
                  text: widget.values.keys.elementAt(index),
                  checked: widget.values[widget.values.keys.elementAt(index)] ??
                      false,
                  onCheckChanged: (value) {
                    setState(() {
                      var values = widget.values;
                      values.updateAll((key, value) => value = false);
                      values[values.keys.elementAt(index)] = !value;
                      widget.values = values;
                      print(widget.values);
                    });
                  }));
        });
  }
}
