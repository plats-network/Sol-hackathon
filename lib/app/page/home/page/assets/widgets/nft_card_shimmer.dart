import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class NftCardShimmer extends StatelessWidget {
  const NftCardShimmer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color32302D.withOpacity(0.12),
            offset: Offset(0, 4),
            blurRadius: 24,
          ),
        ],
      ),
      child: Material(
        color: colorWhite,
        borderRadius: BorderRadius.all(Radius.circular(dimen16)),
        child: InkWell(
          onTap: () => Get.toNamed(Routes.nftDetail),
          borderRadius: BorderRadius.all(Radius.circular(dimen16)),
          child: Container(
            height: dimen238,
            decoration: BoxDecoration(),
            child: Column(
              children: [
                Stack(
                  children: [
                    AppShimmer(
                      height: dimen125,
                      width: context.width,
                      cornerRadius: dimen16,
                    ),
                    Positioned(
                        left: dimen12,
                        bottom: dimen16,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: dimen6, vertical: dimen2),
                          decoration: BoxDecoration(
                              color: color469B59,
                              borderRadius: BorderRadius.circular(dimen3)),
                          child: Text('image', style: text10_white_600),
                        )),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: dimen16, right: dimen8),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: dimen12),
                            child: AppShimmer(
                              height: dimen16,
                              width: context.width * 0.5,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: dimen12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AppShimmer(
                                  height: dimen28,
                                  width: dimen28,
                                  cornerRadius: dimen50,
                                ),
                                horizontalSpace8,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppShimmer(
                                      height: dimen10,
                                      width: context.width * 0.2,
                                    ),
                                    AppShimmer(
                                      height: dimen10,
                                      width: context.width * 0.2,
                                    ),
                                    AppShimmer(
                                      height: dimen10,
                                      width: context.width * 0.2,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ]),
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
