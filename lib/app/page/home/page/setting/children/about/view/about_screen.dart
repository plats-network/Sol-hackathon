import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
  Widget build(BuildContext context) {
    return CommonAppBarPage(
      title: 'About Plats'.tr,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(color: colorWhite),
          child: Column(
            children: [
              verticalSpace20,
              // itemInfo(title: 'Tổng đài', value: '', iconName: AssetImagePath.ic_headset),
              // const Divider(height: dimen0, color: color878998),
              itemInfo(
                  title: 'Email',
                  value: 'info@plats.network',
                  iconName: AssetImagePath.email,
                  onTap: () {}),
              const Divider(height: dimen0, color: color878998),
              itemInfo(
                  title: 'Website',
                  value: 'https://plats.network/',
                  iconName: AssetImagePath.website,
                  onTap: () {
                    _launchSocial(
                        'https://plats.network/', 'https://plats.network/');
                  }),
              const Divider(height: dimen0, color: color878998),
              itemInfo(
                  title: 'Twitter',
                  value: '@plats_network',
                  iconName: AssetImagePath.twitter_outline,
                  onTap: () {
                    _launchSocial('https://twitter.com/plats_network',
                        'https://twitter.com/plats_network');
                  }),
              const Divider(height: dimen0, color: color878998),
              itemInfo(
                  title: 'Telegram',
                  value: 't.me/platsnetworkofficial',
                  iconName: AssetImagePath.telegram_outline,
                  onTap: () {
                    _launchSocial('https://t.me/platsnetworkofficial',
                        'https://t.me/platsnetworkofficial');
                  }),
              const Divider(height: dimen0, color: color878998),
              itemInfo(
                  title: 'Facebook',
                  value: 'facebook.com/platsnetwork',
                  iconName: AssetImagePath.facebook_outline,
                  onTap: () {
                    _launchSocial('https://www.facebook.com/platsnetwork',
                        'https://www.facebook.com/platsnetwork');
                  }),
              const Divider(height: dimen0, color: color878998),
              itemInfo(
                  title: 'Linkedin',
                  value: 'linkedin.com/in/plats-network',
                  iconName: AssetImagePath.linkedin,
                  onTap: () {
                    _launchSocial('https://www.linkedin.com/in/plats-network',
                        'https://www.linkedin.com/in/plats-network');
                  }),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemInfo(
      {String? title, String? value, String? iconName, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: colorWhite,
        padding: const EdgeInsets.only(
          left: dimen16,
          bottom: dimen10,
          top: dimen10,
          right: dimen10,
        ),
        child: Row(
          children: [
            Image.asset(
              getAssetImage(iconName ?? ''),
              width: dimen20,
              height: dimen20,
              color: color0E4C88,
            ),
            horizontalSpace10,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    style: GoogleFonts.quicksand(
                      color: color0E4C88,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    value ?? '',
                    style: GoogleFonts.quicksand(
                      color: color565C6E,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              getAssetImage(AssetImagePath.arrow_right),
              width: dimen14,
              height: dimen14,
            ),
          ],
        ),
      ),
    );
  }
}
