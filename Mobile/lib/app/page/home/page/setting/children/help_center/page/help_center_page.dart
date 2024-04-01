import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({Key? key}) : super(key: key);

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    return CommonAppBarPage(
      title: 'help_center'.tr,
      child: Container(
        decoration: BoxDecoration(color: colorWhite),
        child: Column(children: [
          Container(),
        ]),
      ),
    );
  }
}
