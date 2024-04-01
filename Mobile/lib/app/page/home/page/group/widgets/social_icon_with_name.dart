import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class SocialIconWithName extends StatelessWidget {
  final String type;
  final VoidCallback? onTap;
  const SocialIconWithName({super.key, required this.type, this.onTap});

  @override
  Widget build(BuildContext context) {
    final icon = getIcon(type);
    final text = getText(type);

    return Material(
      borderRadius: border8,
      child: Container(
        margin: const EdgeInsets.only(right: dimen4),
        child: InkWell(
          onTap: onTap,
          borderRadius: border8,
          child: Container(
            padding: const EdgeInsets.all(dimen8),
            decoration: BoxDecoration(
              color: colorWhite,
              border: Border.all(color: colorF3F1F1, width: dimen1),
              borderRadius: border8,
            ),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              icon,
              horizontalSpace4,
              text,
            ]),
          ),
        ),
      ),
    );
  }

  Widget getIcon(type) {
    String path;
    var colorIcon;

    switch (type) {
      case 'facebook':
        path = AssetImagePath.facebook_2;
        colorIcon = color1870E5;
        break;
      case 'twitter':
        path = AssetImagePath.twitter;
        colorIcon = color1D93E3;
        break;
      case 'youtube':
        path = AssetImagePath.youtube2;
        colorIcon = colorF20200;
        break;
      case 'discord':
        path = AssetImagePath.discord;
        colorIcon = color5260E6;
        break;
      case 'telegram':
        path = AssetImagePath.telegram;
        colorIcon = color30A1DB;
        break;
      case 'instagram':
        path = AssetImagePath.instagram;
        break;
      default:
        path = AssetImagePath.facebook_2;
    }

    return Image.asset(
      getAssetImage(path),
      width: dimen18,
      height: dimen18,
      color: colorIcon,
    );
  }

  Widget getText(type) {
    switch (type) {
      case 'facebook':
        return const Text('Facebook', style: text14_32302D_400);
      case 'twitter':
        return const Text('Twitter', style: text14_32302D_400);
      case 'instagram':
        return const Text('Instagram', style: text14_32302D_400);
      case 'youtube':
        return const Text('Youtube', style: text14_32302D_400);
      case 'discord':
        return const Text('Discord', style: text14_32302D_400);
      case 'telegram':
        return const Text('Telegram', style: text14_32302D_400);
      default:
        return const Text('Facebook', style: text14_32302D_400);
    }
  }
}
