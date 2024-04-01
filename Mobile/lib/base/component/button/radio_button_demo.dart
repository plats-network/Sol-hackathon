import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plat_app/base/component/button/radio_button_list.dart';

class RadioButtonDemo extends StatelessWidget {
  final Map<String, bool> values = {
    '12314': false,
    'stgxd sdfgs': true,
    'asdf asfdg': false,
    'sdf gs fdsaf': false,
    'adsf  fhsr tg sdf': false,
  };

  RadioButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioButtonList(
          values: values,
        ),
        ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(values.entries.firstWhere((element) => element.value == true).key.toString()),
                duration: Duration(seconds: 2),
              ));
            },
            child: Text('Submit'))
      ],
    );
  }
}
