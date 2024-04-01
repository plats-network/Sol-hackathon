import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class ListSocialTaskWidget extends StatefulWidget {
  const ListSocialTaskWidget({super.key});

  @override
  State<ListSocialTaskWidget> createState() => _ListSocialTaskWidgetState();
}

class _ListSocialTaskWidgetState extends State<ListSocialTaskWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: dimen8),
      itemBuilder: (context, index) {
        return titleItem(index: index);
      },
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => verticalSpace8,
      itemCount: 5,
    );
  }

  Widget titleItem({int? index}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: dimen16),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                getAssetImage(AssetImagePath.twitter),
                width: dimen20,
                height: dimen20,
                color: color1DA5F2,
              ),
              horizontalSpace10,
              Expanded(
                child: Text(
                  index == 0
                      ? 'Engage with @platsnetwork'
                      : index == 1
                          ? 'Follow @platsnetwork'
                          : index == 2
                              ? 'Like'
                              : index == 3
                                  ? 'Comment & Tag 3 friends'
                                  : index == 4
                                      ? 'Invite Tweet'
                                      : '',
                  style: GoogleFonts.quicksand(
                    fontSize: 14,
                    color: colorBlack,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              index == 0 || index == 3
                  ? Image.asset(
                      getAssetImage(AssetImagePath.check),
                      width: dimen25,
                      height: dimen25,
                      color: color1DA5F2,
                    )
                  : Container(
                      decoration: BoxDecoration(
                        color: color1DA5F2,

                        //  index == 0
                        //     ? color27AE60.withOpacity(0.1)
                        //     : index == 1
                        //         ? colorF4F9FE
                        //         : index == 2
                        //             ? colorEA4335.withOpacity(0.1)
                        //             : index == 3
                        //                 ? colorFFC006.withOpacity(0.1)
                        //                 : index == 4
                        //                     ? colorF4F9FE
                        //                     : colorF4F9FE,
                        borderRadius: BorderRadius.circular(dimen4),
                      ),
                      width: dimen80,
                      padding: const EdgeInsets.symmetric(
                        vertical: dimen8,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Image.asset(
                          //   index == 0
                          //       ? getAssetImage(AssetImagePath.retweet)
                          //       : index == 1
                          //           ? getAssetImage(AssetImagePath.twitter_outline)
                          //           : index == 2
                          //               ? getAssetImage(AssetImagePath.heart)
                          //               : index == 3
                          //                   ? getAssetImage(AssetImagePath.chat)
                          //                   : index == 4
                          //                       ? getAssetImage(
                          //                           AssetImagePath.twitter_outline)
                          //                       : '',
                          //   width: dimen14,
                          //   height: dimen14,
                          //   color: index == 0
                          //       ? color27AE60
                          //       : index == 1
                          //           ? color1DA5F2
                          //           : index == 2
                          //               ? colorEA4335
                          //               : index == 3
                          //                   ? colorFFC006
                          //                   : index == 4
                          //                       ? color1DA5F2
                          //                       : color1DA5F2,
                          // ),
                          // horizontalSpace5,
                          Text(
                            index == 0
                                ? 'Retweet'
                                : index == 1
                                    ? 'Follow'
                                    : index == 2
                                        ? 'Like'
                                        : index == 3
                                            ? 'Comment'
                                            : index == 4
                                                ? 'Tweet'
                                                : '',
                            style: GoogleFonts.quicksand(
                              fontSize: 13,
                              color: colorWhite,
                              //  index == 0
                              //     ? color27AE60
                              //     : index == 1
                              //         ? color1DA5F2
                              //         : index == 2
                              //             ? colorEA4335
                              //             : index == 3
                              //                 ? colorFFC006
                              //                 : index == 4
                              //                     ? color1DA5F2
                              //                     :
                              //                     color1DA5F2,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}
