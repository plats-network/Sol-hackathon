import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class FullScreenProgress extends StatelessWidget {
  const FullScreenProgress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorBlack.withOpacity(0.5),
      child: Center(
        child: Container(
          width: dimen80,
          height: dimen80,
          padding: const EdgeInsets.all(dimen4),
          decoration: BoxDecoration(
            color: colorBlack.withOpacity(0.6),
            borderRadius: BorderRadius.circular(dimen12),
          ),
          child: Image.asset(
            'assets/images/loading.gif',
            width: dimen50,
            height: dimen50,
          ),
        ),
      ),
    );
  }
}
