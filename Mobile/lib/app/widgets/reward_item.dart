import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class RewardItem extends StatelessWidget {
  const RewardItem(
      {Key? key,
      this.image,
      this.amount,
      this.name,
      this.onSeeDetailTap,
      this.backgroundColor = colorECF3F6})
      : super(key: key);

  final String? image;
  final int? amount;
  final String? name;
  final VoidCallback? onSeeDetailTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final String displayText =
        (amount != null ? '$amount ' : '') + (name ?? '');
    return GestureDetector(
      onTap: onSeeDetailTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: dimen24),
        padding:
            const EdgeInsets.symmetric(horizontal: dimen16, vertical: dimen12),
        decoration: BoxDecoration(
          border: Border.all(color: colorC8E9CF),
          borderRadius: BorderRadius.circular(dimen24),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: dimen56,
                height: dimen56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  color: backgroundColor,
                ),
                padding: EdgeInsets.all(dimen9),
                child: image != null
                    ? AppCachedImage(
                        imageUrl: image ?? '',
                        fit: BoxFit.cover,
                        width: dimen56,
                        height: dimen56,
                      )
                    : Container()),
            horizontalSpace8,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          displayText,
                          style: text18_469B59_700,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace8,
                  Text(
                    'see_details'.tr,
                    style: text14_177FE2_600,
                    maxLines: 1,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
