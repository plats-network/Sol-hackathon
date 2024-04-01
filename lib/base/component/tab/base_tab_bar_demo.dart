import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plat_app/base/component/tab/base_tab_bar.dart';

import '../../resources/constants/base_colors.dart';

class BaseTabBarDemo extends StatelessWidget {
  final List<String> tabs = <String>['Active tab', 'Unactive tab'];

  @override
  Widget build(BuildContext context) {
    return BaseTabBar(
      tabs: tabs,
      currentIndex: 0,
      tabViews: [
        Container(
          color: colorError,
        ),
        Container(
          color: color27AE60,
        ),
      ],
    );
  }
}
