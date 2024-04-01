import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class AppTopNavigation extends StatelessWidget {
  const AppTopNavigation({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppBackButton(onTab: () => Get.back()),
          Text(
            'notification'.tr,
            style: text24_32302D_700,
          ),
          InkWell(
            borderRadius: border20,
            onTap: () {},
            child: Image.asset(
              getAssetImage(AssetImagePath.search_icon),
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
    );
  }
}
