import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class ButtonIcon extends StatelessWidget {
  const ButtonIcon(
      {Key? key,
      required this.icon,
      required this.title,
      required this.onTap,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.distance})
      : super(key: key);

  final IconData icon;
  final Widget? distance;
  final String title;
  final MainAxisAlignment mainAxisAlignment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(dimen12),
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              Icon(
                icon,
                size: dimen40,
                color: color1D71F2,
              ),
              distance ?? verticalSpace10,
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    color: color4E4E4E,
                    fontSize: dimen12),
              )
            ],
          ),
        ),
      ),
    );
  }
}
