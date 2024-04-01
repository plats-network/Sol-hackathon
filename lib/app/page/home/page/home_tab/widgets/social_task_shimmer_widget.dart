import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_list/controller/social_list_controller.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/social_task_list_response.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class SocialTaskShimmerWidget extends StatelessWidget {
  const SocialTaskShimmerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorWhite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(dimen16),
                child: Row(
                  children: <Widget>[
                    AppShimmer(
                      height: dimen14,
                      width: dimen100,
                      cornerRadius: dimen30,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.checkInList);
                      },
                      child: AppShimmer(
                        height: dimen14,
                        width: dimen50,
                        cornerRadius: dimen30,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                child: GridView.builder(
                  padding: const EdgeInsets.only(
                      top: dimen0,
                      left: dimen16,
                      right: dimen16,
                      bottom: dimen16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: dimen2.toInt(),
                      mainAxisSpacing: dimen16,
                      crossAxisSpacing: dimen16,
                      childAspectRatio: dimen162 / dimen253),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    //TODO add animation
                    return GestureDetector(
                      child: AppShimmer(
                        cornerRadius: dimen16,
                      ),
                    );
                  },
                ),
              ),
              verticalSpace16
            ]));
  }
}

class SocialTaskItemShimmer extends StatelessWidget {
  const SocialTaskItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imgSize = dimen96;

    return Container(
      padding: EdgeInsets.all(dimen16),
      child: Row(
        children: [
          AppShimmer(
            width: imgSize,
            height: imgSize,
            cornerRadius: dimen4,
          ),
          horizontalSpace12,
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                constraints: BoxConstraints(
                    maxWidth: Get.width - imgSize - dimen16 * 4 - dimen12),
                child: Row(
                  children: [
                    Expanded(
                      child: AppShimmer(
                        width: Get.width - imgSize - dimen16 * 4 - dimen12,
                        height: dimen16,
                        cornerRadius: dimen4,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace24,
              Row(
                children: [
                  AppShimmer(
                    width: dimen28,
                    height: dimen28,
                    cornerRadius: dimen4,
                  ),
                  horizontalSpace8,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppShimmer(height: dimen10, width: dimen60),
                      Row(
                        children: [
                          AppShimmer(
                            height: dimen12,
                            width: dimen64,
                            cornerRadius: dimen4,
                          ),
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
