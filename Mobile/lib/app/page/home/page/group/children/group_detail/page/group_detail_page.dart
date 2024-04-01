import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/group/controller/group_controller.dart';
import 'package:plat_app/app/page/home/page/group/widgets/country_icon_with_name.dart';
import 'package:plat_app/app/page/home/page/group/widgets/social_icon_with_name.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/app/widgets/common_app_page.dart';
import 'package:plat_app/base/component/snackbar/getx_default_snack_bar.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io' show Platform;

class GroupDetailPage extends StatefulWidget {
  const GroupDetailPage({super.key});

  @override
  State<GroupDetailPage> createState() => GroupDetailPageState();
}

class GroupDetailPageState extends State<GroupDetailPage> {
  final GroupController groupController = Get.find();
  final group = Get.arguments['group'];
  late Worker _joinGroupWorker;
  void _launchSocial(String url, String fallbackUrl) async {
    // Don't use canLaunch because of fbProtocolUrl (fb://)
    final newUrl = url.startsWith('https://www.facebook.com/') ||
            url.startsWith('https://facebook.com/')
        ? 'fb://facewebmodal/f?href=$url'
        : url;

    try {
      bool launched =
          await launch(newUrl, forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(fallbackUrl, forceSafariVC: false, forceWebView: false);
    }
  }

  @override
  void initState() {
    super.initState();
    _joinGroupWorker =
        ever(groupController.submitJoinGroup, (NetworkResource data) {
      if (data.isSuccess()) {
        GetXDefaultSnackBar.successSnackBar(
          message: data.data.data['message'].toString() ?? 'success'.tr,
        );
      } else if (data.isError()) {
        GetXDefaultSnackBar.errorSnackBar(
          message: data.message ?? 'error'.tr,
          backgroundColor: colorFFB800,
        );
      }
    });
  }

  @override
  void dispose() {
    _joinGroupWorker.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return CommonAppPage(
      onTap: () {
        groupController.fetchAllGroup();
        groupController.fetchAllMyGroup();
        Get.back();
      },
      backgroundColor: colorWhite,
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: colorWhite,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        AppCachedImage(
                          imageUrl: group.cover_url,
                          width: double.infinity,
                          height: dimen240,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          left: dimen16,
                          bottom: -dimen96 / 2,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(dimen80),
                              border: Border.all(
                                  color: Colors.white, width: dimen1),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: AppCachedImage(
                              imageUrl: group.avatar_url,
                              width: dimen96,
                              height: dimen96,
                              cornerRadius: dimen80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  verticalSpace60,
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: dimen16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(group.name ?? '', style: text18_32302D_700),
                        Text(
                          group.username != null ? "@${group.username}" : "",
                          style: text14_625F5C_400,
                        ),
                        verticalSpace4,
                        CountryIconWithName(
                          textStyle: text14_625F5C_400,
                          text: group.country,
                        ),
                        verticalSpace16,
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: dimen16, vertical: dimen8),
                          decoration: BoxDecoration(
                            color: colorBackground,
                            borderRadius: BorderRadius.circular(dimen8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Builder(
                                builder: (context) {
                                  if (group.site_url != null &&
                                      group.site_url!.isNotEmpty) {
                                    final url = group.site_url as String?;
                                    final onWebsiteTap = TapGestureRecognizer();
                                    if (url?.isNotEmpty == true) {
                                      onWebsiteTap.onTap = () async {
                                        if (url != null) {
                                          _launchSocial(url, url);
                                        }
                                      };
                                    }
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: dimen12),
                                      child: RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: '${'website'.tr}: ',
                                            style: text14_32302D_700),
                                        TextSpan(
                                            text: group.site_url ?? '',
                                            style: text16_177FE2_400,
                                            recognizer: onWebsiteTap)
                                      ])),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                              Text(
                                '${'social'.tr}: ',
                                style: text14_32302D_700,
                              ),
                              verticalSpace6,
                              Wrap(
                                runSpacing: dimen4,
                                children: [
                                  group.twitter_url != null &&
                                          group.twitter_url.isNotEmpty
                                      ? SocialIconWithName(
                                          type: 'twitter',
                                          onTap: () {
                                            _launchSocial(
                                              group.twitter_url,
                                              group.twitter_url,
                                            );
                                          },
                                        )
                                      : const SizedBox(),
                                  group.facebook_url != null &&
                                          group.facebook_url.isNotEmpty
                                      ? SocialIconWithName(
                                          type: 'facebook',
                                          onTap: () {
                                            _launchSocial(
                                              group.facebook_url,
                                              group.facebook_url,
                                            );
                                          },
                                        )
                                      : const SizedBox(),
                                  group.youtube_url != null &&
                                          group.youtube_url.isNotEmpty
                                      ? SocialIconWithName(
                                          type: 'youtube',
                                          onTap: () {
                                            _launchSocial(
                                              group.youtube_url,
                                              group.youtube_url,
                                            );
                                          },
                                        )
                                      : const SizedBox(),
                                  group.discord_url != null &&
                                          group.discord_url.isNotEmpty
                                      ? SocialIconWithName(
                                          type: 'discord',
                                          onTap: () {
                                            _launchSocial(
                                              group.discord_url,
                                              group.discord_url,
                                            );
                                          },
                                        )
                                      : const SizedBox(),
                                  group.telegram_url != null &&
                                          group.telegram_url.isNotEmpty
                                      ? SocialIconWithName(
                                          type: 'telegram',
                                          onTap: () {
                                            _launchSocial(
                                              group.telegram_url,
                                              group.telegram_url,
                                            );
                                          },
                                        )
                                      : const SizedBox(),
                                  group.instagram_url != null &&
                                          group.instagram_url.isNotEmpty
                                      ? SocialIconWithName(
                                          type: 'instagram',
                                          onTap: () {
                                            _launchSocial(
                                              group.instagram_url,
                                              group.instagram_url,
                                            );
                                          },
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        verticalSpace16,
                        Text(
                          '${'description'.tr}: ',
                          style: text16_32302D_700,
                        ),
                        verticalSpace16,
                        Text(
                          group.desc_en ?? '',
                          style: text14_625F5C_400,
                        ),
                        verticalSpace80,
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        // Obx(
        //   () =>
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
              color: colorWhite,
              padding:
                  Platform.isIOS && MediaQuery.of(context).size.height >= 812
                      ? const EdgeInsets.only(
                          left: dimen24,
                          right: dimen24,
                          top: dimen8,
                        )
                      : const EdgeInsets.symmetric(
                          horizontal: dimen24,
                          vertical: dimen8,
                        ),
              child: buttonCheckJoin(
                checked: group.is_join,
                onCheckChanged: (value) {
                  group.is_join = value;
                },
              )),
        ),
      ],
    );
  }

  Widget buttonCheckJoin(
      {String? text, required bool checked, Function(bool)? onCheckChanged}) {
    return InkWell(
      onTap: () {
        setState(() {
          checked = !checked;
          onCheckChanged!(checked);
          groupController.fetchJoinGroup(group.id);
        });
      },
      child: Container(
        height: dimen48,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(dimen48 / 2)),
          color: checked ? colorEA4335 : colorPrimary,
        ),
        child: Center(
          child: Text(
            checked ? 'Leave' : 'Join Now',
            style: text14_white_600,
          ),
        ),
      ),
    );
  }
}
