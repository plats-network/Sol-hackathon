import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:plat_app/app/page/home/page/assets/widgets/voucher_clipper.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class VoucherCardShimmer extends StatelessWidget {
  const VoucherCardShimmer({
    super.key,
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
          child: Row(
            children: [
              Stack(clipBehavior: Clip.none, children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: dimen30),
                  width: dimen96,
                  child: Center(
                    child: ClipRRect(
                      child: AppShimmer(
                        width: dimen64,
                        height: dimen64,
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
                      Row(
                        children: [
                          Flexible(
                            child: AppShimmer(
                              width: dimen100,
                              height: dimen12,
                              cornerRadius: dimen4,
                            ),
                          ),
                        ],
                      ),
                      verticalSpace8,
                      AppShimmer(
                        width: dimen150,
                        height: dimen16,
                        cornerRadius: dimen4,
                      ),
                      verticalSpace8,
                      AppShimmer(
                        width: dimen125,
                        height: dimen11,
                        cornerRadius: dimen4,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
