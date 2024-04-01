import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BaseIcon extends StatelessWidget {
  final VoidCallback? onClickCallback;
  final IconData iconName;
  final double size;
  final Color color;
  final String? imageName;
  final double width;
  final double height;

  const BaseIcon(
      {Key? key,
      this.onClickCallback,
      required this.iconName,
      this.size = dimen24,
      this.color = color898989,
      this.imageName,
      this.width = dimen24,
      this.height = dimen24})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickCallback,
      child: (imageName == null)
          ? Icon(
              iconName,
              color: color,
              size: size,
            )
          : Image(
              image: AssetImage('$assetsImage$imageName'),
              color: color,
              width: width,
              height: height,
            ),
    );
  }
}
