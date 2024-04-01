import 'dart:math';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/controller/social_task_detail_controller.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/model/social_task_detail_response.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/page/list_social_task_widget.dart';
import 'package:plat_app/app/page/home/children/task_detail/widgets/location_item_shimmer.dart';
import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
import 'package:plat_app/app/widgets/animations/animations.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'dart:io' show Platform;
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:share_plus/share_plus.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:map_launcher/map_launcher.dart' as map;
part 'social_task_perform_action.dart';

enum SocialMedia {
  facebook,
  twitter,
  email,
  linkedin,
  whatsApp,
  telegram,
  discord
}

class SocialTaskDetailPage extends StatefulWidget {
  const SocialTaskDetailPage({super.key});

  @override
  State<SocialTaskDetailPage> createState() => _SocialTaskDetailPageState();
}

class _SocialTaskDetailPageState extends State<SocialTaskDetailPage>
    with TickerProviderStateMixin {
  double scrollPosition = 0.0;
  // GoogleMapController? controller;
  @override
  ScrollController scrollController = ScrollController();
  _scrollListener() {
    scrollPosition = scrollController.position.pixels;
    setState(() {});
  }

  final SocialTaskDetailController socialTaskDetailController = Get.find();
  final IndexController indexController = Get.find();
  final taskId = Get.arguments['task_id'];
  final isDone = Get.arguments['is_done'];
  final isBacktoHome = Get.arguments['is_back'] ?? false;
  final lat = Get.arguments['lat'];
  final lng = Get.arguments['lng'];
  late Worker _startTaskWorker;
  late Worker _submitSocialTaskWorker;
  late Worker _connectTwitterWorker;
  late Worker _sendTicketWorker;
  bool isEnable = false;
  bool isFollow = false;
  final HomeTabController _homeTabController = Get.find();
  RxBool isAssetsActive = false.obs;
  bool isLike = false;
  bool isPin = false;
  final Set<Marker> _markers = {};
  String localPath = '';
  TextEditingController qAController = TextEditingController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
    qAController.addListener(() {
      setState(() {});
    });
    _homeTabController.fetchRemoteConfigForAssets().then((value) {
      isAssetsActive = value.obs;
    });

    fetchTaskDetail();
    fetchSocialAccount();
    isLike = socialTaskDetailController.taskDetail?.like?.isLike ?? false;
    isPin = socialTaskDetailController.taskDetail?.pin?.isPin ?? false;
    _sendTicketWorker =
        ever(socialTaskDetailController.getTicket, (NetworkResource data) {
      if (data.isSuccess()) {
        // showCustomDialog(context, data.data.data['message'].toString());
      } else if (data.isError()) {
        OverlayState? state = Overlay.of(context);
        showTopSnackBar(
          state!,
          CustomSnackBar.info(
            message: "Ticket registration has expired.",
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
        // showCustomDialog(context, data.data.data['message'].toString());
      }
    });
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //     // Log event TASK_VIEW
    //     logEvent(eventName: 'TASK_VIEW', eventParameters: {
    //       'task_id': taskId,
    //     });
    //   });
  }

  void enableClick() {
    setState(() {
      isEnable = !isEnable;
    });
  }

  void followButtonClick() {
    setState(() {
      isFollow = !isFollow;
    });
  }

  void _onShare({
    BuildContext? context,
    String? url,
    String? sub,
  }) async {
    final box = context!.findRenderObject() as RenderBox?;

    await Share.share(url ?? '',
        subject: sub ?? '',
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  Future shareSocial({
    SocialMedia? socialPlatfrom,
    String? urlEvent,
    String? title,
    String? sub,
  }) async {
    final text = Uri.encodeFull(title as String);
    final subject = sub;
    final urlShare = Uri.encodeFull(urlEvent as String);
    final urls = {
      SocialMedia.facebook:
          'https://www.facebook.com/sharer/sharer.php?u=$urlShare&text=$text',
      SocialMedia.twitter:
          'https://twitter.com/intent/tweet?url=$urlShare&text=$text',
      SocialMedia.linkedin:
          'https://www.linkedin.com/shareArticle?mini=true&url=$urlShare&title=$text',
      SocialMedia.email: 'mailto:?subject=$text&body=$subject\n\n$urlShare',
      SocialMedia.whatsApp:
          'https://api.whatsapp.com/send?text=$text:$urlShare',
      SocialMedia.telegram: 'https://t.me/share/url?text=$text&url=$urlShare',
      SocialMedia.discord:
          'https://discord.com/api/webhooks/YOUR_WEBHOOK_ID/YOUR_WEBHOOK_TOKEN?content=$urlShare&username=$text',
    };
    final url = urls[socialPlatfrom];
    // if (await canLaunchUrl(url as dynamic)) {
    // await launch(url as dynamic);
    try {
      bool launched = await launch(url as String,
          forceSafariVC: false, forceWebView: false);
      if (!launched) {
        await launch(url, forceSafariVC: false, forceWebView: false);
      }
    } catch (e) {
      await launch(url as String, forceSafariVC: false, forceWebView: false);
    }
    // }
  }

  void openMaps({double? lat, double? long}) async {
    if (Platform.isIOS) {
      if (await canLaunch(
          'https://maps.apple.com/?saddr=&daddr=$lat,$long&directionsmode=walking')) {
        await launch(
            'https://maps.apple.com/?saddr=&daddr=$lat,$long&directionsmode=walking');
      } else {
        if (await canLaunch(
            'https://www.google.com/maps/search/?api=1&query=$lat,$long')) {
          await launch(
              'https://www.google.com/maps/search/?api=1&query=$lat,$long');
        } else {
          throw 'Could not open the map.';
        }
      }
    } else {
      if (await canLaunch(
          'https://www.google.com/maps/search/?api=1&query=$lat,$long')) {
        await launch(
            'https://www.google.com/maps/search/?api=1&query=$lat,$long');
      } else {
        throw 'Could not open the map.';
      }
    }
  }

  void showMoreSessionOrBooth(
      {String? name,
      String? decription,
      String? success,
      List<EventJobs>? jobs}) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => Scaffold(
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(
                left: dimen20,
                right: dimen20,
                top: dimen40,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        name ?? '',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          color: colorBlack,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      horizontalSpace10,
                      Text(
                        success ?? '',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          color: color1DA5F2,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace2,
                  Text(
                    decription ?? '',
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      color: color8A8E9C,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  verticalSpace10,
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: jobs?.length ?? 0,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: dimen10,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: dimen16,
                                height: dimen16,
                                decoration: BoxDecoration(
                                  color: jobs?[index].statusDone == true
                                      ? color27AE60
                                      : colorB7BBCB,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: dimen0,
                                    color: colorB7BBCB,
                                  ),
                                ),
                              ),
                              horizontalSpace12,
                              Expanded(
                                child: Text(
                                  jobs?[index].name ?? '',
                                  style: GoogleFonts.quicksand(
                                    color: jobs?[index].statusDone == true
                                        ? colorBlack
                                        : colorB7BBCB,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: dimen10,
              right: dimen10,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Image(
                  image: AssetImage(
                    getAssetImage(AssetImagePath.close_ring),
                  ),
                  width: dimen26,
                  height: dimen26,
                  color: color9C9C9C,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _startTaskWorker.dispose();
    _submitSocialTaskWorker.dispose();
    _connectTwitterWorker.dispose();
    _sendTicketWorker.dispose();
    // scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('log $scrollPosition');
    // final Widget schedule = Column(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text('schedule'.tr, style: text18_32302D_700),
    //     verticalSpace8,
    //     Obx(
    //       () => Column(
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           socialTaskDetailController.taskDetail?.taskCheckIn != null
    //               ? ListView.separated(
    //                   padding: const EdgeInsets.only(bottom: dimen8),
    //                   itemBuilder: (context, index) => SocialTaskItem(
    //                     taskId: taskId,
    //                     taskCheckIn: socialTaskDetailController
    //                         .taskDetail?.taskCheckIn?[index],
    //                     isDone: false,
    //                     showPrizeOnDoneTask: false,
    //                   ),
    //                   shrinkWrap: true,
    //                   physics: const NeverScrollableScrollPhysics(),
    //                   separatorBuilder: (context, index) => verticalSpace8,
    //                   itemCount: socialTaskDetailController
    //                           .taskDetail?.taskCheckIn?.length ??
    //                       0,
    //                 )
    //               : const SizedBox(),
    //           socialTaskDetailController.taskDetail?.taskSocial != null
    //               ? ListView.separated(
    //                   padding: EdgeInsets.zero,
    //                   itemBuilder: (context, index) {
    //                     return GetBuilder(
    //                       init: socialTaskDetailController,
    //                       builder: (controller) {
    //                         final taskSocial = socialTaskDetailController
    //                             .taskDetail?.taskSocial?[index];
    //                         const isDone = false;

    //                         return Expanded(
    //                           child: SocialTaskItem(
    //                             taskSocials: taskSocial,
    //                             isDone: isDone,
    //                             showPrizeOnDoneTask: true,
    //                           ),
    //                         );
    //                       },
    //                     );
    //                   },
    //                   shrinkWrap: true,
    //                   physics: const NeverScrollableScrollPhysics(),
    //                   separatorBuilder: (context, index) => verticalSpace8,
    //                   itemCount: socialTaskDetailController
    //                           .taskDetail?.taskSocial?.length ??
    //                       0,
    //                 )
    //               : const SizedBox(),
    //         ],
    //       ),
    //     )
    //   ],
    // );

    final Widget taskDetailBody = RefreshIndicator(
      onRefresh: () async {
        if (kDebugMode) {
          print("onRefresh");
        }

        fetchTaskDetail();
      },
      child: Obx(
        () => CustomScrollView(
          controller: scrollController,
          slivers: [
            // Obx(() => socialTaskDetailController.taskDetail?.taskStart == true
            //     ? SliverAppBar(
            //         automaticallyImplyLeading: false,
            //         backgroundColor: colorWhite,
            //         title: Row(
            //           children: [
            //             //back button
            //             AppBackButton(
            //               onTab: () {
            //                 socialTaskDetailController
            //                     .setSelectedLocationIndex(-1);

            //                 Get.back();
            //                 indexController.fetchParticipatingEvent();
            //                 indexController.fetchTask();
            //                 indexController.fetchTaskEvent();
            //                 _homeTabController.fetchTaskPoolTask();
            //                 isDone
            //                     ? [
            //                         socialTaskDetailController
            //                             .setSelectedLocationIndex(-1),
            //                         Get.back()
            //                       ]
            //                     : isEnable
            //                         ? Get.back()
            //                         : [
            //                             enableClick(),
            //                             // _homeTabController.fetchSocialTask()
            //                           ];
            //               },
            //             ),
            //             horizontalSpace8,
            //             Expanded(
            //               child: Center(
            //                 child: Text(
            //                   socialTaskDetailController.taskDetail?.name ?? '',
            //                   maxLines: 1,
            //                   overflow: TextOverflow.ellipsis,
            //                   softWrap: false,
            //                   style: GoogleFonts.quicksand(
            //                     fontSize: 18,
            //                     color: colorBlack,
            //                     fontWeight: FontWeight.w700,
            //                   ),
            //                 ),
            //               ),
            //             ),
            //             horizontalSpace48
            //           ],
            //         ),
            //         centerTitle: false,
            //         floating: true,
            //         pinned: false,
            //         snap: false,
            //       )
            //     : const SliverToBoxAdapter()),

            SliverAppBar(
              backgroundColor: colorWhite,
              expandedHeight: 300,
              automaticallyImplyLeading: false,
              leadingWidth: 0,
              centerTitle: false,
              stretch: true,
              stretchTriggerOffset: 300,
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.fadeTitle,
                  StretchMode.blurBackground,
                  StretchMode.zoomBackground,
                ],
                background: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 350,
                      decoration: BoxDecoration(
                        color: colorBlack,
                        image: DecorationImage(
                          image: CachedNetworkImageProvider(
                            socialTaskDetailController.taskDetail?.bannerUrl ??
                                '',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -52,
                      child: CustomPaint(
                        painter: LogoPainter1(),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 51,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SlideAnimation(
                intervalStart: 0.4,
                begin: const Offset(0, 30),
                child: FadeAnimation(
                  child: Container(
                    // margin: const EdgeInsets.symmetric(
                    //     horizontal: dimen16, vertical: dimen8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // if (isEnable == true) ...[
                        // if (socialTaskDetailController.taskDetail?.taskStart ==
                        //     false) ...[
                        // verticalSpace120,
                        // GestureDetector(
                        //   onTap: () {
                        //     print('Imaged clicked');
                        //     PhotoView(
                        //       initialScale: PhotoViewComputedScale.covered,
                        //       imageProvider: CachedNetworkImageProvider(
                        //         socialTaskDetailController.taskDetail?.bannerUrl ??
                        //             '',
                        //       ),
                        //     );
                        //   },
                        //   child: Container(
                        //     height: socialTaskDetailController.taskDetail?.type ==
                        //             'event'
                        //         ? MediaQuery.of(context).size.height * 0.25
                        //         : MediaQuery.of(context).size.height * 0.4,
                        //     padding: const EdgeInsets.symmetric(
                        //       horizontal: dimen20,
                        //     ),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(dimen8),
                        //     ),
                        //     child: Stack(
                        //       children: [
                        //         GestureDetector(
                        //           onTap: () {
                        //             print('....');
                        //           },
                        //           child: Container(
                        //             width: MediaQuery.of(context).size.width,
                        //             height: double.infinity,
                        //             // margin: const EdgeInsets.symmetric(
                        //             //     horizontal: dimen1),
                        //             decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(dimen8),
                        //               boxShadow: const [
                        //                 BoxShadow(
                        //                   color: colorE4E1E1,
                        //                   blurRadius: dimen3,
                        //                 ),
                        //               ],
                        //               image: DecorationImage(
                        //                 image: CachedNetworkImageProvider(
                        //                     socialTaskDetailController
                        //                             .taskDetail?.bannerUrl ??
                        //                         ''),
                        //                 fit: BoxFit.cover,
                        //               ),
                        //             ),
                        //             child: Container(),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        Container(
                          // margin: const EdgeInsets.symmetric(horizontal: dimen24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace16,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: dimen16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        socialTaskDetailController
                                                .taskDetail?.name ??
                                            '',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 24,
                                            color: colorBlack,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    horizontalSpace12,
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isLike = !isLike;
                                          socialTaskDetailController.taskDetail
                                              ?.like?.isLike = isLike;
                                          if (isLike == true) {
                                            socialTaskDetailController
                                                .fetchLikeOrPin(taskId, 'like');
                                          } else {
                                            socialTaskDetailController
                                                .fetchLikeOrPin(
                                                    taskId, 'unlike');
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: 55,
                                        height: 65,
                                        decoration: BoxDecoration(
                                          color: socialTaskDetailController
                                                      .taskDetail
                                                      ?.like
                                                      ?.isLike ??
                                                  false
                                              ? const Color.fromARGB(
                                                  255, 255, 212, 227)
                                              : colorWhite,
                                          borderRadius:
                                              BorderRadius.circular(dimen12),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: colorDCDCDC,
                                              blurRadius: dimen4,
                                              offset: Offset(0, dimen2),
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              child: LikeButton(
                                                isLiked:
                                                    socialTaskDetailController
                                                            .taskDetail
                                                            ?.like
                                                            ?.isLike ??
                                                        false,
                                                likeCountPadding:
                                                    EdgeInsets.zero,
                                                onTap: (bool value) async {
                                                  setState(() {
                                                    isLike = !isLike;
                                                    socialTaskDetailController
                                                        .taskDetail
                                                        ?.like
                                                        ?.isLike = isLike;
                                                    if (isLike == true) {
                                                      socialTaskDetailController
                                                          .fetchLikeOrPin(
                                                              taskId, 'like');
                                                    } else {
                                                      socialTaskDetailController
                                                          .fetchLikeOrPin(
                                                              taskId, 'unlike');
                                                    }
                                                  });
                                                  return Future.value(!value);
                                                },
                                                size: 25,
                                                circleColor: const CircleColor(
                                                    start: Colors.pink,
                                                    end: Colors.pinkAccent),
                                                bubblesColor:
                                                    const BubblesColor(
                                                  dotPrimaryColor: Colors.red,
                                                  dotSecondaryColor:
                                                      Colors.redAccent,
                                                ),
                                                likeBuilder: (bool isLiked) {
                                                  return Icon(
                                                    Icons.favorite,
                                                    color:
                                                        socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.like
                                                                    ?.isLike ??
                                                                false
                                                            ? Colors.pink
                                                            : Colors.grey[300],
                                                    size: 25,
                                                  );
                                                },
                                              ),
                                            ),
                                            Text(
                                              'Like',
                                              style: GoogleFonts.quicksand(
                                                color:
                                                    socialTaskDetailController
                                                                .taskDetail
                                                                ?.like
                                                                ?.isLike ??
                                                            false
                                                        ? Colors.pink
                                                        : color4E4E4E,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace30,
                              GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const OrganizerScreen()),
                                  // );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: dimen12, vertical: dimen16),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: dimen16),
                                  decoration: BoxDecoration(
                                    color: colorA2CCF3.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(dimen4),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: dimen45,
                                        height: dimen45,
                                        decoration: const BoxDecoration(
                                          color: colorWhite,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: Text(
                                            (socialTaskDetailController
                                                    .taskDetail
                                                    ?.postBy as String)
                                                .substring(0, 1),
                                            style: GoogleFonts.quicksand(
                                              fontSize: 20,
                                              color: colorPrimary,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ),
                                      horizontalSpace10,
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            RichText(
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: 'By ',
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 14,
                                                      color: colorBlack,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  TextSpan(
                                                    text:
                                                        (socialTaskDetailController
                                                                .taskDetail
                                                                ?.postBy ??
                                                            ''),
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      fontSize: 15,
                                                      color: colorBlack,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            verticalSpace4,
                                            Text(
                                              '0 followers',
                                              style: GoogleFonts.quicksand(
                                                fontSize: 13,
                                                color: color565C6E,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      horizontalSpace10,
                                      GestureDetector(
                                        onTap: () {
                                          // followButtonClick();
                                        },
                                        child: Container(
                                          height: dimen30,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: dimen0,
                                            horizontal: dimen16,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: border4,
                                            color: colorE5E5E5,
                                            border: Border.all(
                                              width: 1.5,
                                              color: colorE5E5E5,
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              !isFollow
                                                  ? 'Follow'
                                                  : 'Following',
                                              style: GoogleFonts.quicksand(
                                                color: color878998,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      // GestureDetector(
                                      //   onTap: () {
                                      //     followButtonClick();
                                      //   },
                                      //   child: Container(
                                      //     height: dimen30,
                                      //     padding: const EdgeInsets.symmetric(
                                      //       vertical: dimen0,
                                      //       horizontal: dimen16,
                                      //     ),
                                      //     decoration: BoxDecoration(
                                      //       borderRadius: border4,
                                      //       color: isFollow
                                      //           ? colorWhite
                                      //           : colorPrimary,
                                      //       border: Border.all(
                                      //         width: 1.5,
                                      //         color: colorPrimary,
                                      //       ),
                                      //     ),
                                      //     child: Center(
                                      //       child: Text(
                                      //         !isFollow
                                      //             ? 'Follow'
                                      //             : 'Following',
                                      //         style: GoogleFonts.quicksand(
                                      //           color: !isFollow
                                      //               ? colorWhite
                                      //               : colorPrimary,
                                      //           fontSize: 12,
                                      //           fontWeight: FontWeight.w600,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // )
                                    ],
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: dimen16),
                              //   child: Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceBetween,
                              //     children: [
                              //       Expanded(
                              //         child: Text(
                              //           'by '.tr +
                              //               (socialTaskDetailController
                              //                       .taskDetail?.postBy ??
                              //                   ''),
                              //           style: GoogleFonts.quicksand(
                              //               fontSize: 14,
                              //               color: color9C9896,
                              //               fontWeight: FontWeight.w400),
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              socialTaskDetailController.taskDetail?.type ==
                                      'event'
                                  ? Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: dimen16,
                                        vertical: dimen10,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          verticalSpace10,
                                          Row(
                                            children: [
                                              Image.asset(
                                                getAssetImage(AssetImagePath
                                                    .calendar_silhouette),
                                                width: dimen16,
                                                height: dimen16,
                                                color: colorPrimary,
                                              ),
                                              horizontalSpace10,
                                              Text(
                                                DateFormat('EE, dd MMMM yyyy')
                                                    .format(
                                                      DateFormat(
                                                              'dd-MM-yyyy HH:mm:ss')
                                                          .parse(
                                                        '${socialTaskDetailController.taskDetail?.startAt}',
                                                      ),
                                                    )
                                                    .toString(),
                                                style: GoogleFonts.quicksand(
                                                  color: colorBlack,
                                                  fontSize: dimen13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          verticalSpace14,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                getAssetImage(AssetImagePath
                                                    .location_pin),
                                                width: dimen16,
                                                height: dimen16,
                                                color: colorPrimary,
                                              ),
                                              horizontalSpace10,
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    MapsSheet.show(
                                                      context: context,
                                                      onMapTap: (maps) {
                                                        maps.showMarker(
                                                          coords: map.Coords(
                                                            socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.lat
                                                                    ?.toDouble() ??
                                                                lat,
                                                            socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.lng
                                                                    ?.toDouble() ??
                                                                lng,
                                                          ),
                                                          title:
                                                              '${socialTaskDetailController.taskDetail?.address}',
                                                          zoom: 20,
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Text(
                                                    '${socialTaskDetailController.taskDetail?.address}',
                                                    style:
                                                        GoogleFonts.quicksand(
                                                      color: colorBlack,
                                                      fontSize: dimen13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      // decoration: TextDecoration
                                                      //     .underline,
                                                      decorationThickness: 1.5,
                                                    ),
                                                    maxLines: 3,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              verticalSpace10,
                              const Divider(
                                indent: dimen12,
                                endIndent: dimen12,
                                thickness: 0.5,
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: dimen16, vertical: dimen10),
                              //   child: Row(
                              //     children: [
                              //       Text(
                              //         'Sponsor',
                              //         style: GoogleFonts.quicksand(
                              //           fontSize: 18,
                              //           color: colorBlack,
                              //           fontWeight: FontWeight.w700,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              // Container(
                              //   margin: const EdgeInsets.symmetric(
                              //       horizontal: dimen16),
                              //   padding: const EdgeInsets.symmetric(
                              //       horizontal: dimen10, vertical: dimen10),
                              //   width: MediaQuery.of(context).size.width,
                              //   decoration: BoxDecoration(
                              //     border: Border.all(
                              //       width: dimen1,
                              //       color: colorDCDCDC,
                              //     ),
                              //     borderRadius: BorderRadius.circular(dimen4),
                              //   ),
                              //   child: Column(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     children: [
                              //       Row(
                              //         children: [
                              //           Image.asset(
                              //             getAssetImage(AssetImagePath.star),
                              //             width: dimen14,
                              //             height: dimen14,
                              //           ),
                              //           horizontalSpace4,
                              //           RichText(
                              //             text: TextSpan(
                              //               children: [
                              //                 TextSpan(
                              //                   text: 'You sponsored ',
                              //                   style: GoogleFonts.quicksand(
                              //                     fontSize: 14,
                              //                     color: colorBlack,
                              //                   ),
                              //                 ),
                              //                 TextSpan(
                              //                   text: '10ADA',
                              //                   style: GoogleFonts.quicksand(
                              //                     fontSize: 14,
                              //                     color: colorB04386,
                              //                     fontWeight: FontWeight.w700,
                              //                   ),
                              //                 ),
                              //                 TextSpan(
                              //                   text: ' for this event.',
                              //                   style: GoogleFonts.quicksand(
                              //                     fontSize: 14,
                              //                     color: colorBlack,
                              //                   ),
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       const Divider(
                              //         thickness: 0.5,
                              //       ),
                              //       verticalSpace10,
                              //       Row(
                              //         children: [
                              //           Container(
                              //             width: dimen40,
                              //             height: dimen40,
                              //             decoration: BoxDecoration(
                              //               color: colorTransparent,
                              //               borderRadius:
                              //                   BorderRadius.circular(dimen4),
                              //             ),
                              //             child: Image.asset(
                              //               getAssetImage(
                              //                   AssetImagePath.sponsor_avatar),
                              //               width: dimen30,
                              //               height: dimen30,
                              //             ),
                              //           ),
                              //           horizontalSpace10,
                              //           Expanded(
                              //             child: Column(
                              //               crossAxisAlignment:
                              //                   CrossAxisAlignment.start,
                              //               children: [
                              //                 Text(
                              //                   socialTaskDetailController
                              //                           .taskDetail?.name ??
                              //                       '',
                              //                   style: GoogleFonts.quicksand(
                              //                     fontSize: 14,
                              //                     color: colorBlack,
                              //                     fontWeight: FontWeight.w600,
                              //                   ),
                              //                   overflow: TextOverflow.ellipsis,
                              //                   maxLines: 2,
                              //                 ),
                              //               ],
                              //             ),
                              //           ),

                              //           // const Spacer(),
                              //           horizontalSpace10,
                              //           GestureDetector(
                              //             onTap: () {
                              //               showCupertinoModalBottomSheet(
                              //                 context: context,
                              //                 builder: (context) =>
                              //                     const SponsorDetailScreen(),
                              //               );
                              //             },
                              //             child: Container(
                              //               height: dimen30,
                              //               padding: const EdgeInsets.symmetric(
                              //                   vertical: dimen0,
                              //                   horizontal: dimen6),
                              //               decoration: BoxDecoration(
                              //                 borderRadius: border4,
                              //                 color: colorPrimary,
                              //                 // boxShadow: [
                              //                 //   BoxShadow(
                              //                 //       color: colorPrimary.withOpacity(0.5),
                              //                 //       blurRadius: dimen5,
                              //                 //       offset: const Offset(0, 3)),
                              //                 // ],
                              //                 image: DecorationImage(
                              //                   image: AssetImage(getAssetImage(
                              //                       AssetImagePath
                              //                           .theme_minigame_4)),
                              //                   fit: BoxFit.cover,
                              //                 ),
                              //               ),
                              //               child: Row(
                              //                 children: [
                              //                   Image.asset(
                              //                     getAssetImage(
                              //                         AssetImagePath.star),
                              //                     width: dimen14,
                              //                     height: dimen14,
                              //                   ),
                              //                   horizontalSpace4,
                              //                   Text(
                              //                     'Sponsor',
                              //                     style: GoogleFonts.quicksand(
                              //                       color: colorWhite,
                              //                       fontSize: 12,
                              //                       fontWeight: FontWeight.w600,
                              //                     ),
                              //                   ),
                              //                 ],
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       verticalSpace10,
                              //       Padding(
                              //         padding:
                              //             const EdgeInsets.only(left: dimen50),
                              //         child: Text(
                              //           'You and 4 others sponsored.',
                              //           style: GoogleFonts.quicksand(
                              //             fontSize: 13,
                              //             color: color565C6E,
                              //             fontWeight: FontWeight.w500,
                              //           ),
                              //           overflow: TextOverflow.ellipsis,
                              //           maxLines: 1,
                              //         ),
                              //       ),
                              //       verticalSpace5,
                              //       Padding(
                              //         padding:
                              //             const EdgeInsets.only(left: dimen50),
                              //         child: Row(
                              //           children: [
                              //             SizedBox(
                              //               width: 55,
                              //               child: Ranking(),
                              //             ),
                              //             horizontalSpace10,
                              //             Expanded(
                              //               child: Text(
                              //                 '5% towards the goal of 5000 ADA.',
                              //                 style: GoogleFonts.quicksand(
                              //                   fontSize: 13,
                              //                   color: color565C6E,
                              //                   fontWeight: FontWeight.w500,
                              //                 ),
                              //                 overflow: TextOverflow.ellipsis,
                              //                 maxLines: 2,
                              //               ),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // ),
                              verticalSpace24,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: dimen16, vertical: dimen10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'overview'.tr,
                                      style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        color: colorBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                          Routes.overview,
                                          arguments: {
                                            'title': socialTaskDetailController
                                                    .taskDetail?.description ??
                                                ''
                                          },
                                        );
                                      },
                                      child: Text(
                                        'Show more'.tr,
                                        style: GoogleFonts.quicksand(
                                          fontSize: 13,
                                          color: color1DA5F2,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                indent: dimen12,
                                endIndent: dimen12,
                                thickness: 0.5,
                              ),
                              // verticalSpace8,
                              // socialTaskDetailController.taskDetail?.type == 'event'
                              //     ? Padding(
                              //         padding: const EdgeInsets.only(left: dimen16),
                              //         child: Html(
                              //           data: socialTaskDetailController
                              //                   .taskDetail?.description ??
                              //               '',
                              //           style: {
                              //             "body": Style(
                              //               margin: EdgeInsets.zero,
                              //               padding: EdgeInsets.zero,
                              //               fontSize: FontSize.medium,
                              //               color: colorBlack,
                              //             )
                              //           },
                              //         ),
                              //       )
                              //     : Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: CollapsibleContent(
                              //             text: socialTaskDetailController
                              //                     .taskDetail?.description ??
                              //                 ''),
                              //       ),

                              verticalSpace10,
                              socialTaskDetailController.taskDetail?.type ==
                                      'event'
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          alignment: Alignment.topLeft,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: dimen16),
                                          child: Text(
                                            'Location'.tr,
                                            style: GoogleFonts.quicksand(
                                              fontSize: 18,
                                              color: colorBlack,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                        verticalSpace8,
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              dimen10,
                                            ),
                                          ),
                                          child: GoogleMap(
                                            mapType: MapType.normal,
                                            markers: _markers,
                                            onMapCreated: (GoogleMapController
                                                controller) {
                                              setState(
                                                () {
                                                  _markers.add(
                                                    Marker(
                                                      markerId: const MarkerId(
                                                          'id-1'),
                                                      position: LatLng(
                                                        socialTaskDetailController
                                                                .taskDetail?.lat
                                                                ?.toDouble() ??
                                                            lat,
                                                        socialTaskDetailController
                                                                .taskDetail?.lng
                                                                ?.toDouble() ??
                                                            lng,
                                                      ),
                                                      icon: BitmapDescriptor
                                                          .defaultMarkerWithHue(
                                                              BitmapDescriptor
                                                                  .hueBlue),
                                                      infoWindow:
                                                          const InfoWindow(
                                                              title:
                                                                  'Location'),
                                                    ),
                                                  );
                                                },
                                              );
                                            }
                                            // socialTaskDetailController.taskDetail?.lat as double,
                                            // socialTaskDetailController.taskDetail?.lng as double,
                                            ,
                                            initialCameraPosition:
                                                CameraPosition(
                                              target: LatLng(
                                                socialTaskDetailController
                                                        .taskDetail?.lat
                                                        ?.toDouble() ??
                                                    lat,
                                                socialTaskDetailController
                                                        .taskDetail?.lng
                                                        ?.toDouble() ??
                                                    lng,
                                              ),
                                              zoom: 18,
                                            ),
                                            rotateGesturesEnabled: false,
                                            scrollGesturesEnabled: false,
                                            tiltGesturesEnabled: false,
                                            zoomControlsEnabled: true,
                                            zoomGesturesEnabled: true,
                                          ),
                                        ),
                                        verticalSpace16,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: dimen20),
                                          child: Text(
                                            '${socialTaskDetailController.taskDetail?.address}',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 12.5,
                                              color: colorBlack,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        verticalSpace20,
                                        GestureDetector(
                                          onTap: () async {
                                            // openMaps(
                                            //   lat: socialTaskDetailController
                                            //           .taskDetail?.lat
                                            //           ?.toDouble() ??
                                            //       lat,
                                            //   long: socialTaskDetailController
                                            //           .taskDetail?.lng
                                            //           ?.toDouble() ??
                                            //       lng,
                                            // );
                                            MapsSheet.show(
                                              context: context,
                                              onMapTap: (maps) {
                                                maps.showMarker(
                                                  coords: map.Coords(
                                                    socialTaskDetailController
                                                            .taskDetail?.lat
                                                            ?.toDouble() ??
                                                        lat,
                                                    socialTaskDetailController
                                                            .taskDetail?.lng
                                                            ?.toDouble() ??
                                                        lng,
                                                  ),
                                                  title:
                                                      '${socialTaskDetailController.taskDetail?.address}',
                                                  zoom: 20,
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                width: dimen1,
                                                color: colorA2CCF3,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(dimen4),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: dimen18,
                                              vertical: dimen7,
                                            ),
                                            child: Text(
                                              'Open Maps',
                                              style: GoogleFonts.quicksand(
                                                fontSize: 13,
                                                color: color1DA5F2,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        verticalSpace24,
                                      ],
                                    )
                                  : const SizedBox(),
                              const Divider(
                                indent: dimen12,
                                endIndent: dimen12,
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: dimen16),
                                child: Text(
                                  'Share',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    color: colorBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              verticalSpace10,
                              SizedBox(
                                height: dimen80,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.separated(
                                  separatorBuilder: (ctx, index) {
                                    return const SizedBox(width: dimen16);
                                  },
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: dimen16),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 7,
                                  itemBuilder: (ctx, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        index == 0
                                            ? shareSocial(
                                                socialPlatfrom:
                                                    SocialMedia.facebook,
                                                title:
                                                    socialTaskDetailController
                                                            .taskDetail?.name ??
                                                        '',
                                                sub: '',
                                                urlEvent:
                                                    socialTaskDetailController
                                                        .taskDetail
                                                        ?.shares
                                                        ?.facebook,
                                              )
                                            : index == 1
                                                ? shareSocial(
                                                    socialPlatfrom:
                                                        SocialMedia.twitter,
                                                    title:
                                                        socialTaskDetailController
                                                                .taskDetail
                                                                ?.name ??
                                                            '',
                                                    sub: '',
                                                    urlEvent:
                                                        socialTaskDetailController
                                                            .taskDetail
                                                            ?.shares
                                                            ?.twitter,
                                                  )
                                                : index == 2
                                                    ? shareSocial(
                                                        socialPlatfrom:
                                                            SocialMedia
                                                                .telegram,
                                                        title:
                                                            socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.name ??
                                                                '',
                                                        sub: '',
                                                        urlEvent:
                                                            socialTaskDetailController
                                                                .taskDetail
                                                                ?.shares
                                                                ?.telegram,
                                                      )
                                                    : index == 3
                                                        ? shareSocial(
                                                            socialPlatfrom:
                                                                SocialMedia
                                                                    .email,
                                                            title: socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.name ??
                                                                '',
                                                            sub: '',
                                                            urlEvent:
                                                                socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.shares
                                                                    ?.email,
                                                          )
                                                        : index == 4
                                                            ? shareSocial(
                                                                socialPlatfrom:
                                                                    SocialMedia
                                                                        .linkedin,
                                                                title: socialTaskDetailController
                                                                        .taskDetail
                                                                        ?.name ??
                                                                    '',
                                                                sub: '',
                                                                urlEvent: socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.shares
                                                                    ?.linkedin,
                                                              )
                                                            : index == 5
                                                                ? shareSocial(
                                                                    socialPlatfrom:
                                                                        SocialMedia
                                                                            .whatsApp,
                                                                    title: socialTaskDetailController
                                                                            .taskDetail
                                                                            ?.name ??
                                                                        '',
                                                                    sub: '',
                                                                    urlEvent: socialTaskDetailController
                                                                        .taskDetail
                                                                        ?.shares
                                                                        ?.whatsapp,
                                                                  )
                                                                : _onShare(
                                                                    context:
                                                                        context,
                                                                    url: socialTaskDetailController
                                                                        .taskDetail
                                                                        ?.shares
                                                                        ?.facebook,
                                                                    sub:
                                                                        'Join "${socialTaskDetailController.taskDetail?.name}" now.',
                                                                  );
                                      },
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                            width: dimen40,
                                            height: dimen40,
                                            decoration: const BoxDecoration(
                                              color: colorF5F7F9,
                                              shape: BoxShape.circle,
                                            ),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      dimen60),
                                              child: Image.asset(
                                                index == 0
                                                    ? getAssetImage(
                                                        AssetImagePath
                                                            .facebook_icon)
                                                    : index == 1
                                                        ? getAssetImage(
                                                            AssetImagePath
                                                                .twitter_icon)
                                                        : index == 2
                                                            ? getAssetImage(
                                                                AssetImagePath
                                                                    .telegram_icon)
                                                            : index == 3
                                                                ? getAssetImage(
                                                                    AssetImagePath
                                                                        .email_icon)
                                                                : index == 4
                                                                    ? getAssetImage(
                                                                        AssetImagePath
                                                                            .linkedin_icon)
                                                                    : index == 5
                                                                        ? getAssetImage(AssetImagePath
                                                                            .whatsApp_icon)
                                                                        : getAssetImage(
                                                                            AssetImagePath.more_icon),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          verticalSpace6,
                                          Text(
                                            index == 0
                                                ? 'Facebook'
                                                : index == 1
                                                    ? 'Twitter'
                                                    : index == 2
                                                        ? 'Telegram'
                                                        : index == 3
                                                            ? 'Email'
                                                            : index == 4
                                                                ? 'Linkedin'
                                                                : index == 5
                                                                    ? 'WhatsApp'
                                                                    : 'Other',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 12,
                                              color: colorBlack,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),

                              verticalSpace24,
                              const Divider(
                                indent: dimen12,
                                endIndent: dimen12,
                                thickness: 0.5,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: dimen16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Q&A',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        color: colorBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace4,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: dimen16),
                                child: Text(
                                  'Ask a question about the event.',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 13,
                                    color: color8A8E9C,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              verticalSpace10,
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: dimen16),
                                child: _inputComment(),
                              ),
                              qAController.text.isNotEmpty
                                  ? GestureDetector(
                                      onTap: () {
                                        OverlayState? state =
                                            Overlay.of(context);
                                        showTopSnackBar(
                                          state!,
                                          CustomSnackBar.info(
                                            message:
                                                "Ask questions successfully.",
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
                                        qAController.clear();
                                      },
                                      child: Center(
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              width: dimen1,
                                              color: colorA2CCF3,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(dimen4),
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: dimen18,
                                            vertical: dimen7,
                                          ),
                                          child: Text(
                                            'Send',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 13,
                                              color: color1DA5F2,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    )
                                  : const SizedBox(),
                              verticalSpace24,
                              const Divider(
                                indent: dimen12,
                                endIndent: dimen12,
                                thickness: 0.5,
                              ),
                              socialTaskDetailController
                                              .taskDetail?.session?.jobs !=
                                          null &&
                                      socialTaskDetailController.taskDetail
                                              ?.session?.jobs?.isNotEmpty ==
                                          true
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: dimen16),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  socialTaskDetailController
                                                          .taskDetail
                                                          ?.session
                                                          ?.name ??
                                                      "",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 18,
                                                    color: colorBlack,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                ),
                                              ),
                                              // horizontalSpace2,
                                              // Image.asset(
                                              //   getAssetImage(AssetImagePath
                                              //       .ic_info_circle),
                                              //   width: dimen16,
                                              //   height: dimen16,
                                              //   color: color8A8E9C,
                                              // ),
                                              const Spacer(flex: 1),
                                              Text(
                                                socialTaskDetailController
                                                        .taskDetail
                                                        ?.session
                                                        ?.sessionSuccess ??
                                                    "",
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 14,
                                                  color: color1DA5F2,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalSpace4,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: dimen16),
                                          child: Text(
                                            'In order to have a chance to receive valuable gifts, complete the check-in mission.',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 13,
                                              color: color8A8E9C,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        verticalSpace10,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: dimen20),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: min(
                                                5,
                                                socialTaskDetailController
                                                        .taskDetail
                                                        ?.session
                                                        ?.jobs
                                                        ?.length ??
                                                    0),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: dimen10,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: dimen16,
                                                      height: dimen16,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: dimen2),
                                                      decoration: BoxDecoration(
                                                        color: socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.session
                                                                    ?.jobs?[
                                                                        index]
                                                                    .statusDone ==
                                                                true
                                                            ? color27AE60
                                                            : colorB7BBCB,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          width: dimen0,
                                                          color: colorB7BBCB,
                                                        ),
                                                      ),
                                                      child: socialTaskDetailController
                                                                  .taskDetail
                                                                  ?.session
                                                                  ?.jobs?[index]
                                                                  .statusDone ==
                                                              true
                                                          ? Image(
                                                              image: AssetImage(
                                                                getAssetImage(
                                                                    AssetImagePath
                                                                        .check),
                                                              ),
                                                              width: dimen16,
                                                              height: dimen16,
                                                            )
                                                          : const SizedBox(),
                                                    ),
                                                    horizontalSpace12,
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.session
                                                                    ?.jobs?[
                                                                        index]
                                                                    .name ??
                                                                '',
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              color: socialTaskDetailController
                                                                          .taskDetail
                                                                          ?.session
                                                                          ?.jobs?[
                                                                              index]
                                                                          .statusDone ==
                                                                      true
                                                                  ? colorBlack
                                                                  : colorB7BBCB,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.session
                                                                    ?.jobs?[
                                                                        index]
                                                                    .description ??
                                                                '',
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              color: socialTaskDetailController
                                                                          .taskDetail
                                                                          ?.session
                                                                          ?.jobs?[
                                                                              index]
                                                                          .statusDone ==
                                                                      true
                                                                  ? colorBlack
                                                                  : colorB7BBCB,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        socialTaskDetailController
                                                    .taskDetail
                                                    ?.session
                                                    ?.jobs
                                                    ?.length as int >
                                                5
                                            ? GestureDetector(
                                                onTap: () {
                                                  showMoreSessionOrBooth(
                                                    name:
                                                        socialTaskDetailController
                                                            .taskDetail
                                                            ?.session
                                                            ?.name,
                                                    decription:
                                                        'In order to have a chance to receive valuable gifts, complete the check-in mission.',
                                                    success:
                                                        socialTaskDetailController
                                                            .taskDetail
                                                            ?.session
                                                            ?.sessionSuccess,
                                                    jobs:
                                                        socialTaskDetailController
                                                                .taskDetail
                                                                ?.session
                                                                ?.jobs ??
                                                            [],
                                                  );
                                                },
                                                child: Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: dimen1,
                                                        color: colorA2CCF3,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              dimen4),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: dimen18,
                                                      vertical: dimen7,
                                                    ),
                                                    child: Text(
                                                      'Show More',
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontSize: 13,
                                                        color: color1DA5F2,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                        verticalSpace24,
                                        const Divider(
                                          indent: dimen12,
                                          endIndent: dimen12,
                                          thickness: 0.5,
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),

                              socialTaskDetailController
                                              .taskDetail?.booth?.jobs !=
                                          null &&
                                      socialTaskDetailController.taskDetail
                                              ?.booth?.jobs?.isNotEmpty ==
                                          true
                                  ? Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: dimen16),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Text(
                                                  socialTaskDetailController
                                                          .taskDetail
                                                          ?.booth
                                                          ?.name ??
                                                      "",
                                                  style: GoogleFonts.quicksand(
                                                    fontSize: 18,
                                                    color: colorBlack,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              // horizontalSpace2,
                                              // Image.asset(
                                              //   getAssetImage(AssetImagePath
                                              //       .ic_info_circle),
                                              //   width: dimen16,
                                              //   height: dimen16,
                                              //   color: color8A8E9C,
                                              // ),
                                              const Spacer(flex: 1),
                                              Text(
                                                socialTaskDetailController
                                                        .taskDetail
                                                        ?.booth
                                                        ?.boothSuccess ??
                                                    "",
                                                style: GoogleFonts.quicksand(
                                                  fontSize: 14,
                                                  color: color1DA5F2,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        verticalSpace4,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: dimen16),
                                          child: Text(
                                            'In order to have a chance to receive valuable gifts, complete the check-in mission.',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 13,
                                              color: color8A8E9C,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                        verticalSpace10,
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: dimen20),
                                          child: ListView.builder(
                                            padding: EdgeInsets.zero,
                                            shrinkWrap: true,
                                            itemCount: min(
                                                5,
                                                socialTaskDetailController
                                                        .taskDetail
                                                        ?.booth
                                                        ?.jobs
                                                        ?.length ??
                                                    0),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemBuilder: (context, index) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: dimen10,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      width: dimen16,
                                                      height: dimen16,
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: dimen2),
                                                      decoration: BoxDecoration(
                                                        color: socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.booth
                                                                    ?.jobs?[
                                                                        index]
                                                                    .statusDone ==
                                                                true
                                                            ? color27AE60
                                                            : colorB7BBCB,
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                          width: dimen0,
                                                          color: colorB7BBCB,
                                                        ),
                                                      ),
                                                      child: socialTaskDetailController
                                                                  .taskDetail
                                                                  ?.session
                                                                  ?.jobs?[index]
                                                                  .statusDone ==
                                                              true
                                                          ? Image(
                                                              image: AssetImage(
                                                                getAssetImage(
                                                                    AssetImagePath
                                                                        .check),
                                                              ),
                                                              width: dimen16,
                                                              height: dimen16,
                                                            )
                                                          : const SizedBox(),
                                                    ),
                                                    horizontalSpace12,
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.booth
                                                                    ?.jobs?[
                                                                        index]
                                                                    .name ??
                                                                '',
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              color: socialTaskDetailController
                                                                          .taskDetail
                                                                          ?.booth
                                                                          ?.jobs?[
                                                                              index]
                                                                          .statusDone ==
                                                                      true
                                                                  ? colorBlack
                                                                  : colorB7BBCB,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          Text(
                                                            socialTaskDetailController
                                                                    .taskDetail
                                                                    ?.booth
                                                                    ?.jobs?[
                                                                        index]
                                                                    .description ??
                                                                '',
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              color: socialTaskDetailController
                                                                          .taskDetail
                                                                          ?.booth
                                                                          ?.jobs?[
                                                                              index]
                                                                          .statusDone ==
                                                                      true
                                                                  ? colorBlack
                                                                  : colorB7BBCB,
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        socialTaskDetailController
                                                    .taskDetail
                                                    ?.booth
                                                    ?.jobs
                                                    ?.length as int >
                                                5
                                            ? GestureDetector(
                                                onTap: () {
                                                  showMoreSessionOrBooth(
                                                    name:
                                                        socialTaskDetailController
                                                            .taskDetail
                                                            ?.booth
                                                            ?.name,
                                                    decription:
                                                        'In order to have a chance to receive valuable gifts, complete the check-in mission.',
                                                    success:
                                                        socialTaskDetailController
                                                            .taskDetail
                                                            ?.booth
                                                            ?.boothSuccess,
                                                    jobs:
                                                        socialTaskDetailController
                                                                .taskDetail
                                                                ?.booth
                                                                ?.jobs ??
                                                            [],
                                                  );
                                                },
                                                child: Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: dimen1,
                                                        color: colorA2CCF3,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              dimen4),
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: dimen18,
                                                      vertical: dimen7,
                                                    ),
                                                    child: Text(
                                                      'Show More',
                                                      style:
                                                          GoogleFonts.quicksand(
                                                        fontSize: 13,
                                                        color: color1DA5F2,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                        verticalSpace24,
                                        // const Divider(
                                        //   indent: dimen12,
                                        //   endIndent: dimen12,
                                        //   thickness: 0.5,
                                        // ),
                                      ],
                                    )
                                  : const SizedBox(),
// comment social task
                              Padding(
                                padding: const EdgeInsets.only(left: dimen16),
                                child: Row(
                                  children: [
                                    Text(
                                      'Complete Task One by One',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        color: colorBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace10,
                              const ListSocialTaskWidget(),
                              verticalSpace24,

                              socialTaskDetailController.taskDetail?.linkQuiz !=
                                          null &&
                                      socialTaskDetailController.taskDetail
                                              ?.linkQuiz?.isNotEmpty ==
                                          true
                                  ? const Divider(
                                      indent: dimen12,
                                      endIndent: dimen12,
                                      thickness: 0.5,
                                    )
                                  : const SizedBox(),
                              socialTaskDetailController.taskDetail?.linkQuiz !=
                                          null &&
                                      socialTaskDetailController.taskDetail
                                              ?.linkQuiz?.isNotEmpty ==
                                          true
                                  ? Padding(
                                      padding:
                                          const EdgeInsets.only(left: dimen16),
                                      child: Row(
                                        children: [
                                          Text(
                                            '#MiniGame',
                                            style: GoogleFonts.quicksand(
                                              fontSize: 18,
                                              color: colorBlack,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                              verticalSpace10,
                              socialTaskDetailController.taskDetail?.linkQuiz !=
                                          null &&
                                      socialTaskDetailController.taskDetail
                                              ?.linkQuiz?.isNotEmpty ==
                                          true
                                  ? SizedBox(
                                      height: dimen150,
                                      child: ListView.separated(
                                        separatorBuilder: (ctx, index) {
                                          return const SizedBox(width: dimen16);
                                        },
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: dimen16),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 1,
                                        itemBuilder: (ctx, index) {
                                          return GestureDetector(
                                            onTap: () {
                                              OverlayState? state =
                                                  Overlay.of(context);
                                              showTopSnackBar(
                                                state!,
                                                CustomSnackBar.info(
                                                  message:
                                                      "Unlocks when completing the mission.",
                                                  textStyle:
                                                      GoogleFonts.quicksand(
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.7,
                                              height: dimen150,
                                              decoration: BoxDecoration(
                                                color: color495057,
                                                image: DecorationImage(
                                                  colorFilter: ColorFilter.mode(
                                                    colorBlack.withOpacity(.1),
                                                    BlendMode.multiply,
                                                  ),
                                                  image: index == 0
                                                      ? AssetImage(getAssetImage(
                                                          AssetImagePath
                                                              .theme_minigame_1))
                                                      : index == 1
                                                          ? AssetImage(
                                                              getAssetImage(
                                                                  AssetImagePath
                                                                      .theme_minigame_3))
                                                          : index == 2
                                                              ? AssetImage(
                                                                  getAssetImage(
                                                                      AssetImagePath
                                                                          .theme_minigame_2))
                                                              : AssetImage(
                                                                  getAssetImage(
                                                                      AssetImagePath
                                                                          .theme_minigame_1)),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        dimen8),
                                                // border: Border.all(
                                                //   width: dimen1,
                                                //   color: index == 0
                                                //       ? color27AE60
                                                //       : index == 1
                                                //           ? color5260E6
                                                //           : index == 2
                                                //               ? colorDA656A
                                                //               : color1DA5F2,
                                                // ),
                                              ),
                                              child: index == 1 || index == 2
                                                  ? Stack(
                                                      children: [
                                                        Center(
                                                          child: Text(
                                                            index == 0
                                                                ? 'Whell Of Fortune'
                                                                : index == 1
                                                                    ? 'Quiz'
                                                                    : index == 2
                                                                        ? 'Giveaway'
                                                                        : '',
                                                            style: GoogleFonts
                                                                .quicksand(
                                                              fontSize: 20,
                                                              color: colorWhite,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                        Positioned(
                                                          bottom: 0,
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                                    color:
                                                                        colorBlack50,
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .only(
                                                                      bottomLeft:
                                                                          Radius.circular(
                                                                              8),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              8),
                                                                    )),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.7,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        dimen4),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  'Prize code:',
                                                                  style: GoogleFonts
                                                                      .quicksand(
                                                                    fontSize:
                                                                        13,
                                                                    color:
                                                                        colorTextHint,
                                                                    //  index == 0
                                                                    //     ? colorFFB800
                                                                    //     : index == 1
                                                                    //         ? colorA73237
                                                                    //         : index == 2
                                                                    //             ? color8994EE
                                                                    //             : color1DA5F2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                horizontalSpace10,
                                                                Text(
                                                                  '956432',
                                                                  style: GoogleFonts
                                                                      .quicksand(
                                                                    fontSize:
                                                                        16,
                                                                    color: index ==
                                                                            0
                                                                        ? colorFFB800
                                                                        : index ==
                                                                                1
                                                                            ? colorDA656A
                                                                            : index == 2
                                                                                ? color8994EE
                                                                                : color1DA5F2,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w700,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Image.asset(
                                                          getAssetImage(
                                                              AssetImagePath
                                                                  .lock_icon),
                                                          width: dimen40,
                                                          height: dimen40,
                                                          color: colorWhite,
                                                        ),
                                                        verticalSpace10,
                                                        Text(
                                                          index == 0
                                                              ? 'Quiz'
                                                              : index == 1
                                                                  ? 'Whell Of Fortune'
                                                                  : index == 2
                                                                      ? 'Giveaway'
                                                                      : '',
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            fontSize: 18,
                                                            color: colorWhite,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        Text(
                                                          'Unlocks when completing the mission',
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            fontSize: 13,
                                                            color: colorEEF1F5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ],
                                                    ),
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                  : const SizedBox(),

                              verticalSpace120,
                              // const SocialTaskPerformWidget(),
                              // socialTaskDetailController.taskDetail?.type ==
                              //         'event'
                              //     ? const SizedBox()
                              //     : schedule,
                            ],
                          ),
                        ),
                        // ] else if (socialTaskDetailController
                        //         .taskDetail?.taskStart ==
                        //     true) ...[
                        //   const Padding(
                        //     padding: EdgeInsets.symmetric(horizontal: dimen24),
                        //     child: SocialTaskPerformWidget(),
                        //   ),
                        // ] else if (isDone == true) ...[
                        //   // Obx(
                        //   //   () => AppSlider(
                        //   //     images: socialTaskDetailController
                        //   //             .taskDetail?.galleries
                        //   //             ?.asMap()
                        //   //             .values
                        //   //             .map((e) => e.url ?? "")
                        //   //             .toList() ??
                        //   //         [],
                        //   //     label: 'social_task'.tr.capitalizeFirst,
                        //   //   ),
                        //   // ),
                        //   Container(
                        //     margin: const EdgeInsets.symmetric(horizontal: dimen8),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         verticalSpace16,
                        //         Row(
                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Expanded(
                        //               child: Text(
                        //                 socialTaskDetailController
                        //                             .taskDetail?.postBy !=
                        //                         null
                        //                     ? 'by '.tr +
                        //                         (socialTaskDetailController
                        //                                 .taskDetail?.postBy ??
                        //                             '')
                        //                     : '',
                        //                 style: text14_9C9896_400,
                        //               ),
                        //             ),
                        //             socialNetwork(
                        //                 title: 'Like', icon: AssetImagePath.like),
                        //             socialNetwork(
                        //                 title: 'Share', icon: AssetImagePath.share),
                        //             socialNetwork(
                        //                 title: 'Pin', icon: AssetImagePath.pin),
                        //           ],
                        //         ),
                        //         verticalSpace24,
                        //         if (socialTaskDetailController
                        //                     .taskDetail?.description !=
                        //                 null &&
                        //             socialTaskDetailController
                        //                     .taskDetail?.description?.isNotEmpty ==
                        //                 true) ...[
                        //           Text('overview'.tr, style: text18_32302D_700),
                        //           verticalSpace8,
                        //           // overviewContent,
                        //           verticalSpace24,
                        //         ],
                        //         // googleMapWidget,
                        //         // schedule,
                        //         verticalSpace100,
                        //       ],
                        //     ),
                        //   )
                        // ] else if (socialTaskDetailController
                        //             .taskDetail?.taskStart !=
                        //         null &&
                        //     socialTaskDetailController.taskDetail?.taskStart ==
                        //         false) ...[
                        //   // Obx(
                        //   //   () => AppSlider(
                        //   //     // images: socialTaskDetailController
                        //   //     //         .taskDetail?.bannerUrl??[],
                        //   //     label: 'social_task'.tr.capitalizeFirst,
                        //   //   ),
                        //   // ),
                        //   Container(
                        //     margin: const EdgeInsets.symmetric(horizontal: dimen8),
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         verticalSpace16,
                        //         if (socialTaskDetailController
                        //                 .taskDetail?.taskStart ==
                        //             false) ...[
                        //           // header,
                        //           verticalSpace24,
                        //           if (socialTaskDetailController
                        //                       .taskDetail?.description !=
                        //                   null &&
                        //               socialTaskDetailController.taskDetail
                        //                       ?.description?.isNotEmpty ==
                        //                   true) ...[
                        //             Text('overview'.tr, style: text18_32302D_700),
                        //             verticalSpace8,
                        //             // overviewContent,
                        //           ],
                        //           verticalSpace24,
                        //         ],
                        //         // schedule,
                        //         verticalSpace100,
                        //       ],
                        //       //   ))
                        //       // ]
                        //       // ])),
                        //     ),
                        //   )
                        // ]
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    final Widget taskDetailBodyShimmer = SingleChildScrollView(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: dimen16, vertical: dimen8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppShimmer(
            width: context.width,
            height: context.width,
            cornerRadius: dimen16,
          ),
          verticalSpace16,
          AppShimmer(
            width: context.width * 0.5,
            height: dimen34,
            cornerRadius: dimen8,
          ),
          verticalSpace8,
          AppShimmer(
            width: dimen52,
            height: dimen14,
            cornerRadius: dimen8,
          ),
          verticalSpace24,
          AppShimmer(
            width: context.width * 0.3,
            height: dimen22,
            cornerRadius: dimen8,
          ),
          verticalSpace8,
          AppShimmer(
            width: context.width,
            height: dimen76,
            cornerRadius: dimen8,
          ),
          verticalSpace24,
          AppShimmer(
            width: context.width * 0.3,
            height: dimen22,
            cornerRadius: dimen8,
          ),
          verticalSpace8,
          AppShimmer(
            width: context.width,
            height: 200,
            cornerRadius: dimen16,
          ),
          verticalSpace16,
          AppShimmer(
            width: context.width,
            height: dimen32,
            cornerRadius: dimen8,
          ),
          verticalSpace16,
          ListView.separated(
            separatorBuilder: (context, index) => verticalSpace16,
            itemCount: 4,
            //sampleCoords.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) => const LocationItemShimmer(),
          ),
          verticalSpace88,
        ],
      ),
    ));
    final Widget positionedBottomSheet = Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: dimen2,
            sigmaY: dimen2,
          ),
          child: Container(
            color: colorE8F2FC.withOpacity(0.9),
            padding: Platform.isIOS && MediaQuery.of(context).size.height >= 812
                ? const EdgeInsets.only(
                    left: dimen20,
                    right: dimen20,
                    top: dimen12,
                    bottom: dimen32)
                : const EdgeInsets.symmetric(
                    horizontal: dimen20, vertical: dimen16),
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Free!',
                      style: GoogleFonts.quicksand(
                        color: color171716,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'on Plats',
                      style: GoogleFonts.quicksand(
                        color: color878998,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const Spacer(),

                //comment sponsor
                // scrollPosition > 681
                //     ? SlideAnimation(
                //         intervalStart: 0.1,
                //         begin: const Offset(30, 0),
                //         duration: const Duration(milliseconds: 400),
                //         child: FadeAnimation(
                //           child: GestureDetector(
                //             onTap: () {
                //               showCupertinoModalBottomSheet(
                //                 context: context,
                //                 builder: (context) => Scaffold(
                //                   body: SizedBox(
                //                     width: MediaQuery.of(context).size.width,
                //                     height: MediaQuery.of(context).size.height,
                //                   ),
                //                 ),
                //               );
                //             },
                //             child: Container(
                //               height: dimen40,
                //               padding: const EdgeInsets.symmetric(
                //                   vertical: dimen0, horizontal: dimen11),
                //               margin: const EdgeInsets.only(right: 12),
                //               decoration: BoxDecoration(
                //                 borderRadius: border6,
                //                 color: colorPrimary,
                //                 // boxShadow: [
                //                 //   BoxShadow(
                //                 //       color: colorPrimary.withOpacity(0.5),
                //                 //       blurRadius: dimen5,
                //                 //       offset: const Offset(0, 3)),
                //                 // ],
                //                 image: DecorationImage(
                //                   image: AssetImage(getAssetImage(
                //                       AssetImagePath.theme_minigame_4)),
                //                   fit: BoxFit.cover,
                //                 ),
                //                 gradient: const LinearGradient(
                //                   begin: Alignment.topLeft,
                //                   end: Alignment.bottomRight,
                //                   stops: [0.1, 0.3, 0.7],
                //                   colors: [
                //                     Color.fromARGB(255, 54, 130, 230),
                //                     Color.fromARGB(255, 69, 173, 225),
                //                     Color.fromARGB(255, 40, 191, 194),
                //                   ],
                //                 ),
                //               ),
                //               child: Row(
                //                 children: [
                //                   // Image.asset(
                //                   //   getAssetImage(AssetImagePath.star),
                //                   //   width: dimen20,
                //                   //   height: dimen20,
                //                   // ),
                //                   // horizontalSpace10,
                //                   Text(
                //                     'Sponsor',
                //                     style: GoogleFonts.quicksand(
                //                       color: colorWhite,
                //                       fontSize: 12,
                //                       fontWeight: FontWeight.w600,
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //           ),
                //         ),
                //       )
                //     : const SizedBox(),
                GestureDetector(
                  onTap:
                      socialTaskDetailController.taskDetail?.flagTicket == true
                          ? () {}
                          : () {
                              socialTaskDetailController.fetchGetTicket(taskId);
                            },
                  child: Container(
                    height: dimen40,
                    width: scrollPosition > 681 ? dimen150 : dimen180,
                    decoration: BoxDecoration(
                      borderRadius: border6,
                      color:
                          socialTaskDetailController.taskDetail?.flagTicket ==
                                  true
                              ? colorDCDCDC
                              : colorPrimary,
                      boxShadow: [
                        BoxShadow(
                            color: socialTaskDetailController
                                        .taskDetail?.flagTicket ==
                                    true
                                ? colorDCDCDC.withOpacity(0.5)
                                : colorPrimary.withOpacity(0.5),
                            blurRadius: dimen5,
                            offset: const Offset(0, 3)),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        socialTaskDetailController.taskDetail?.flagTicket ==
                                true
                            ? 'Ticket Received'
                            : 'Get Tickets',
                        style: GoogleFonts.quicksand(
                          color: socialTaskDetailController
                                      .taskDetail?.flagTicket ==
                                  true
                              ? color878998
                              : colorWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    final Widget positionedBottomSheetShimmer = Positioned(
        bottom: 0,
        right: 0,
        left: 0,
        child: Container(
          color: colorE8F2FC,
          padding: const EdgeInsets.symmetric(
              horizontal: dimen24, vertical: dimen16),
          child: Row(
            children: [
              AppShimmer(
                width: dimen56,
                height: dimen56,
                cornerRadius: dimen50,
              ),
              horizontalSpace8,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppShimmer(
                    width: dimen52,
                    height: dimen14,
                    cornerRadius: dimen8,
                  ),
                  verticalSpace4,
                  AppShimmer(
                    width: dimen52,
                    height: dimen14,
                    cornerRadius: dimen8,
                  ),
                ],
              ),
              Expanded(child: Container()),
              AppShimmer(
                width: dimen52,
                height: dimen14,
                cornerRadius: dimen8,
              ),
            ],
          ),
        ));
    return Obx(
      () => GestureDetector(
        onTap: () {
          Get.focusScope?.unfocus();
        },
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: colorWhite,
          // appBar:
          //     // socialTaskDetailController.taskDetail?.taskStart != null &&
          //     //         socialTaskDetailController.taskDetail?.taskStart == false
          //     //     ?
          //     AppBar(
          //   flexibleSpace: ClipRect(
          //     child: BackdropFilter(
          //       filter: ImageFilter.blur(
          //         sigmaX: dimen10,
          //         sigmaY: dimen10,
          //       ),
          //       child: Container(
          //         color: Colors.transparent,
          //       ),
          //     ),
          //   ),
          //   elevation: dimen0,
          //   leadingWidth: dimen68,
          //   backgroundColor: Colors.white.withAlpha(200),
          //   title: Text(
          //     scrollPosition >= 315
          //         ? socialTaskDetailController.taskDetail?.name ?? ''
          //         : '',
          //     style: const TextStyle(
          //       color: colorBlack,
          //       fontSize: dimen14,
          //     ),
          //   ),
          //   centerTitle: false,
          //   leading: Padding(
          //     padding: EdgeInsets.only(
          //         left: scrollPosition <= 315 ? dimen20 : dimen10),
          //     child: scrollPosition <= 315
          //         ? AppBackButton(
          //             onTab: isBacktoHome
          //                 ? () {
          //                     Navigator.pushNamedAndRemoveUntil(
          //                         context, Routes.home, (_) => false);
          //                   }
          //                 : () {
          //                     print('.............1');
          //                     _homeTabController.fetchTaskPoolTask();
          //                     socialTaskDetailController
          //                         .setSelectedLocationIndex(-1);
          //                     Get.back();
          //                     _homeTabController.fetchEventTask();
          //                     _homeTabController.fetchTask();
          //                     _homeTabController.fetchTaskPoolTask();
          //                     indexController.fetchParticipatingEvent();
          //                     indexController.fetchTask();
          //                     indexController.fetchTaskEvent();
          //                   },
          //           )
          //         : GestureDetector(
          //             onTap: isBacktoHome
          //                 ? () {
          //                     Navigator.pushNamedAndRemoveUntil(
          //                         context, Routes.home, (_) => false);
          //                   }
          //                 : () {
          //                     _homeTabController.fetchTaskPoolTask();

          //                     socialTaskDetailController
          //                         .setSelectedLocationIndex(-1);
          //                     Get.back();
          //                     _homeTabController.fetchEventTask();
          //                     _homeTabController.fetchTask();
          //                     _homeTabController.fetchTaskPoolTask();
          //                     indexController.fetchParticipatingEvent();
          //                     indexController.fetchTask();
          //                     indexController.fetchTaskEvent();
          //                   },
          //             child: Container(
          //               width: dimen20,
          //               height: dimen20,
          //               padding: const EdgeInsets.all(dimen16),
          //               child: Image.asset(
          //                 getAssetImage(AssetImagePath.left),
          //                 color: color2A2A64,
          //               ),
          //             ),
          //           ),
          //   ),
          //   actions: [
          //     scrollPosition <= 315
          //         ? const SizedBox()
          //         : Container(
          //             child: LikeButton(
          //               isLiked:
          //                   socialTaskDetailController.taskDetail?.like?.isLike ??
          //                       false,
          //               likeCountPadding: EdgeInsets.zero,
          //               onTap: (bool value) async {
          //                 setState(() {
          //                   isLike = !isLike;
          //                   socialTaskDetailController.taskDetail?.like?.isLike =
          //                       isLike;
          //                   if (isLike == true) {
          //                     socialTaskDetailController.fetchLikeOrPin(
          //                         taskId, 'like');
          //                   } else {
          //                     socialTaskDetailController.fetchLikeOrPin(
          //                         taskId, 'unlike');
          //                   }
          //                 });
          //                 return Future.value(!value);
          //               },
          //               size: 20,
          //               circleColor: const CircleColor(
          //                   start: Colors.pink, end: Colors.pinkAccent),
          //               bubblesColor: const BubblesColor(
          //                 dotPrimaryColor: Colors.red,
          //                 dotSecondaryColor: Colors.redAccent,
          //               ),
          //               likeBuilder: (bool isLiked) {
          //                 return Icon(
          //                   Icons.favorite,
          //                   color: socialTaskDetailController
          //                               .taskDetail?.like?.isLike ??
          //                           false
          //                       ? Colors.pink
          //                       : Colors.grey[300],
          //                   size: 20,
          //                 );
          //               },
          //             ),
          //           ),
          //     scrollPosition <= 315
          //         ? likeButton()
          //         : Container(
          //             width: dimen40,
          //             height: dimen40,
          //             margin: const EdgeInsets.only(right: dimen20),
          //             decoration: const BoxDecoration(
          //               color: Colors.transparent,
          //               // shape: BoxShape.circle,
          //               // boxShadow: [
          //               //   BoxShadow(
          //               //     color: colorB7BBCB,
          //               //     blurRadius: dimen3,
          //               //     offset: Offset(0, 2),
          //               //   ),
          //               // ],
          //             ),
          //             child: LikeButton(
          //               likeCountPadding: EdgeInsets.zero,
          //               isLiked: isPin,
          //               onTap: (bool value) async {
          //                 setState(
          //                   () {
          //                     isPin = !isPin;
          //                     socialTaskDetailController.taskDetail?.pin?.isPin =
          //                         isPin;
          //                     if (isPin == true) {
          //                       socialTaskDetailController.fetchLikeOrPin(
          //                           taskId, 'pin');
          //                     } else {
          //                       socialTaskDetailController.fetchLikeOrPin(
          //                           taskId, 'unpin');
          //                     }
          //                   },
          //                 );
          //                 return Future.value(!value);
          //               },
          //               size: 20,
          //               circleColor: const CircleColor(
          //                 start: colorFFB800,
          //                 end: Color.fromARGB(255, 255, 208, 90),
          //               ),
          //               bubblesColor: const BubblesColor(
          //                 dotPrimaryColor: Color.fromARGB(255, 255, 208, 90),
          //                 dotSecondaryColor: Color.fromARGB(255, 226, 199, 131),
          //               ),
          //               likeBuilder: (bool isLiked) {
          //                 return Image.asset(
          //                   getAssetImage(
          //                     socialTaskDetailController.taskDetail?.pin?.isPin ??
          //                             false
          //                         ? AssetImagePath.bookmark
          //                         : AssetImagePath.bookmark_line,
          //                   ),
          //                   width: dimen20,
          //                   height: dimen20,
          //                   color: socialTaskDetailController
          //                               .taskDetail?.pin?.isPin ??
          //                           false
          //                       ? colorFFB800
          //                       : colorFFB800,
          //                 );
          //               },
          //             ),
          //           ),
          //   ],
          // ),
          // : null,
          body: Stack(
            children: [
              socialTaskDetailController.isFetchingTaskDetail()
                  ? Stack(
                      children: [
                        taskDetailBodyShimmer,
                        positionedBottomSheetShimmer,
                        const FullScreenProgress(),
                      ],
                    )
                  : Stack(
                      children: [
                        taskDetailBody,
                        positionedBottomSheet,
                      ],
                    ),

              Positioned(
                // top: Platform.isIOS && MediaQuery.of(context).size.height >= 700
                //     ? dimen50
                //     : dimen20,
                left: dimen16,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: isBacktoHome
                        ? () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.home, (_) => false);
                          }
                        : () {
                            // _homeTabController.fetchTaskPoolTask();
                            socialTaskDetailController
                                .setSelectedLocationIndex(-1);
                            Get.back();
                            // _homeTabController.fetchEventTask();
                            // _homeTabController.fetchTask();
                            // _homeTabController.fetchTaskPoolTask();
                            indexController.fetchTrendingEvent();
                            // indexController.fetchParticipatingEvent();
                            // indexController.fetchTask();
                            // indexController.fetchTaskEvent();
                          },
                    child: Image.asset(
                      getAssetImage(AssetImagePath.back_button),
                      width: dimen48,
                      height: dimen48,
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   // top: Platform.isIOS && MediaQuery.of(context).size.height >= 700
              //   //     ? dimen50
              //   //     : dimen20,
              //   right: dimen16,
              //   child: SafeArea(
              //     child: GestureDetector(
              //       onTap: () {
              //         Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //               builder: (context) => const QRCodeScreen()),
              //         );
              //       },
              //       child: Container(
              //         width: dimen40,
              //         height: dimen40,
              //         decoration: const BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: colorWhite,
              //           boxShadow: [
              //             BoxShadow(
              //               color: colorDCDCDC,
              //               blurRadius: dimen3,
              //               offset: Offset(0, 2),
              //             ),
              //           ],
              //         ),
              //         padding: const EdgeInsets.all(dimen7),
              //         child: Image.asset(
              //           getAssetImage(AssetImagePath.scan),
              //           color: color1DA5F2,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // socialTaskDetailController.isConnectTwitterLoading() ||
              // socialTaskDetailController.isStartTaskLoading() ||
              //         socialTaskDetailController.isFetchingGetTicket()
              //     ? Stack(
              //         children: const [
              //           FullScreenProgress(),
              //         ],
              //       )
              //     : Container(),
            ],
          ),
        ),
      ),
    );

    // Obx(
    //   () => CommonAppPage(
    //     padding:
    //         const EdgeInsets.only(left: dimen28, right: dimen28, top: dimen40),
    //     hasSafeAreaBottom: false,
    //     hasSafeAreaTop: false,
    //     hasLikeButton: true,
    //     backgroundColor: colorWhite,
    //     onTap: () {
    //       _homeTabController.fetchTaskPoolTask();
    //       Get.back();
    //     },
    //     buttom: likeButton(),
    //     appBar: socialTaskDetailController.taskDetail?.taskStart != null &&
    //             socialTaskDetailController.taskDetail?.taskStart == false
    //         ? null
    //         : PreferredSize(
    //             preferredSize: const Size.fromHeight(0),
    //             child: Container(),
    //           ),
    //     children: [
    //       socialTaskDetailController.isFetchingTaskDetail()
    //           ? Stack(
    //               children: [
    //                 taskDetailBodyShimmer,
    //                 positionedBottomSheetShimmer,
    //                 const FullScreenProgress(),
    //               ],
    //             )
    //           : Stack(
    //               children: [
    //                 taskDetailBody,
    //                 positionedBottomSheet,
    //               ],
    //             ),
    //       // socialTaskDetailController.isConnectTwitterLoading() ||
    //       //         socialTaskDetailController.isStartTaskLoading()
    //       //     ? Stack(
    //       //         children: const [
    //       //           FullScreenProgress(),
    //       //         ],
    //       //       )
    //       // : Container(),
    //     ],
    //   ),
    // );
  }

  Widget socialNetwork({
    String? title,
    String? icon,
    bool? isLike,
    bool? isPin,
    Function(bool)? onCheckChanged,
  }) {
    return GestureDetector(
      onTap: () {
        if (title == 'Pin' || title == 'UnPin') {
          setState(() {
            isPin = !isPin!;
            onCheckChanged!(isPin as bool);
            if (isPin == true) {
              socialTaskDetailController.fetchLikeOrPin(taskId, 'pin');
            } else {
              socialTaskDetailController.fetchLikeOrPin(taskId, 'unpin');
            }
          });
        }
        if (title == 'Like' || title == 'UnLike') {
          setState(() {
            isLike = !isLike!;
            onCheckChanged!(isLike as bool);
            if (isLike == true) {
              socialTaskDetailController.fetchLikeOrPin(taskId, 'like');
            } else {
              socialTaskDetailController.fetchLikeOrPin(taskId, 'unlike');
            }
          });
        } else {
          print('Share');
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (title == 'Pin' || title == 'UnPin') ...[
            if (isPin == true) ...[
              Image.asset(
                getAssetImage(AssetImagePath.pin_bold),
                width: dimen16,
                height: dimen16,
                color: colorEA4335,
              ),
            ] else ...[
              Image.asset(
                getAssetImage(icon ?? ''),
                width: dimen16,
                height: dimen16,
                color: color32302D,
              ),
            ]
          ] else if (title == 'Like' || title == 'UnLike') ...[
            if (isLike == true) ...[
              Image.asset(
                getAssetImage(AssetImagePath.like_bold),
                width: dimen16,
                height: dimen16,
                color: color1DA5F2,
              ),
            ] else ...[
              Image.asset(
                getAssetImage(icon ?? ''),
                width: dimen16,
                height: dimen16,
                color: color32302D,
              ),
            ]
          ] else ...[
            Image.asset(
              getAssetImage(icon ?? ''),
              width: dimen16,
              height: dimen16,
              color: color32302D,
            ),
          ],
          horizontalSpace6,
          Text(
            title ?? '',
            style: text12_32302D_600,
          ),
        ],
      ),
    );
  }

  Widget likeButton() {
    return Container(
      width: dimen40,
      height: dimen40,
      margin: const EdgeInsets.only(right: dimen20),
      decoration: const BoxDecoration(
        color: colorWhite,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: colorB7BBCB,
            blurRadius: dimen3,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: LikeButton(
        likeCountPadding: EdgeInsets.zero,
        isLiked: isPin,
        onTap: (bool value) async {
          setState(
            () {
              isPin = !isPin;
              socialTaskDetailController.taskDetail?.pin?.isPin = isPin;
              if (isPin == true) {
                socialTaskDetailController.fetchLikeOrPin(taskId, 'pin');
              } else {
                socialTaskDetailController.fetchLikeOrPin(taskId, 'unpin');
              }
            },
          );
          return Future.value(!value);
        },
        size: 20,
        circleColor: const CircleColor(
          start: colorFFB800,
          end: Color.fromARGB(255, 255, 208, 90),
        ),
        bubblesColor: const BubblesColor(
          dotPrimaryColor: Color.fromARGB(255, 255, 208, 90),
          dotSecondaryColor: Color.fromARGB(255, 226, 199, 131),
        ),
        likeBuilder: (bool isLiked) {
          return Image.asset(
            getAssetImage(
              socialTaskDetailController.taskDetail?.pin?.isPin ?? false
                  ? AssetImagePath.bookmark
                  : AssetImagePath.bookmark_line,
            ),
            width: dimen20,
            height: dimen20,
            color: socialTaskDetailController.taskDetail?.pin?.isPin ?? false
                ? colorFFB800
                : colorFFB800,
          );
        },
      ),
    );
  }

  static Future<void> showCustomDialog(
      BuildContext context, String? message) async {
    showDialog<void>(
      barrierColor: color565C6E.withOpacity(0.95),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: SizedBox(
            height: 320,
            child: Padding(
              padding: const EdgeInsets.all(dimen24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/sending.gif',
                    width: dimen160,
                    height: dimen160,
                  ),
                  Text(
                    'Tickets have been sent!',
                    style: GoogleFonts.quicksand(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: color1D93E3,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      message ?? 'Please check your mail now!',
                      style: GoogleFonts.quicksand(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: color1D93E3,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        borderRadius: border6,
                        color: colorPrimary,
                        boxShadow: [
                          BoxShadow(
                              color: colorPrimary.withOpacity(0.5),
                              blurRadius: dimen5,
                              offset: const Offset(0, 3)),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Got it',
                          style: GoogleFonts.quicksand(
                            color: colorWhite,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _inputComment() {
    return TextFormField(
      controller: qAController,
      maxLines: null,
      decoration: InputDecoration(
        suffixIcon: qAController.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  qAController.clear();
                },
                child: Container(
                  padding: const EdgeInsets.all(dimen14),
                  child: Image.asset(
                    getAssetImage(AssetImagePath.clear),
                    width: dimen14,
                    height: dimen14,
                  ),
                ),
              )
            : const SizedBox(),
        contentPadding: const EdgeInsets.only(
          top: dimen17,
          bottom: dimen17,
          left: dimen15,
          right: dimen15,
        ),
        counter: const SizedBox(),
        hintStyle: GoogleFonts.quicksand(
          fontSize: dimen13,
          color: color4E5260,
        ),
        hintText: "Ask a question about the event.",
        fillColor: colorF5F7F9,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: colorWhite,
            width: 0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: colorWhite,
            width: 0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(
            color: colorWhite,
            width: 0,
          ),
        ),
      ),
    );
  }

  void fetchTaskDetail() {
    socialTaskDetailController.fetchTaskDetail(taskId);
  }

  void fetchSocialAccount() {
    // socialTaskDetailController.fetchSocialAccount();
  }

  startTask() {
    socialTaskDetailController.startTask(taskId, 'start');
    fetchTaskDetail();
  }

  cancelTask() {
    socialTaskDetailController.startTask(taskId, 'cancel');
    fetchTaskDetail();
  }

  Widget Ranking() {
    return Container(
      margin: EdgeInsets.zero,
      height: dimen10,
      child: SliderTheme(
        data: SliderThemeData(
          disabledActiveTrackColor: colorB04386,
          disabledInactiveTrackColor: colorE4E1E1,
          trackHeight: 7,
          thumbShape: SliderComponentShape.noThumb,
          trackShape: SliderCustomTrackShape(),
        ),
        child: const Slider(
          value: 5,
          onChanged: null,
          min: 0,
          max: 100,
        ),
      ),
    );
  }
}

class MapsSheet {
  static show({
    required BuildContext context,
    required Function(map.AvailableMap map) onMapTap,
  }) async {
    final availableMaps = await map.MapLauncher.installedMaps;
    for (var map in availableMaps) {
      map.mapName = getLocalName(amap: map);
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return SafeArea(
          bottom: false,
          child: Container(
            decoration: const BoxDecoration(
              color: colorWhite,
            ),
            child: StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Container(
                    child: Wrap(
                      children: <Widget>[
                        for (var map in availableMaps)
                          ListTile(
                            onTap: () => [
                              onMapTap(map),
                              Get.back(),
                            ],
                            title: Text(map.mapName),
                            // leading: SvgPicture.asset(
                            //   map.icon,
                            //   height: 50.0,
                            //   width: 50.0,
                            // ),
                          ),
                      ],
                    ),
                  );
                }),
          ),
        );
      },
    );
  }
}

String getLocalName({required map.AvailableMap amap}) {
  switch (amap.mapType) {
    case map.MapType.google:
      return 'Google Maps';
    case map.MapType.apple:
      return 'Apple Maps';
    default:
      return amap.mapName;
  }
}

class LogoPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = colorWhite;
    var path = Path();
    path.lineTo(0, size.height / 5 - size.height);
    path.lineTo(size.width / 1.5, 40 - size.height);
    path.lineTo(size.width, size.height / 5 - size.height);
    path.lineTo(size.width, 0);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class SliderCustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
