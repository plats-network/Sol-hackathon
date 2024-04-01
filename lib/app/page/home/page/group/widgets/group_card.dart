import 'package:flutter/material.dart';
import 'package:plat_app/app/page/home/page/group/widgets/country_icon_with_name.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/group_model.dart';

class GroupCard extends StatefulWidget {
  final int maxDescriptionLines;
  final EdgeInsetsGeometry? infoPadding;
  final Map<String, dynamic>? group;

  final VoidCallback? onTap;

  final Data groupList;
  const GroupCard({
    Key? key,
    this.maxDescriptionLines = 4,
    this.infoPadding,
    this.group,
    this.onTap,
    required this.groupList,
  }) : super(key: key);

  @override
  State<GroupCard> createState() => _GroupCardState();
}

class _GroupCardState extends State<GroupCard> {
  final socialList = [
    'telegram',
    'discord',
    'twitter',
    'instagram',
    'youtube',
    'facebook',
  ];

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorWhite,
          boxShadow: [
            BoxShadow(
              color: colorBlack.withOpacity(0.12),
              offset: const Offset(dimen0, dimen4),
              blurRadius: dimen24,
            ),
          ],
          borderRadius: border16,
        ),
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        height: dimen300,
        child: Column(children: [
          Container(
            child: AppCachedImage(
              imageUrl: widget.groupList.cover_url ?? '',
              width: MediaQuery.of(context).size.width,
              height: dimen140,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
                horizontal: dimen16, vertical: dimen8),
            child: Row(
              children: [
                AppCachedImage(
                  imageUrl: widget.groupList.avatar_url ?? '',
                  width: dimen48,
                  height: dimen48,
                  cornerRadius: dimen80,
                  backgroundColor: colorWhite,
                ),
                horizontalSpace8,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.groupList.name ?? '',
                        style: text14_32302D_600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      verticalSpace8,
                      Row(
                        children: [
                          Text(
                            '@${widget.groupList.username}' ?? '',
                            style: text12_4E4E4E_400,
                          ),
                          horizontalSpace16,
                          CountryIconWithName(
                            text: widget.groupList.country ?? '',
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          verticalSpace10,
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: dimen16, vertical: dimen8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.groupList.desc_en ?? '',
                    style: text14_32302D_400,
                    maxLines: widget.maxDescriptionLines,
                    overflow: TextOverflow.fade,
                  ),
                  verticalSpace8,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text.rich(TextSpan(
                        text: 'See more',
                        style: text14_177FE2_400,
                      )),
                      Row(
                        children: [
                          ...List.generate(
                            socialList.length,
                            (index) => widget.group?[socialList[index]] !=
                                        null &&
                                    widget.group?[socialList[index]].isNotEmpty
                                ? Padding(
                                    padding:
                                        const EdgeInsets.only(left: dimen8),
                                    child: InkWell(
                                      onTap: () {
                                        launch(
                                            widget.group?[socialList[index]]);
                                      },
                                      child: Image.asset(
                                        getAssetImage(
                                            fetchIconPath(socialList[index])),
                                        width: dimen18,
                                        height: dimen18,
                                        color: color495057,
                                      ),
                                    ),
                                  )
                                : Container(),
                            //where element not type container
                          ).whereType<Padding>()
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  String fetchIconPath(String socialList) {
    switch (socialList) {
      case 'telegram':
        return AssetImagePath.telegram;
      case 'discord':
        return AssetImagePath.discord;
      case 'twitter':
        return AssetImagePath.twitter;
      case 'instagram':
        return AssetImagePath.instagram_black;
      case 'youtube':
        return AssetImagePath.youtube;
      case 'facebook':
        return AssetImagePath.facebook_2;
      default:
        return AssetImagePath.telegram;
    }
  }
}
