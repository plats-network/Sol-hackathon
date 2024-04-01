import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({Key? key, required this.onTab}) : super(key: key);
  final VoidCallback? onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: border40,
      onTap: onTab,
      child: Image.asset(
        getAssetImage(AssetImagePath.back_button),
        width: dimen48,
        height: dimen48,
      ),
    );
  }
}
