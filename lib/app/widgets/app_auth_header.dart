import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AppAuthHeader extends StatefulWidget {
  String title;

  AppAuthHeader({super.key, required this.title});

  @override
  State<AppAuthHeader> createState() => _AppAuthHeaderState();
}

class _AppAuthHeaderState extends State<AppAuthHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      verticalSpace47,
      Image.asset(
        getAssetImage(AssetImagePath.logo_plats_04),
        width: 115,
        height: 115,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: Text(
          widget.title,
          style: text28_32302D_700,
        ),
      ),
    ]);
  }
}
