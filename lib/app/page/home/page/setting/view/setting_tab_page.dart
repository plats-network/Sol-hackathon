import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/assets_page.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/controller/password_security_controller.dart';
import 'package:plat_app/app/page/home/page/setting/controller/setting_controller.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingTabPage extends StatefulWidget {
  const SettingTabPage({Key? key}) : super(key: key);

  @override
  State<SettingTabPage> createState() => _SettingTabPageState();
}

class _SettingTabPageState extends State<SettingTabPage> {
  final AuthController authController = Get.find();
  final SettingController settingController = Get.find();
  final AppNotificationController appNotificationController = Get.find();
  final PasswordSecurityController passwordSecurityController = Get.find();
  late Worker logoutWorker;
  late Worker updateAvatarWorker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      settingController.fetchUserProfile();
    });
    logoutWorker = ever(authController.authData, (NetworkResource callback) {
      if (authController.isNotLoggedIn()) {
        Get.offAllNamed(Routes.login);
      }
    });
    updateAvatarWorker = ever(
      settingController.updateAvatarData,
      (NetworkResource data) {
        if (data.isSuccess()) {
          // Cap nhat avatar thanh cong thi lay lai thong tin user
          settingController.fetchUserProfile();
        }
      },
    );
  }

  @override
  void dispose() {
    logoutWorker.dispose();
    updateAvatarWorker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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

    final editProfileWidget = Positioned(
        top: dimen0,
        right: dimen0,
        child: InkWell(
          onTap: () {
            Get.toNamed(Routes.editProfile);
            // Log event SETTING_TAP_EDIT_PROFILE
            logEvent(
                eventName: 'SETTING_TAP_EDIT_PROFILE', eventParameters: {});
          },
          child: Image.asset(
            getAssetImage(AssetImagePath.ic_edit_white),
            width: dimen24,
            height: dimen24,
            color: color00FA9A,
          ),
        ));

    final avatarWidget = GestureDetector(
      onTap: () async {
        Get.back();
        final ImagePicker picker = ImagePicker();
        // Pick an image
        final XFile? image = await picker.pickImage(
            source: ImageSource.gallery, maxWidth: 1080, maxHeight: 1920);
        if (image != null) {
          final resizedImage = await resizeImage(image);
          settingController.postUpdateAvatar(resizedImage);
        }

        // Log event SETTING_TAP_CHOOSE_FROM_LIBRARY
        logEvent(
            eventName: 'SETTING_TAP_CHOOSE_FROM_LIBRARY', eventParameters: {});
      },
      child: ClipRRect(
          borderRadius: border120,
          child: Obx(() => AppCachedImage(
                imageUrl: settingController
                        .userProfile.value.data?.data?.avatarPath ??
                    '',
                width: dimen70,
                height: dimen70,
                fit: BoxFit.cover,
              ))),
    );

    final updateAvatarButton = Positioned(
        bottom: dimen0,
        right: dimen0,
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: colorWhite,
                width: dimen2,
              ),
            ),
            child: Image.asset(
              getAssetImage(AssetImagePath.ic_upload_avatar),
              width: dimen20,
              height: dimen20,
            ),
          ),
          onTap: () {
            final takeAPhotoWidget = InkWell(
              onTap: () async {
                Get.back();
                final ImagePicker picker = ImagePicker();
                // Capture a photo
                final XFile? photo = await picker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 1080,
                    maxHeight: 1920);
                if (photo != null) {
                  final resizedPhoto = await resizeImage(photo);
                  settingController.postUpdateAvatar(resizedPhoto);
                }

                // Log event SETTING_TAP_TAKE_PHOTO
                logEvent(
                    eventName: 'SETTING_TAP_TAKE_PHOTO', eventParameters: {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: dimen12),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: colorF3F1F1, width: dimen1))),
                child: Row(
                  children: [
                    Image.asset(
                      getAssetImage(AssetImagePath.ic_camera),
                      width: dimen24,
                      height: dimen24,
                    ),
                    horizontalSpace8,
                    Text(
                      'take_a_photo'.tr,
                      style: text16_32302D_400,
                    ),
                  ],
                ),
              ),
            );

            final chooseFromLibraryWidget = InkWell(
              onTap: () async {
                Get.back();
                final ImagePicker picker = ImagePicker();
                // Pick an image
                final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 1080,
                    maxHeight: 1920);
                if (image != null) {
                  final resizedImage = await resizeImage(image);
                  settingController.postUpdateAvatar(resizedImage);
                }

                // Log event SETTING_TAP_CHOOSE_FROM_LIBRARY
                logEvent(
                    eventName: 'SETTING_TAP_CHOOSE_FROM_LIBRARY',
                    eventParameters: {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: dimen12),
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: colorF3F1F1, width: dimen1))),
                child: Row(
                  children: [
                    Image.asset(
                      getAssetImage(AssetImagePath.ic_image),
                      width: dimen24,
                      height: dimen24,
                    ),
                    horizontalSpace8,
                    Text(
                      'choose_from_library'.tr,
                      style: text16_32302D_400,
                    ),
                  ],
                ),
              ),
            );

            final closeButton = AppButton(
              title: 'close'.tr,
              isPrimaryStyle: false,
              onTap: () {
                Get.back();

                // Log event SETTING_UPDATE_AVATAR_TAP_CLOSE
                logEvent(
                    eventName: 'SETTING_UPDATE_AVATAR_TAP_CLOSE',
                    eventParameters: {});
              },
            );
            GetXDefaultBottomSheet.rawBottomSheet(SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(dimen16),
                child: Column(
                  children: [
                    Text(
                      'avatar'.tr,
                      style: text22_32302D_700,
                      textAlign: TextAlign.center,
                    ),
                    verticalSpace24,
                    takeAPhotoWidget,
                    verticalSpace24,
                    chooseFromLibraryWidget,
                    verticalSpace24,
                    closeButton,
                    verticalSpace16,
                  ],
                ),
              ),
            ));

            // Log event SETTING_TAP_UPDATE_AVATAR
            logEvent(
                eventName: 'SETTING_TAP_UPDATE_AVATAR', eventParameters: {});
          },
        ));

    final userInfoWidget = Container(
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      padding:
          const EdgeInsets.symmetric(horizontal: dimen16, vertical: dimen24),
      width: double.infinity,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      avatarWidget,
                      updateAvatarButton,
                    ],
                  ),
                  horizontalSpace14,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() {
                        return Text(
                          settingController
                                  .userProfile.value.data?.data?.name ??
                              '',
                          style: GoogleFonts.quicksand(
                            color: colorBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                      horizontalSpace10,
                      Obx(() {
                        return Text(
                          settingController
                                  .userProfile.value.data?.data?.email ??
                              '',
                          style: GoogleFonts.quicksand(
                            color: color32302D,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // editProfileWidget,
        ],
      ),
    );
    final passwordSecurityWidget = settingSection(
      text: 'password_and_security'.tr,
      icon: AssetImagePath.ic_lock,
      onTap: () {
        Get.toNamed(Routes.passwordSecurity);

        // Log event SETTING_PASSWORD_SECURITY_TAP
        logEvent(
            eventName: 'SETTING_PASSWORD_SECURITY_TAP', eventParameters: {});
      },
    );
    final helpCenterWidget = settingSection(
      text: 'help_center'.tr,
      icon: AssetImagePath.ic_headset,
      onTap: () {
        Get.toNamed(Routes.helpCenter);

        // Log event SETTING_HELP_CENTER_TAP
        logEvent(eventName: 'SETTING_HELP_CENTER_TAP', eventParameters: {});
      },
    );
    final aboutAppWidget = settingSection(
      text: 'about_app'.tr,
      icon: AssetImagePath.ic_info_circle,
      onTap: () {
        Get.toNamed(Routes.aboutApp);
        // Log event SETTING_ABOUT_APP_TAP
        logEvent(eventName: 'SETTING_ABOUT_APP_TAP', eventParameters: {});
      },
      showDivider: false,
    );
    final referFriendsWidget = settingSection(
      text: 'refer_friends'.tr,
      icon: AssetImagePath.ic_user_plus,
      onTap: () {
        // Log event SETTING_REFER_FRIEND_TAP
        logEvent(eventName: 'SETTING_REFER_FRIEND_TAP', eventParameters: {});
      },
    );
    final logoutWidget = settingSection(
      text: 'logout'.tr,
      icon: AssetImagePath.ic_logout,
      onTap: () {
        authController.logout();

        // Log event SETTING_LOGOUT_TAP
        logEvent(eventName: 'SETTING_LOGOUT_TAP', eventParameters: {});
      },
      showDivider: false,
    );
    final referToYourFriendWidget = Container(
      padding:
          const EdgeInsets.symmetric(horizontal: dimen14, vertical: dimen10),
      margin: const EdgeInsets.symmetric(horizontal: dimen16),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
            colorBlack.withOpacity(.5),
            BlendMode.darken,
          ),
          image: AssetImage(getAssetImage(AssetImagePath.banner_refer)),
          fit: BoxFit.cover,
        ),
        boxShadow: const [
          BoxShadow(
            color: colorE4E1E1,
            blurRadius: dimen3,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Refer your Friends',
                  style: GoogleFonts.quicksand(
                      fontSize: 15,
                      color: colorWhite,
                      fontWeight: FontWeight.w700),
                ),
                verticalSpace4,
                Text(
                  'as_a_thank_you'.tr,
                  style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: colorWhite,
                      fontWeight: FontWeight.w400),
                ),
                verticalSpace16,
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: dimen12,
                    vertical: dimen6,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: color177FE2,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.1, 0.5, 0.7],
                      colors: [
                        Color.fromARGB(255, 54, 130, 230),
                        Color.fromARGB(255, 69, 173, 225),
                        Color.fromARGB(255, 40, 191, 194),
                      ],
                    ),
                  ),
                  child: Text(
                    'Referral now',
                    style: GoogleFonts.quicksand(
                      fontSize: 11,
                      color: colorWhite,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          horizontalSpace16,
          Image.asset(
            getAssetImage(AssetImagePath.refer),
            width: dimen120,
            height: dimen120,
          ),
        ],
      ),
    );

    final contactApp = Container(
      padding:
          const EdgeInsets.symmetric(horizontal: dimen14, vertical: dimen10),
      margin: const EdgeInsets.symmetric(horizontal: dimen16),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: colorE4E1E1,
            blurRadius: dimen3,
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.aboutApp);
            },
            child: Container(
              color: colorWhite,
              padding: const EdgeInsets.symmetric(
                vertical: dimen8,
                horizontal: dimen4,
              ),
              child: Row(
                children: [
                  Image.asset(
                    getAssetImage(AssetImagePath.ic_info_circle),
                    fit: BoxFit.cover,
                    color: color32302D,
                    width: 20,
                    height: 20,
                  ),
                  horizontalSpace10,
                  Text(
                    'About Plats',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: colorBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: colorE4E1E1,
          ),
          GestureDetector(
            onTap: () {
              _launchSocial(
                  'https://docs.google.com/forms/d/1oMxuUskxKtJDzqDFR4_9MZ7dmH_K7LkBhD6UuFgzXd0/viewform?edit_requested=true',
                  'https://docs.google.com/forms/d/1oMxuUskxKtJDzqDFR4_9MZ7dmH_K7LkBhD6UuFgzXd0/viewform?edit_requested=true');
            },
            child: Container(
              color: colorWhite,
              padding: const EdgeInsets.symmetric(
                vertical: dimen10,
                horizontal: dimen4,
              ),
              child: Row(
                children: [
                  Image.asset(
                    getAssetImage(AssetImagePath.ic_headset),
                    fit: BoxFit.cover,
                    color: color32302D,
                    width: 20,
                    height: 20,
                  ),
                  horizontalSpace10,
                  Text(
                    'Client Registration',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: colorBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: colorE4E1E1,
          ),
          GestureDetector(
            onTap: () {
              _launchSocial('https://plats.network/policy.html',
                  'https://plats.network/policy.html');
            },
            child: Container(
              color: colorWhite,
              padding: const EdgeInsets.symmetric(
                vertical: dimen10,
                horizontal: dimen4,
              ),
              child: Row(
                children: [
                  Image.asset(
                    getAssetImage(AssetImagePath.ic_lock),
                    fit: BoxFit.cover,
                    color: color32302D,
                    width: 20,
                    height: 20,
                  ),
                  horizontalSpace10,
                  Text(
                    'Security policy',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: colorBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: colorE4E1E1,
          ),
          GestureDetector(
            onTap: () {
              authController.logout();
              // Log event SETTING_LOGOUT_TAP
              logEvent(eventName: 'SETTING_LOGOUT_TAP', eventParameters: {});
            },
            child: Container(
              color: colorWhite,
              padding: const EdgeInsets.symmetric(
                vertical: dimen10,
                horizontal: dimen4,
              ),
              child: Row(
                children: [
                  Image.asset(
                    getAssetImage(AssetImagePath.ic_logout),
                    fit: BoxFit.cover,
                    color: color32302D,
                    width: 20,
                    height: 20,
                  ),
                  horizontalSpace10,
                  Text(
                    'Logout',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: colorBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    final passwordSecurity = Container(
      padding:
          const EdgeInsets.symmetric(horizontal: dimen14, vertical: dimen10),
      margin: const EdgeInsets.symmetric(horizontal: dimen16),
      decoration: BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: colorE4E1E1,
            blurRadius: dimen3,
          ),
        ],
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.editProfile);
              // Log event SETTING_TAP_EDIT_PROFILE
              logEvent(
                  eventName: 'SETTING_TAP_EDIT_PROFILE', eventParameters: {});
            },
            child: Container(
              color: colorWhite,
              padding: const EdgeInsets.symmetric(
                vertical: dimen8,
                horizontal: dimen4,
              ),
              child: Row(
                children: [
                  Image.asset(
                    getAssetImage(AssetImagePath.user_icon),
                    fit: BoxFit.cover,
                    color: color32302D,
                    width: 20,
                    height: 20,
                  ),
                  horizontalSpace10,
                  Text(
                    'Account',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: colorBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            color: colorE4E1E1,
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.changePassword);
              // Log event SETTING_TAP_EDIT_PROFILE
              logEvent(
                  eventName: 'SETTING_TAP_EDIT_PROFILE', eventParameters: {});
            },
            child: Container(
              color: colorWhite,
              padding: const EdgeInsets.symmetric(
                vertical: dimen8,
                horizontal: dimen4,
              ),
              child: Row(
                children: [
                  Image.asset(
                    getAssetImage(AssetImagePath.change_password),
                    fit: BoxFit.cover,
                    color: color32302D,
                    width: 20,
                    height: 20,
                  ),
                  horizontalSpace10,
                  Text(
                    'Change password',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      color: colorBlack,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    final deleteAcc = GestureDetector(
      onTap: () {
        GetXDefaultBottomSheet.warningBottomSheet(
            title: 'delete_account'.tr,
            text: Text(
              'delete_account_help_text'.tr,
              textAlign: TextAlign.center,
              style: text14_32302D_400,
            ),
            buttons: [
              Expanded(
                child: AppButton(
                  title: 'yes'.tr,
                  onTap: () async {
                    passwordSecurityController.deleteAccount();
                    OverlayState? state = Overlay.of(context);
                    showTopSnackBar(
                      state!,
                      CustomSnackBar.info(
                        message: 'Account deleted successfully.',
                        textStyle: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: colorWhite,
                          fontWeight: FontWeight.w600,
                        ),
                        icon: Image.asset(
                          getAssetImage(
                            AssetImagePath.plats_logo,
                          ),
                        ),
                        backgroundColor: colorPrimary,
                        iconRotationAngle: -30,
                        iconPositionTop: 10,
                        iconPositionLeft: -10,
                      ),
                    );
                    authController.logout();
                  },
                  isPrimaryStyle: false,
                ),
              ),
              horizontalSpace8,
              Expanded(
                child: AppButton(
                  title: 'no'.tr,
                  onTap: () {
                    Get.back();
                  },
                ),
              ),
            ]);
      },
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: dimen14, vertical: dimen10),
        margin: const EdgeInsets.symmetric(horizontal: dimen16),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: colorE4E1E1,
              blurRadius: dimen3,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: dimen8,
                horizontal: dimen4,
              ),
              child: Row(
                children: [
                  Image.asset(
                    getAssetImage(AssetImagePath.trash),
                    fit: BoxFit.cover,
                    color: colorF20200,
                    width: dimen18,
                    height: dimen18,
                  ),
                  horizontalSpace10,
                  Text(
                    'Delete Account',
                    style: GoogleFonts.quicksand(
                      color: colorF20200,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(getAssetImage(AssetImagePath.background_ticket)),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: colorTransparent,
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: dimen16, top: dimen10),
                      child: Text(
                        'Profile',
                        style: GoogleFonts.quicksand(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: color0E4C88,
                        ),
                      ),
                    ),
                    verticalSpace20,
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: colorE4E1E1,
                            blurRadius: dimen3,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          userInfoWidget,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    OverlayState? state = Overlay.of(context);
                                    showTopSnackBar(
                                      state!,
                                      CustomSnackBar.info(
                                        message:
                                            "You don't have any favorite tasks yet.",
                                        textStyle: GoogleFonts.quicksand(
                                          fontSize: 14,
                                          color: colorWhite,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        icon: Image.asset(
                                          getAssetImage(
                                            AssetImagePath.plats_logo,
                                          ),
                                        ),
                                        backgroundColor: colorPrimary,
                                        iconRotationAngle: -30,
                                        iconPositionTop: 10,
                                        iconPositionLeft: -10,
                                      ),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: color00FA9A,
                                      gradient: const LinearGradient(
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight,
                                        colors: [
                                          Color(0xff6dd5ed),
                                          Color(0xff2193b0),
                                        ],
                                        stops: [0, 0.7],
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xff2193b0),
                                          blurRadius: dimen4,
                                        ),
                                      ],
                                      border: Border.all(
                                        width: 0.5,
                                        color: colorWhite,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.22,
                                    height: MediaQuery.of(context).size.width *
                                        0.22,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: -16,
                                          right: -17,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 10,
                                                color: const Color(0xff6dd5ed)
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                getAssetImage(
                                                    AssetImagePath.heart),
                                                width: dimen24,
                                                height: dimen24,
                                                color: colorWhite,
                                              ),
                                              verticalSpace6,
                                              Text(
                                                'Favorite',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 13,
                                                  color: colorWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(Routes.notification);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight,
                                        colors: [
                                          Color(0xff74ebd5),
                                          Color(0xffACB6E5),
                                        ],
                                        stops: [0, 0.7],
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xffACB6E5),
                                          blurRadius: dimen4,
                                        ),
                                      ],
                                      border: Border.all(
                                        width: 0.5,
                                        color: colorWhite,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.22,
                                    height: MediaQuery.of(context).size.width *
                                        0.22,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: -16,
                                          right: -17,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 10,
                                                color: const Color(0xffACB6E5)
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                getAssetImage(AssetImagePath
                                                    .notification_bell),
                                                width: dimen26,
                                                height: dimen26,
                                                color: colorWhite,
                                              ),
                                              verticalSpace6,
                                              Text(
                                                'Notification',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 13,
                                                  color: colorWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const AssetsPage()),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                        begin: FractionalOffset.topLeft,
                                        end: FractionalOffset.bottomRight,
                                        colors: [
                                          Color(0xffF9D423),
                                          Color(0xffFF4E50),
                                        ],
                                        stops: [0, 0.7],
                                      ),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color(0xffFF4E50),
                                          blurRadius: dimen4,
                                        ),
                                      ],
                                      border: Border.all(
                                        width: 0.5,
                                        color: colorWhite,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    width: MediaQuery.of(context).size.width *
                                        0.22,
                                    height: MediaQuery.of(context).size.width *
                                        0.22,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          top: -16,
                                          right: -17,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                width: 10,
                                                color: const Color(0xffF9D423)
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                            width: 50,
                                            height: 50,
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                getAssetImage(AssetImagePath
                                                    .icon_asset_inactive),
                                                width: dimen26,
                                                height: dimen26,
                                                color: colorWhite,
                                              ),
                                              verticalSpace6,
                                              Text(
                                                'Assets',
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 13,
                                                  color: colorWhite,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          verticalSpace16,
                        ],
                      ),
                    ),

                    verticalSpace16,
                    passwordSecurity,
                    verticalSpace16,
                    referToYourFriendWidget,
                    verticalSpace16,
                    contactApp,
                    verticalSpace16,
                    deleteAcc,
                    verticalSpace70,
                    // deleteAcc,
                    // verticalSpace10,
                    // Container(
                    //   decoration: const BoxDecoration(
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: colorFAF9F9,
                    //         blurRadius: dimen8,
                    //       ),
                    //     ],
                    //     border: Border(
                    //         bottom:
                    //             BorderSide(width: dimen1, color: colorF3F1F1)),
                    //   ),
                    //   margin: const EdgeInsets.only(bottom: dimen8),
                    //   child: Column(
                    //     children: [
                    //       passwordSecurityWidget,
                    //       // TODO: Comming soon
                    //       helpCenterWidget,
                    //       // aboutAppWidget,
                    //     ],
                    //   ),
                    // ),
                    // Container(
                    //   decoration: const BoxDecoration(
                    //     color: Colors.white,
                    //     boxShadow: [
                    //       BoxShadow(
                    //         color: colorFAF9F9,
                    //         blurRadius: dimen8,
                    //       ),
                    //     ],
                    //     border: Border(
                    //         bottom:
                    //             BorderSide(width: dimen1, color: colorF3F1F1)),
                    //   ),
                    //   margin: const EdgeInsets.only(bottom: dimen8),
                    //   child: Column(
                    //     children: [
                    //       // TODO: Comming soon
                    //       // referFriendsWidget,
                    //       logoutWidget,
                    //     ],
                    //   ),
                    // ),
                    // TODO: Comming soon
                    // referToYourFriendWidget,
                  ],
                ),
              ),
              Obx(() => (settingController.isGettingUserProfile() ||
                      settingController.isUpdatingAvatar() ||
                      authController.isLoggingIn() ||
                      appNotificationController.isDeletingDeviceToken())
                  ? const SafeArea(child: FullScreenProgress())
                  : Container())
            ],
          ),
        ),
      ),
    );
  }

  Widget settingSection(
      {required String text,
      required String icon,
      required VoidCallback onTap,
      bool showDivider = true}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: dimen12),
        margin: const EdgeInsets.fromLTRB(dimen16, dimen16, dimen16, dimen0),
        decoration: BoxDecoration(
            color: colorWhite,
            border: showDivider
                ? const Border(
                    bottom: BorderSide(width: dimen1, color: colorF3F1F1))
                : null),
        child: Row(
          children: [
            Image.asset(
              getAssetImage(icon),
              width: dimen24,
              height: dimen24,
            ),
            horizontalSpace8,
            Expanded(
              child: Text(
                text,
                style: text16_32302D_400,
              ),
            ),
            Image.asset(
              getAssetImage(AssetImagePath.ic_caret_right),
              width: dimen24,
              height: dimen24,
            ),
          ],
        ),
      ),
    );
  }
}
