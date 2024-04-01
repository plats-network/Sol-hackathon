import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/voucher_clipper.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class VoucherCard extends StatelessWidget {
  final String imageUrl;
  final String? topTitle;
  final String? middleTitle;
  final Widget? bottomTitle;
  final VoidCallback? onTap;

  const VoucherCard({
    super.key,
    required this.imageUrl,
    this.topTitle,
    this.middleTitle,
    this.bottomTitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: dimen16,
      ),
      decoration: BoxDecoration(
        // color: colorWhite,
        borderRadius: border8,
        boxShadow: [
          BoxShadow(
            color: color32302D.withOpacity(0.12),
            offset: const Offset(dimen0, dimen4),
            blurRadius: dimen24,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: ClipPath(
        clipper: VoucherClipper(),
        child: Material(
          color: colorWhite,
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Stack(clipBehavior: Clip.none, children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: dimen30),
                    width: dimen96,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: border50,
                        child: AppCachedImage(
                          imageUrl: imageUrl,
                          width: dimen64,
                          height: dimen64,
                          fit: BoxFit.cover,
                          cornerRadius: dimen50,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: CustomPaint(
                      foregroundPainter: DottedBorderPainter(),
                    ),
                  ),
                ]),
                //dotted border only as a line

                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                        top: 12, bottom: 16, left: 22, right: 19),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (topTitle != null)
                          Row(
                            children: [
                              Flexible(
                                child:
                                    Text(topTitle!, style: text12_9C9896_400),
                              ),
                            ],
                          ),
                        if (middleTitle != null) ...[
                          verticalSpace8,
                          Text(middleTitle!, style: text16_32302D_700),
                        ],
                        if (bottomTitle != null) ...[
                          verticalSpace8,
                          bottomTitle!,
                        ],
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
