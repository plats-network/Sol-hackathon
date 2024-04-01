import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class AssetsTrayItemShimmer extends StatefulWidget {
  const AssetsTrayItemShimmer({
    super.key,
  });

  @override
  State<AssetsTrayItemShimmer> createState() => _AssetsTrayItemShimmerState();
}

class _AssetsTrayItemShimmerState extends State<AssetsTrayItemShimmer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(borderRadius: border50),
                      child: AppShimmer(
                        width: dimen32,
                        height: dimen32,
                        cornerRadius: dimen50,
                      ),
                    ),
                    horizontalSpace8,
                    Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppShimmer(
                              width: Get.width * 0.3,
                              height: dimen14,
                            ),
                            verticalSpace4,
                            AppShimmer(
                              width: Get.width * 0.2,
                              height: dimen12,
                            ),
                          ]),
                    )
                  ],
                ),
                // Text(mockTrayListItem)
              ],
            ),
          ),

          // right column
          AppShimmer(
            width: Get.width * 0.2,
            height: dimen14,
          ),
        ]),
        Column(
          children: [
            verticalSpace12,
            // bottom row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(dimen4),
                  decoration: const BoxDecoration(color: colorE9F4EC),
                  child: AppShimmer(
                    width: Get.width * 0.2,
                    height: dimen10,
                  ),
                ),
                AppShimmer(
                  width: Get.width * 0.2,
                  height: dimen28,
                )
              ],
            )
          ],
        )
      ],
    );
  }
}
