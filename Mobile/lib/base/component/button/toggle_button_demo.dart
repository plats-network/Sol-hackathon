import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plat_app/base/component/button/base_toggle_button.dart';

import 'checkbox_list.dart';

/// Require image assets: ```assets/images/btn_toggle_on.png```, ```assets/images/btn_toggle_off.png```
class ToggleButtonDemo extends StatelessWidget {
  var notification = false;
  var sound = false;

  ToggleButtonDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BaseToggleButton(text: 'Notification',
          checked: true,
          onCheckChanged: (value) {
            notification = value;
          },
        ),
        BaseToggleButton(text: 'Sound',
          checked: false,
          onCheckChanged: (value) {
            sound = value;
          },
        ),
        ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Notification: $notification, sound: $sound'),
                duration: Duration(seconds: 2),
              ));
            },
            child: Text('Submit'))
      ],
    );
  }
}
