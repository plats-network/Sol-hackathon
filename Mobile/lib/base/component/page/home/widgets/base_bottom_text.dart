import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/component/page/home/controller/base_bottom_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BaseBottomText extends StatelessWidget {
  final TextStyle blackTextStyle = const TextStyle(
      fontSize: dimen12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: color2C2C2C);

  final TextStyle greyTextStyle = const TextStyle(
      fontSize: dimen12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Inter',
      color: color898989);

  final String? text;
  final int index;

  BaseBottomText({Key? key, required this.text, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BaseBottomController bottomController = Get.find();

    return Obx(
      () => Text(
        (text ?? '').tr,
        style: (bottomController.currentIndex.value == index)
            ? blackTextStyle
            : greyTextStyle,
      ),
    );
  }
}
