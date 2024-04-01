import 'package:flutter/material.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class CountryIconWithName extends StatelessWidget {
  final String text;
  final String iconUrl;
  final TextStyle textStyle;

  const CountryIconWithName({
    Key? key,
    this.text = 'vn',
    this.textStyle = text12_4E4E4E_400,
    this.iconUrl = 'https://i.imgur.com/4Z0ZQ9M.png',
  }) : super(key: key);

  String fetchCountryText(String text) {
    switch (text) {
      case 'vn':
        return 'Vietnam';
      default:
        return 'Global';
    }
  }

  String fetchImageUrl(String text) {
    switch (text) {
      case 'vn':
        return "https://i.imgur.com/liIF0TR.png";

      default:
        return "https://tinwritescode.github.io/plats-images/global_blue.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppCachedImage(
          imageUrl: fetchImageUrl(text),
          width: dimen18,
          height: dimen14,
          fit: BoxFit.contain,
        ),
        horizontalSpace4,
        Text(fetchCountryText(text), style: textStyle),
      ],
    );
  }
}
