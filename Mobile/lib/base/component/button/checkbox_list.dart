import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'base_checkbox.dart';

class CheckBoxList extends StatelessWidget {
  final Map<String, bool> values;

  const CheckBoxList({Key? key, required this.values}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: values.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: index == values.length - 1
                  ? const EdgeInsets.only()
                  : const EdgeInsets.only(bottom: 12),
              child: BaseCheckBox(
                  checked: values[values.keys.elementAt(index)] ?? false,
                  onCheckChanged: (value) {
                    values[values.keys.elementAt(index)] = value;
                    print(values);
                  },
                  child: Text(values.keys.elementAt(index))));
        });
  }
}
