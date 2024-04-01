import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_ticket_provider_mixin.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:plat_app/base/component/page/home/widgets/base_bottom_icon.dart';
import 'package:plat_app/base/component/page/home/widgets/base_bottom_text.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BaseBottomController extends GetxController with GetSingleTickerProviderStateMixin {

  final List<Tab> myTabs = <Tab>[
    Tab(
      icon: BaseBottomIcon(icon: Icons.home_outlined, index: 0),
      iconMargin: EdgeInsets.all(dimen2),
      child: BaseBottomText(text: 'home', index: 0),
    ),
    Tab(
      icon: BaseBottomIcon(icon: Icons.menu, index: 1),
      iconMargin: EdgeInsets.all(dimen2),
      child: BaseBottomText(text: 'task', index: 1),
    ),
    Tab(
      icon: BaseBottomIcon(icon: Icons.settings, index: 2),
      iconMargin: EdgeInsets.all(dimen2),
      child: BaseBottomText(text: 'setting', index: 2),
    ),
  ];

  late TabController controller;
  var currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
    controller.addListener(() {
      currentIndex.value = controller.index;
    });
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}