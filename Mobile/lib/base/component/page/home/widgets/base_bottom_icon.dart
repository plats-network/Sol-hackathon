import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/component/button/base_icon.dart';
import 'package:plat_app/base/component/page/home/controller/base_bottom_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BaseBottomIcon extends StatelessWidget {
  final IconData icon;
  final int index;

  const BaseBottomIcon({Key? key, required this.icon, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BaseBottomController bottomController = Get.find();

    return Obx(
      () => BaseIcon(
        iconName: icon,
        size: dimen24,
        color: (bottomController.currentIndex.value == index)
            ? colorPrimary
            : color898989,
      ),
    );
  }
}
