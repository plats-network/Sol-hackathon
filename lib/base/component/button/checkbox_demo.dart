import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'checkbox_list.dart';

class CheckBoxDemo extends StatelessWidget {
  final Map<String, bool> values = {
    '12314': false,
    'stgxd sdfgs': true,
    'asdf asfdg': false,
    'sdf gs fdsaf': false,
    'adsf  fhsr tg sdf': false,
  };

  CheckBoxDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CheckBoxList(
          values: values,
        ),
        ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(values.toString()),
                duration: Duration(seconds: 2),
              ));
            },
            child: Text('Submit'))
      ],
    );
  }
}
