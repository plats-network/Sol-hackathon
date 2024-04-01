import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plat_app/app/page/home/children/notification/controller/notification_controller.dart';
import 'package:plat_app/app/page/home/children/task_perform/controller/task_perform_controller.dart';
import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
import 'package:plat_app/app/page/home/page/index/model/trending_event_reponse.dart';
import 'package:plat_app/app/page/home/page/setting/controller/setting_controller.dart';
import 'package:plat_app/app/widgets/animations/slide_animation.dart';
import 'package:plat_app/app/widgets/shared_preferences.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/controllers/language/language_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTabPage extends StatefulWidget {
  const HomeTabPage({Key? key}) : super(key: key);

  @override
  State<HomeTabPage> createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage>
    with TickerProviderStateMixin {
  final LanguageController languageController = Get.find();
  final AuthController authController = Get.find();
  final HomeTabController homeTabController = Get.find();
  final NotificationController notificationController = Get.find();
  final TaskPerformController taskPerformController = Get.find();
  final SettingController settingController = Get.find();
  TextEditingController searchController = TextEditingController();
  bool isShowResult = false;
  List<String> historySearch = [];

  @override
  void initState() {
    if (homeTabController.isHomeInit.value != true) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
      searchController.addListener(() {
        setState(() {});
      });
    }
    getStringList().then((value) {
      setState(() {
        historySearch = value;
      });
    }).catchError((error) {});
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: () async => false,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(getAssetImage(AssetImagePath.background_ticket)),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                SafeArea(
                  child: Scaffold(
                    backgroundColor: colorTransparent,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(60),
                      child: AppBar(
                        elevation: 0,
                        backgroundColor: colorTransparent,
                        title: Text(
                          'Search',
                          style: GoogleFonts.quicksand(
                            fontSize: 20,
                            color: color0E4C88,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        centerTitle: false,
                        // bottom: PreferredSize(
                        //   preferredSize: const Size.fromHeight(40),
                        //   child: Container(
                        //       // color: color0E4B88,
                        //       color: colorWhite,
                        //       child: tabBar),
                        // ),
                      ),
                    ),
                    body: GestureDetector(
                      onTap: () {
                        Get.focusScope?.unfocus();
                      },
                      child: Container(
                        padding:
                            const EdgeInsets.symmetric(horizontal: dimen16),
                        height: MediaQuery.of(context).size.height,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'To search for events here.',
                                style: GoogleFonts.quicksand(
                                  color: color878998,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                                textAlign: TextAlign.left,
                                // overflow: TextOverflow.ellipsis,
                              ),
                              verticalSpace30,
                              Container(
                                decoration: BoxDecoration(
                                  // color: colorWhite,
                                  boxShadow: [
                                    BoxShadow(
                                        color: color878998.withOpacity(0.1),
                                        blurRadius: dimen5,
                                        offset: const Offset(0, 2)),
                                  ],
                                ),
                                child: _inputComment(),
                              ),
                              verticalSpace6,
                              // Row(
                              //   children: [
                              //     Container(
                              //       decoration: BoxDecoration(
                              //         color: colorWhite,
                              //         borderRadius: BorderRadius.circular(dimen4),
                              //         border:
                              //             Border.all(width: dimen1, color: color30A1DB),
                              //       ),
                              //       padding: const EdgeInsets.symmetric(
                              //         horizontal: dimen10,
                              //         vertical: dimen5,
                              //       ),
                              //       child: Text(
                              //         'Dates',
                              //         style: GoogleFonts.quicksand(
                              //           fontSize: 14,
                              //           color: color30A1DB,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       ),
                              //     ),
                              //     horizontalSpace10,
                              //     Container(
                              //       decoration: BoxDecoration(
                              //         color: colorWhite,
                              //         borderRadius: BorderRadius.circular(dimen4),
                              //         border:
                              //             Border.all(width: dimen1, color: color30A1DB),
                              //       ),
                              //       padding: const EdgeInsets.symmetric(
                              //         horizontal: dimen10,
                              //         vertical: dimen5,
                              //       ),
                              //       child: Text(
                              //         'Location',
                              //         style: GoogleFonts.quicksand(
                              //           fontSize: 14,
                              //           color: color30A1DB,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       ),
                              //     ),
                              //     horizontalSpace10,
                              //     Container(
                              //       decoration: BoxDecoration(
                              //         color: colorWhite,
                              //         borderRadius: BorderRadius.circular(dimen4),
                              //         border:
                              //             Border.all(width: dimen1, color: color30A1DB),
                              //       ),
                              //       padding: const EdgeInsets.symmetric(
                              //         horizontal: dimen10,
                              //         vertical: dimen5,
                              //       ),
                              //       child: Text(
                              //         'Type',
                              //         style: GoogleFonts.quicksand(
                              //           fontSize: 14,
                              //           color: color30A1DB,
                              //           fontWeight: FontWeight.w500,
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              verticalSpace30,
                              isShowResult
                                  ? Text(
                                      'Result (${homeTabController.eventData.value.data?.data?.length})',
                                      style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        color: colorBlack,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Recent searches',
                                          style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            color: colorBlack,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        horizontalSpace10,
                                        const Expanded(
                                          child: Divider(
                                            indent: 0,
                                            endIndent: 0,
                                            thickness: 0.5,
                                          ),
                                        ),
                                      ],
                                    ),
                              verticalSpace10,
                              isShowResult
                                  ? homeTabController.eventData.value.data?.data
                                                  ?.isEmpty ==
                                              true ||
                                          homeTabController
                                                  .eventData.value.data?.data ==
                                              null
                                      ? Center(
                                          child: Text(
                                            'No Result',
                                            style: GoogleFonts.quicksand(
                                              color: colorBlack,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        )
                                      : ListView.separated(
                                          itemBuilder: (context, index) {
                                            return SlideAnimation(
                                              intervalStart: 0.4,
                                              begin: const Offset(0, 30),
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                  bottom: dimen16,
                                                ),
                                                decoration: const BoxDecoration(
                                                  color: colorWhite,
                                                  borderRadius: border8,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: colorE4E1E1,
                                                      offset: Offset(0, dimen4),
                                                      blurRadius: dimen24,
                                                    ),
                                                  ],
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                child: Material(
                                                  color: colorWhite,
                                                  child: InkWell(
                                                    borderRadius: border8,
                                                    onTap: () => [
                                                      Get.toNamed(
                                                          Routes
                                                              .socialTaskDetail,
                                                          arguments: {
                                                            'task_id':
                                                                homeTabController
                                                                    .eventData
                                                                    .value
                                                                    .data
                                                                    ?.data?[
                                                                        index]
                                                                    .id,
                                                            'is_done': false,
                                                          })
                                                    ],
                                                    child: eventItem(
                                                      task: homeTabController
                                                              .eventData
                                                              .value
                                                              .data
                                                              ?.data?[index]
                                                          as EventData,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                  // height: 8,
                                                  ),
                                          itemCount: homeTabController.eventData
                                                  .value.data?.data?.length ??
                                              0,
                                        )
                                  : historySearch.isEmpty
                                      ? SizedBox(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                child: Image(
                                                  image: AssetImage(
                                                    getAssetImage(
                                                        AssetImagePath.history),
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.45,
                                                ),
                                              ),
                                              Text(
                                                'No Result',
                                                style: GoogleFonts.quicksand(
                                                  color: colorBlack,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              verticalSpace4,
                                              Text(
                                                'No search history yet.',
                                                style: GoogleFonts.quicksand(
                                                  color: color4E5260,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Column(
                                          children: [
                                            ListView.separated(
                                              shrinkWrap: true,
                                              padding: const EdgeInsets.only(
                                                  bottom: dimen24),
                                              itemCount: min(
                                                  8, historySearch.length ?? 0),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                height: dimen10,
                                              ),
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      searchController.text =
                                                          historySearch[index];
                                                    });
                                                  },
                                                  child: Container(
                                                    color: colorTransparent,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      vertical: dimen10,
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: dimen20,
                                                          height: dimen20,
                                                          child: Image(
                                                            image: AssetImage(
                                                              getAssetImage(
                                                                  AssetImagePath
                                                                      .history_icon),
                                                            ),
                                                            color: color878998,
                                                          ),
                                                        ),
                                                        horizontalSpace10,
                                                        Text(
                                                          historySearch[index],
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            color: colorBlack,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        SizedBox(
                                                          width: dimen20,
                                                          height: dimen20,
                                                          child: Image(
                                                            image: AssetImage(
                                                              getAssetImage(
                                                                  AssetImagePath
                                                                      .arrow_right),
                                                            ),
                                                            color: color878998,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                saveToRecentSearches(
                                                    isCleanData: true);
                                                setState(() {
                                                  getStringList().then((value) {
                                                    setState(() {
                                                      historySearch = value;
                                                    });
                                                  }).catchError((error) {});
                                                });
                                              },
                                              child: Text(
                                                'Clear all recent searches.',
                                                style: GoogleFonts.quicksand(
                                                  color: colorPrimary,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                              verticalSpace60,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                homeTabController.isSearchLoading()
                    ? const FullScreenProgress()
                    : Container(),
              ],
            ),
          ),
        ));
  }

  Widget _inputComment() {
    return TextFormField(
      controller: searchController,
      maxLines: null,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (value) {
        setState(() {
          homeTabController.fetchSearch(searchController.text.trim());
          saveToRecentSearches(searchValue: searchController.text);
          isShowResult = true;
          getStringList().then((value) {
            setState(() {
              historySearch = value;
            });
          }).catchError((error) {});
        });
      },
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(dimen14),
          child: Image.asset(
            getAssetImage(AssetImagePath.search_icon_line),
            color: color4E4E4E,
            width: dimen23,
            height: dimen23,
          ),
        ),
        suffixIcon: searchController.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  searchController.clear();
                  homeTabController.eventData.value.data?.data = [];
                  setState(() {
                    isShowResult = false;
                  });
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
          top: dimen12,
          bottom: dimen12,
          left: dimen15,
          right: dimen15,
        ),
        counter: const SizedBox(),
        hintStyle: GoogleFonts.quicksand(
          fontSize: dimen13,
          color: color4E5260,
        ),
        hintText: "Search for event.",
        fillColor: colorWhite,
        filled: true,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: colorWhite,
            width: 0,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: colorWhite,
            width: 0,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            color: colorWhite,
            width: 0,
          ),
        ),
      ),
    );
  }



  Widget eventItem({required EventData task, double width = 0}) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              // colorFilter: ColorFilter.mode(
              //   colorBlack.withOpacity(.5),
              //   BlendMode.multiply,
              // ),
              image: CachedNetworkImageProvider(
                task.bannerUrl ?? '',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: dimen200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dimen8),
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(0, 0, 0, 0),
                Color(0x00000000),
                Color.fromARGB(179, 0, 0, 0),
                Color.fromARGB(235, 0, 0, 0),
              ],
            ),
          ),
        ),
        Positioned(
          left: dimen10,
          bottom: dimen10,
          right: dimen20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.name.toString(),
                style: GoogleFonts.quicksand(
                  color: colorWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              verticalSpace8,
              Text(
                DateFormat('EEEE, dd MMMM yyyy')
                    .format(
                      DateFormat('dd-MM-yyyy HH:mm:ss').parse(
                        '${task.date}',
                      ),
                    )
                    .toString(),
                style: GoogleFonts.quicksand(
                  color: colorWhite,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  // fontStyle: FontStyle.italic,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              verticalSpace2,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    getAssetImage(AssetImagePath.location_pin),
                    fit: BoxFit.cover,
                    width: dimen10,
                    height: dimen10,
                    color: color30A1DB,
                  ),
                  horizontalSpace2,
                  Expanded(
                    child: Text(
                      task.address ?? '',
                      style: GoogleFonts.quicksand(
                        color: color30A1DB,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Positioned(
        //   top: dimen10,
        //   right: dimen10,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: colorDisabledButton.withOpacity(0.3),
        //       shape: BoxShape.circle,
        //     ),
        //     padding: const EdgeInsets.all(dimen3),
        //     child: LikeButton(
        //       isLiked: widget.task.pin?.isPin,
        //       likeCountPadding: EdgeInsets.zero,
        //       onTap: (bool value) async {
        //         setState(
        //           () {
        //             isPin = !isPin;
        //             widget.task.pin?.isPin = isPin;
        //             if (isPin == true) {
        //               indexController.fetchLikeOrPin(
        //                   widget.task.id as String, 'pin');
        //             } else {
        //               indexController.fetchLikeOrPin(
        //                   widget.task.id as String, 'unpin');
        //             }
        //           },
        //         );
        //         return Future.value(!value);
        //       },
        //       size: 20,
        //       circleColor:
        //           const CircleColor(start: Colors.pink, end: Colors.pinkAccent),
        //       bubblesColor: const BubblesColor(
        //         dotPrimaryColor: Colors.red,
        //         dotSecondaryColor: Colors.redAccent,
        //       ),
        //       likeBuilder: (bool isLiked) {
        //         return Icon(
        //           Icons.favorite,
        //           color: widget.task.pin?.isPin as bool || isPin
        //               ? Colors.pink
        //               : colorWhite,
        //           size: 20,
        //         );
        //       },
        //     ),
        //   ),
        // ),
        Positioned(
          top: dimen10,
          left: dimen10,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: color1DA5F2.withOpacity(0.7)),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  'Free on Plats',
                  style: GoogleFonts.quicksand(
                    color: colorWhite,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
