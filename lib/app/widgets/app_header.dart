import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({Key? key, this.title, this.onBack}) : super(key: key);
  final String? title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWhite,
      padding: EdgeInsets.all(dimen8),
      child: Row(
        children: [
          Material(
            color: colorTransparent,
            child: InkWell(
                onTap: onBack ?? Get.back,
                child: Padding(
                  padding: EdgeInsets.all(dimen8),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    size: dimen24,
                  ),
                )),
          ),
          horizontalSpace8,
          title != null
              ? Expanded(
                  child: Text(
                    title ?? '',
                    style: text16_2C2C2C_600,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
