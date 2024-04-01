import 'package:flutter/widgets.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class AppSpacer extends StatelessWidget {
  const AppSpacer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: dimen8,
          decoration: BoxDecoration(
            color: colorE5E5E5.withOpacity(0.5),
            boxShadow: [
              BoxShadow(
                color: colorWhite.withOpacity(0.5),
                offset: const Offset(0, 0),
                blurRadius: 8,
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Container(
            height: dimen8,
            decoration: BoxDecoration(
              color: colorE5E5E5.withOpacity(0.5),
              boxShadow: [
                BoxShadow(
                  color: colorWhite.withOpacity(0.8),
                  offset: const Offset(0, 0),
                  blurRadius: 5,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
