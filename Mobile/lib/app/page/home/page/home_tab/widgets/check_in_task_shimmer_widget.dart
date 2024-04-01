import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class CheckInTaskShimmerWidget extends StatelessWidget {
  const CheckInTaskShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          color: colorWhite,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(dimen16),
                  child: Row(
                    children: <Widget>[
                      AppShimmer(
                        height: dimen14,
                        width: dimen100,
                        cornerRadius: dimen30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                    child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: AppShimmer(
                        cornerRadius: dimen16,
                        height: dimen150,
                      ),
                    );
                  },
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 8,
                  ),
                  itemCount: 5,
                )
                    // GridView.builder(
                    //   padding: const EdgeInsets.only(
                    //       top: dimen0,
                    //       left: dimen16,
                    //       right: dimen16,
                    //       bottom: dimen16),
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //       crossAxisCount: dimen2.toInt(),
                    //       mainAxisSpacing: dimen16,
                    //       crossAxisSpacing: dimen16,
                    //       childAspectRatio: dimen162 / dimen253),
                    //   itemCount: 4,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     //TODO add animation
                    //     return GestureDetector(
                    //       child: AppShimmer(
                    //         cornerRadius: dimen16,
                    //       ),
                    //     );
                    //   },
                    // ),
                    )
              ])),
    );
  }
}
