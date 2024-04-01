import 'package:flutter/material.dart';
import 'package:plat_app/base/component/page/home/children/home/view/base_home_tab_page.dart';
import 'package:plat_app/base/component/page/home/children/setting/view/base_setting_tab_page.dart';
import 'package:plat_app/base/component/page/home/children/task/view/base_task_tab_page.dart';
import 'package:plat_app/base/component/page/home/controller/base_bottom_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:get/get.dart';

class BaseHomePage extends StatefulWidget {
  const BaseHomePage({Key? key}) : super(key: key);

  @override
  State<BaseHomePage> createState() => _BaseHomePageState();
}

class _BaseHomePageState extends State<BaseHomePage> {
  @override
  Widget build(BuildContext context) {
    const bottomInsets = dimen70 - dimen2;
    final BaseBottomController bottomController = Get.find();

    return Scaffold(
        bottomNavigationBar: Container(
          color: colorWhite,
          child: SizedBox(
            height: dimen70,
            child: TabBar(
              controller: bottomController.controller,
              tabs: bottomController.myTabs,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: colorPrimary, width: dimen2),
                insets:
                EdgeInsets.fromLTRB(dimen16, dimen0, dimen16, bottomInsets),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Container(
            color: colorF5F7F9,
            child: TabBarView(
              controller: bottomController.controller,
              children: <Widget>[
                BaseHomeTabPage(),
                BaseTaskTabPage(),
                BaseSettingTabPage(),
              ],
            ),
          ),
        ));
  }
}
