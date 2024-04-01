import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class SocialListShimmerWidget extends StatelessWidget {
  const SocialListShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorWhite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      top: dimen0,
                      left: dimen16,
                      right: dimen16,
                      bottom: dimen16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (BuildContext context, int index) {
                    return const TaskItem();
                  },
                ),
              )
            ]));
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: dimen8, bottom: dimen8),
      child: Container(
        height: dimen309,
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: border16,
          boxShadow: const [
            BoxShadow(
              color: colorE4E1E1,
              blurRadius: dimen3,
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: dimen190,
                      width: double.infinity,
                      child: AppShimmer(
                        cornerRadius: dimen16,
                      )),
                  Positioned(
                    bottom: dimen12,
                    left: dimen16,
                    child: Container(
                      width: dimen54,
                      height: dimen16,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: dimen6,
                            right: dimen6,
                            top: dimen2,
                            bottom: dimen2),
                        child: AppShimmer(height: dimen10, width: dimen42),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: dimen71,
                  padding: const EdgeInsets.only(
                      top: dimen12,
                      left: dimen16,
                      right: dimen16,
                      bottom: dimen12),
                  child: AppShimmer(height: dimen16, width: double.infinity)),
              Container(
                  height: dimen28,
                  padding: const EdgeInsets.only(
                      top: dimen0, left: dimen16, right: dimen10),
                  child: Row(
                    children: [
                      AppShimmer(height: dimen28, width: dimen28),
                      Padding(
                        padding: const EdgeInsets.only(left: dimen8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppShimmer(height: dimen10, width: dimen45),
                            Row(
                              children: [
                                AppShimmer(height: dimen12, width: dimen40),
                                horizontalSpace1,
                                //TODO API return wrong name value "Mystery box." => "Mystery box"
                                AppShimmer(height: dimen12, width: dimen100),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }
}
