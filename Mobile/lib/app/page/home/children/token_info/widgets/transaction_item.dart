import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class TransactionItem extends StatelessWidget {
  final String text;
  final String time;
  final String value;

  const TransactionItem(
      {super.key, required this.text, required this.time, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            Container(
              width: dimen32,
              height: dimen32,
              decoration: BoxDecoration(
                color: colorError,
                borderRadius: border50,
              ),
            ),
            horizontalSpace8,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text, style: text12_32302D_700),
                verticalSpace4,
                Text(time, style: text12_625F5C_400),
              ],
            ),
          ],
        ),
        Text(value, style: text12_625F5C_400),
      ],
    );
  }
}
