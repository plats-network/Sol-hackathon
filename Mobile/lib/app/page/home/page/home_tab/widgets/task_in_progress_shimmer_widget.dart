import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class TaskInProgressShimmerWidget extends StatelessWidget {
  const TaskInProgressShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWhite,
      height: dimen235,
      child: Padding(
        padding: const EdgeInsets.all(dimen16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: dimen16),
              child: AppShimmer(
                height: dimen22,
                width: dimen100,
              ),
            ),
            SizedBox(
              height: dimen154,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(
                    height: dimen154,
                    width: dimen161,
                  ),
                  horizontalSpace16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppShimmer(
                          height: dimen16,
                          width: dimen100,
                        ),
                        AppShimmer(
                          height: dimen40,
                          width: dimen120,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
