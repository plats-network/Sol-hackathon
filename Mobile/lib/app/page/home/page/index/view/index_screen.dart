import 'dart:collection';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
import 'package:plat_app/app/page/home/page/index/model/index_reponse.dart';
import 'package:plat_app/app/page/home/page/index/model/trending_event_reponse.dart';
import 'package:plat_app/app/page/home/page/index/view/calendar_event.dart';
import 'package:plat_app/app/page/home/page/index/view/list_ongoing_event.dart';
import 'package:plat_app/app/page/home/page/index/view/ongoing_event_screen.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:like_button/like_button.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:table_calendar/table_calendar.dart';

class IndexScreen extends StatefulWidget {
  const IndexScreen({Key? key}) : super(key: key);

  @override
  State<IndexScreen> createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen>
    with TickerProviderStateMixin {
  double scrollPosition = 0.0;
  bool isPin = false;
  bool isLike = false;
  final IndexController indexController = Get.find();
  dynamic kEventSource;
  dynamic kEvents;

  @override
  // ScrollController scrollController = ScrollController();
  _scrollListener() {
    // scrollPosition = scrollController.position.pixels;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // scrollController.addListener(_scrollListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      indexController.fetchAllEvent();
      indexController.fetchTrendingEvent();
      indexController.fetchUpcomingEvent();
      indexController.fetchRegisteredEvent();
      indexController.fetchParticipatingEvent();
    });
    // indexController.fetchTask();

    // indexController.fetchTaskEvent();
    // indexController.fetchParticipatingEvent();

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        if (!indexController.isFetchingAllEvent()) {
          setState(() {
            kEventSource = {
              for (var event in indexController.allEvent.value.data?.data ?? [])
                DateTime(
                  int.parse(event.date.toString().split(" ")[0].split("-")[2]),
                  int.parse(event.date.toString().split(" ")[0].split("-")[1]),
                  int.parse(event.date.toString().split(" ")[0].split("-")[0]),
                ): List.generate(
                  1,
                  (index) => EventData(
                    id: event.id,
                    name: event.name,
                    bannerUrl: event.bannerUrl,
                    address: event.address,
                    date: event.date,
                  ),
                )
            };

            kEvents = LinkedHashMap<DateTime, List<EventData>>(
              equals: isSameDay,
              hashCode: getHashCode,
            )..addAll(kEventSource);
          });
        }
      });
    });
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!indexController.isFetchingAllEvent()) {
      setState(() {
        kEventSource = {
          for (var event in indexController.allEvent.value.data?.data ?? [])
            DateTime(
              int.parse(event.date.toString().split(" ")[0].split("-")[2]),
              int.parse(event.date.toString().split(" ")[0].split("-")[1]),
              int.parse(event.date.toString().split(" ")[0].split("-")[0]),
            ): List.generate(
                1,
                (index) => EventData(
                      id: event.id,
                      name: event.name,
                      bannerUrl: event.bannerUrl,
                      address: event.address,
                      date: event.date,
                    ))
        };

        kEvents = LinkedHashMap<DateTime, List<EventData>>(
          equals: isSameDay,
          hashCode: getHashCode,
        )..addAll(kEventSource);
      });
    }
    const colorizeColors = [
      Colors.blue,
      Colors.purple,
    ];

    return Obx(
      () => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage(getAssetImage(AssetImagePath.background_ticket)),
                fit: BoxFit.cover,
              ),
            ),
            child: Scaffold(
              backgroundColor: colorTransparent,
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(dimen40),
                child: AppBar(
                  centerTitle: false,
                  automaticallyImplyLeading: false,
                  elevation: 0.0,
                  leadingWidth: 0,
                  backgroundColor: colorTransparent,
                  titleSpacing: 15.0,
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.asset(
                          getAssetImage(AssetImagePath.plats),
                          fit: BoxFit.cover,
                          width: 30,
                        ),
                      ),
                      horizontalSpace10,
                      AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          ColorizeAnimatedText(
                            'PLATS',
                            textStyle: GoogleFonts.quicksand(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: colorBlack,
                            ),
                            colors: colorizeColors,
                          ),
                          ColorizeAnimatedText(
                            'All-in-one event platform',
                            textStyle: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: colorBlack,
                            ),
                            colors: colorizeColors,
                          ),
                          ColorizeAnimatedText(
                            'Sponsor pool for organizing events',
                            textStyle: GoogleFonts.quicksand(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: colorBlack,
                            ),
                            colors: colorizeColors,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //
              //scrollPosition >= 145
              //     ? AppBar(
              //         excludeHeaderSemantics: true,
              //         toolbarHeight: scrollPosition >= 145 ? 54 : 0,
              //         automaticallyImplyLeading: false,
              //         backgroundColor: Colors.transparent,
              //         // expandedHeight: 200,
              //         // stretch: true,
              //         // stretchTriggerOffset: 300,
              //         flexibleSpace:
              //             scrollPosition >= 145 ? headerFunc() : Container(),
              //       )
              //     : null,
              body: RefreshIndicator(
                displacement: dimen100,
                backgroundColor: colorWhite,
                color: colorPrimary,
                strokeWidth: dimen3,
                triggerMode: RefreshIndicatorTriggerMode.onEdge,
                onRefresh: () async {
                  indexController.fetchTrendingEvent();
                  indexController.fetchRegisteredEvent();
                  indexController.fetchUpcomingEvent();
                  indexController.fetchAllEvent();
                  indexController.fetchParticipatingEvent();

                  // indexController.fetchTask();
                  // indexController.fetchTaskEvent();
                },
                child: Stack(
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      // controller: scrollController,
                      slivers: [
                        // SliverPadding(
                        //   padding: const EdgeInsets.only(top: dimen30),
                        //   sliver: SliverToBoxAdapter(
                        //     child: Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         SizedBox(
                        //           height: 300,
                        //           width: MediaQuery.of(context).size.width,
                        //           child: const ListOngoingEvent(),
                        //         ),
                        //         Padding(
                        //           padding: const EdgeInsets.only(left: dimen20),
                        //           child: Text(
                        //             '${indexController.participatingEventTask.value.data?.data?.length} events ongoing.',
                        //             style: GoogleFonts.quicksand(
                        //               color: colorPrimary,
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.w600,
                        //             ),
                        //           ),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),

                        indexController.participatingEventTask.value.data?.data
                                        ?.isNotEmpty ==
                                    true &&
                                indexController.participatingEventTask.value
                                        .data?.data !=
                                    null
                            ? indexController.participatingEventTask.value.data
                                        ?.data?.length as int >
                                    1
                                ? SliverPadding(
                                    padding:
                                        const EdgeInsets.only(top: dimen20),
                                    sliver: SliverToBoxAdapter(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            // color: color00FA9A,
                                            height: 220,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: ListOngoingEvent(
                                              listOngoingEventResponse:
                                                  indexController
                                                          .participatingEventTask
                                                          .value
                                                          .data
                                                          ?.data ??
                                                      [],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: dimen20),
                                            child: Text(
                                              '${indexController.participatingEventTask.value.data?.data?.length} events ongoing.',
                                              style: GoogleFonts.quicksand(
                                                color: colorPrimary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : indexController.participatingEventTask.value
                                            .data?.data?.length ==
                                        1
                                    ? SliverPadding(
                                        padding: const EdgeInsets.only(
                                            left: dimen16,
                                            right: dimen16,
                                            top: dimen40),
                                        sliver: SliverToBoxAdapter(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      OnGoingEventScreen(
                                                          eventId: indexController
                                                                  .participatingEventTask
                                                                  .value
                                                                  .data
                                                                  ?.data?[0]
                                                                  .eventId ??
                                                              ''),
                                                ),
                                              );
                                            },
                                            child: Stack(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 200,
                                                  decoration: BoxDecoration(
                                                    color: colorBlack,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            dimen10),
                                                    boxShadow: const [
                                                      BoxShadow(
                                                        color: colorDCDCDC,
                                                        blurRadius: dimen4,
                                                        offset:
                                                            Offset(0, dimen2),
                                                      ),
                                                    ],
                                                    image: DecorationImage(
                                                      // colorFilter: ColorFilter.mode(
                                                      //   colorBlack.withOpacity(.5),
                                                      //   BlendMode.multiply,
                                                      // ),
                                                      image:
                                                          CachedNetworkImageProvider(
                                                        indexController
                                                                .participatingEventTask
                                                                .value
                                                                .data
                                                                ?.data?[0]
                                                                .bannerUrl ??
                                                            '',
                                                      ),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: dimen10,
                                                  left: dimen10,
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: dimen8,
                                                      vertical: dimen4,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: color30A1DB
                                                          .withOpacity(0.7),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              dimen4),
                                                    ),
                                                    child: Row(
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
                                                                  .idea),
                                                          fit: BoxFit.cover,
                                                          width: dimen10,
                                                          height: dimen10,
                                                          color: colorWhite,
                                                        ),
                                                        horizontalSpace4,
                                                        Text(
                                                          'Ongoing',
                                                          style: GoogleFonts
                                                              .quicksand(
                                                            color: colorWhite,
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
                                    : const SliverToBoxAdapter()
                            : const SliverToBoxAdapter(),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                              left: dimen16, top: dimen40),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              'Events Calendar',
                              style: GoogleFonts.quicksand(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                              left: dimen16, right: dimen16, top: dimen12),
                          sliver: SliverToBoxAdapter(
                            child: CalendarEventWidget(
                              eventData:
                                  indexController.allEvent.value.data?.data ??
                                      [],
                              kEvents: kEvents ?? [],
                            ),
                          ),
                        ),
                        indexController.registeredEvent.value.data?.data
                                        ?.isNotEmpty ==
                                    true &&
                                indexController
                                        .registeredEvent.value.data?.data !=
                                    null
                            ? SliverPadding(
                                padding: const EdgeInsets.only(
                                    left: dimen16, top: dimen40),
                                sliver: SliverToBoxAdapter(
                                  child: Text(
                                    'Registered Events',
                                    style: GoogleFonts.quicksand(
                                      color: colorBlack,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              )
                            : const SliverToBoxAdapter(),
                        indexController.registeredEvent.value.data?.data
                                        ?.isNotEmpty ==
                                    true &&
                                indexController
                                        .registeredEvent.value.data?.data !=
                                    null
                            ? SliverPadding(
                                padding: const EdgeInsets.only(
                                  // left: dimen16,
                                  // right: dimen16,
                                  top: dimen20,
                                ),
                                sliver: SliverToBoxAdapter(
                                  child: listRegisteredEvent(
                                    data: indexController
                                            .registeredEvent.value.data?.data ??
                                        [],
                                  ),
                                ),
                              )
                            : const SliverToBoxAdapter(),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                              left: dimen16, top: dimen40),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              'Trending Events',
                              style: GoogleFonts.quicksand(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding:
                              const EdgeInsets.only(left: dimen0, top: dimen12),
                          sliver: SliverToBoxAdapter(
                            child: SizedBox(
                              width: double.infinity,
                              height: dimen250,
                              child: listTrendingEvent(
                                data: indexController
                                        .trendingEvent.value.data?.data ??
                                    [],
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            left: dimen60,
                            right: dimen60,
                            top: dimen20,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: showAllButton(
                              onTap: () {
                                Get.toNamed(Routes.listTrendingEvent);
                              },
                            ),
                          ),
                        ),

                        SliverPadding(
                          padding: const EdgeInsets.only(
                            left: dimen16,
                            top: dimen40,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              'Upcoming',
                              style: GoogleFonts.quicksand(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            left: dimen16,
                            right: dimen16,
                            top: dimen20,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: listUpcomingEvent(
                              data: indexController
                                      .upcomingEvent.value.data?.data ??
                                  [],
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            left: dimen60,
                            right: dimen60,
                            top: dimen14,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: showAllButton(
                              onTap: () {
                                Get.toNamed(Routes.listUpcomingEvent);
                              },
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                              left: dimen16, top: dimen40),
                          sliver: SliverToBoxAdapter(
                            child: Text(
                              'Some other ideas',
                              style: GoogleFonts.quicksand(
                                color: colorBlack,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.only(
                            left: dimen16,
                            right: dimen16,
                            top: dimen20,
                          ),
                          sliver: SliverToBoxAdapter(
                            child: listIdeaEvent(
                              data: indexController.allEvent.value.data?.data ??
                                  [],
                            ),
                          ),
                        ),
                        const SliverPadding(
                          padding: EdgeInsets.only(top: dimen100),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          indexController.isFetchingAllEvent() ||
                  indexController.isFetchingTrendingEvent() ||
                  indexController.isFetchingUpcomingEvent() ||
                  indexController.isFetchingRegisteredEvent() ||
                  indexController.isFetchingParticipatingEvent()
              ? const FullScreenProgress()
              : Container()
        ],
      ),
    );
  }

  Widget showAllButton({
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: dimen10),
        width: 100,
        height: 35,
        decoration: BoxDecoration(
          border: Border.all(
            width: dimen1,
            color: color1DA5F2,
          ),
          borderRadius: BorderRadius.circular(dimen6),
        ),
        child: Center(
          child: Text(
            'Show all events',
            style: GoogleFonts.quicksand(
              color: color1DA5F2,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            maxLines: 2,
          ),
        ),
      ),
    );
  }

  Widget itemFunc({
    String? title,
    Color? gradientS,
    Color? gradientE,
    String? imageName,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: dimen30,
            height: dimen30,
            padding: const EdgeInsets.all(dimen6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: color0E4C88,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.3, 0.7],
                colors: [
                  gradientS as Color,
                  gradientE as Color,
                ],
              ),
            ),
            child: Image.asset(
              getAssetImage(imageName as String),
              fit: BoxFit.cover,
            ),
          ),
          horizontalSpace4,
          SizedBox(
            width: (MediaQuery.of(context).size.width - 40) * 0.25 - 45,
            child: Text(
              '$title',
              style: GoogleFonts.quicksand(
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemCategory({
    String? title,
    Color? gradientS,
    Color? gradientE,
    String? imageName,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: dimen45,
            height: dimen45,
            padding: const EdgeInsets.all(dimen10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: color0E4C88,
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: const [0.3, 0.7],
                colors: [
                  gradientS as Color,
                  gradientE as Color,
                ],
              ),
            ),
            child: Image.asset(
              getAssetImage(imageName as String),
              fit: BoxFit.cover,
              // color: colorWhite,
            ),
          ),
          horizontalSpace4,
          Text(
            '$title',
            style: GoogleFonts.quicksand(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemParticipatingEvent(Data data) {
    return Stack(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          height: 140,
          // color: color00FA9A,
        ),
        Positioned(
          bottom: 0,
          child: Container(
            width: MediaQuery.of(context).size.width - 40,
            height: 130,
            decoration: BoxDecoration(
              color: colorWhite,
              boxShadow: const [
                BoxShadow(
                  color: color9C9896,
                  blurRadius: dimen4,
                  offset: Offset(0, 2),
                ),
              ],
              borderRadius: BorderRadius.circular(dimen16),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 130,
              decoration: BoxDecoration(
                color: colorWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 1),
                    blurRadius: 5,
                    color: colorBlack.withOpacity(0.1),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                  horizontal: dimen16, vertical: dimen14),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                data.name ?? '',
                                style: const TextStyle(
                                  // color: colorWhite,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  // fontFamily: 'Termina',
                                ),
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              verticalSpace6,
                              Expanded(
                                child: Text(
                                  data.postBy ?? '',
                                  style: const TextStyle(
                                    color: colorB7BBCB,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                    // fontFamily: 'Termina',
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text(
                                  'Go to detail >',
                                  style: TextStyle(
                                    color: color1DA5F2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,

                                    // fontFamily: 'Termina',
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              verticalSpace2,
                            ],
                          ),
                        ),
                        horizontalSpace10,
                        AppCachedImage(
                          imageUrl: data.bannerUrl ?? '',
                          height: dimen100,
                          width: dimen100,
                          cornerRadius: dimen12,
                          backgroundColor: colorWhite,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            // width: 80,
            height: 20,
            decoration: BoxDecoration(
              color: colorWhite,
              boxShadow: const [
                BoxShadow(
                  color: color878998,
                  blurRadius: dimen4,
                  offset: Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(dimen4),
            ),
            child: Row(
              children: [
                Image.asset(
                  getAssetImage(
                    AssetImagePath.party,
                  ),
                  width: dimen20,
                  height: dimen20,
                ),
                horizontalSpace4,
                const Text(
                  'Happenning',
                  style: TextStyle(
                    color: colorPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    // fontFamily: 'Termina',
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget itemEvent({int? index, EventData? data}) {
    return Container(
      margin: const EdgeInsets.only(bottom: dimen0),
      width: MediaQuery.of(context).size.width,
      height: 190,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: dimen45,
                height: dimen60,
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(dimen12),
                  boxShadow: const [
                    BoxShadow(
                      color: colorDCDCDC,
                      blurRadius: dimen4,
                      offset: Offset(0, dimen2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      data?.date.toString().split('-')[0] ?? '',
                      style: GoogleFonts.quicksand(
                        color: colorBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${data?.date.toString().split('-')[1] ?? ''}/${data?.date.toString().split('-')[2].split(" ")[0].substring(2) ?? ''}',
                      style: GoogleFonts.quicksand(
                        color: color9C9C9C,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace10,
              const DottedLine(
                direction: Axis.vertical,
                lineLength: 120,
                lineThickness: 1.5,
                dashLength: 4.0,
                dashColor: colorE5E5E5,
                dashRadius: 40.0,
                dashGapLength: 12.0,
              )
            ],
          ),
          horizontalSpace16,
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: colorBlack,
                    borderRadius: BorderRadius.circular(dimen8),
                    boxShadow: const [
                      BoxShadow(
                        color: colorDCDCDC,
                        blurRadius: dimen4,
                        offset: Offset(0, dimen2),
                      ),
                    ],
                    image: DecorationImage(
                      // colorFilter: ColorFilter.mode(
                      //   colorBlack.withOpacity(.5),
                      //   BlendMode.multiply,
                      // ),
                      image: CachedNetworkImageProvider(
                        data?.bannerUrl ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 170,
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
                        data?.name ?? '',
                        style: GoogleFonts.quicksand(
                          color: colorWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          // fontStyle: FontStyle.italic,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      verticalSpace4,
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
                              data?.address ?? '',
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
                //   top: dimen6,
                //   right: dimen6,
                //   child: Container(
                //     // padding: const EdgeInsets.all(dimen2),
                //     width: 30,
                //     height: 30,
                //     decoration: BoxDecoration(
                //       color: colorDisabledButton.withOpacity(0.3),
                //       borderRadius: BorderRadius.circular(60),
                //     ),
                //     child: Align(
                //       alignment: Alignment.center,
                //       child: LikeButton(
                //         likeCountPadding: EdgeInsets.zero,
                //         onTap: (bool value) async {
                //           // setState(
                //           //   () {
                //           //     isLike = !isLike;
                //           //     eventTasks[index].like?.isLike = isLike;
                //           //     if (isLike == true) {
                //           //       indexController.fetchLikeOrPin(
                //           //           eventTasks[index].id as String, 'like');
                //           //     } else {
                //           //       indexController.fetchLikeOrPin(
                //           //           eventTasks[index].id as String,
                //           //           'unlike');
                //           //     }
                //           //   },
                //           // );
                //           return Future.value(!value);
                //         },
                //         size: 20,
                //         circleColor: const CircleColor(
                //             start: Colors.pink, end: Colors.pinkAccent),
                //         bubblesColor: const BubblesColor(
                //           dotPrimaryColor: Colors.red,
                //           dotSecondaryColor: Colors.redAccent,
                //         ),
                //         likeBuilder: (bool isLiked) {
                //           return const Icon(
                //             Icons.favorite,
                //             color:
                //                 // eventTasks[index].like?.isLike as bool
                //                 //     ? Colors.pink
                //                 //     :
                //                 colorE4E1E1,
                //             size: 18,
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget ideaEventItem(
      {required EventData task, double width = 0, int? index}) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(dimen8),
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
                  fontSize: 17,
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
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                child: Row(
                  children: [
                    Image.asset(
                      getAssetImage(AssetImagePath.party),
                      width: 12,
                      color: colorWhite,
                    ),
                    horizontalSpace4,
                    Text(
                      'FEATURED',
                      style: GoogleFonts.quicksand(
                        color: colorWhite,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              index == 0 || index == 1
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: colorFFB800.withOpacity(0.7)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 3),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      child: Row(
                        children: [
                          Image.asset(
                            getAssetImage(AssetImagePath.group),
                            width: 12,
                            color: colorWhite,
                          ),
                          horizontalSpace4,
                          Text(
                            'POPULAR',
                            style: GoogleFonts.quicksand(
                              color: colorWhite,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        )
      ],
    );
  }

  Widget listIdeaEvent({required List<EventData> data}) {
    return ListView.separated(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: data.length ?? 0,
      separatorBuilder: (context, index) => const SizedBox(
        height: 8,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.socialTaskDetail,
              arguments: {
                'task_id': data[index].id,
                'is_done': false,
              },
            );
          },
          child: ideaEventItem(
            task: data[index],
            index: index,
          ),
        );
      },
    );
  }

  Widget listTrendingEvent({required List<EventData> data}) {
    return GridView.builder(
      itemCount: min(9, data.length ?? 0),
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        // childAspectRatio: 0.35,
        mainAxisExtent: MediaQuery.of(context).size.width * 0.8,
        // mainAxisSpacing: dimen10,
        crossAxisSpacing: dimen10,
      ),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.socialTaskDetail,
              arguments: {
                'task_id': data[index].id,
                'is_done': false,
              },
            );
          },
          child: itemEventTrending(
            index: index,
            data: data[index],
          ),
        );
      },
    );
  }

  Widget listUpcomingEvent({required List<EventData> data}) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: min(3, data.length) ?? 0,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.socialTaskDetail,
              arguments: {
                'task_id': data[index].id,
                'is_done': false,
              },
            );
          },
          child: itemEvent(
            data: data[index],
          ),
        );
      },
    );
  }

  Widget listRegisteredEvent({required List<EventData> data}) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 190,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        scrollDirection: Axis.horizontal,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: min(3, data.length) ?? 0,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.toNamed(
                Routes.socialTaskDetail,
                arguments: {
                  'task_id': data[index].id,
                  'is_done': false,
                },
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                bottom: dimen0,
                right: dimen16,
                left: index == 0 ? dimen16 : 0,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 190,
              child: Expanded(
                child: Stack(
                  children: [
                    Container(
                      height: 190,
                      width: MediaQuery.of(context).size.width * 0.8,
                      decoration: BoxDecoration(
                        color: colorBlack,
                        borderRadius: BorderRadius.circular(dimen8),
                        boxShadow: const [
                          BoxShadow(
                            color: colorDCDCDC,
                            blurRadius: dimen4,
                            offset: Offset(0, dimen2),
                          ),
                        ],
                        image: DecorationImage(
                          // colorFilter: ColorFilter.mode(
                          //   colorBlack.withOpacity(.5),
                          //   BlendMode.multiply,
                          // ),
                          image: CachedNetworkImageProvider(
                            data[index].bannerUrl ?? '',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      height: 190,
                      width: MediaQuery.of(context).size.width * 0.8,
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
                            data[index].name ?? '',
                            style: GoogleFonts.quicksand(
                              color: colorWhite,
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              // fontStyle: FontStyle.italic,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          verticalSpace6,
                          Text(
                            data[index].date ?? '',
                            style: GoogleFonts.quicksand(
                              color: colorWhite,
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              // fontStyle: FontStyle.italic,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          verticalSpace4,
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
                                  data[index].address ?? '',
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
                    Positioned(
                      top: dimen0,
                      right: dimen0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: dimen10,
                          vertical: dimen4,
                        ),
                        // width: 30,
                        // height: 30,
                        decoration: const BoxDecoration(
                          color: colorPrimary,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(dimen8),
                            bottomLeft: Radius.circular(dimen8),
                          ),
                        ),
                        child: CountDownText(
                          due: DateTime.parse("2023-07-20 12:00:00"),
                          // due: DateTime.parse(DateFormat('yyyy-MM-dd HH:mm:ss')
                          //     .format(DateFormat('dd-MM-yyyy HH:mm:ss')
                          //         .parse(data[index].date ?? ''))),
                          finishedText: "Ongoing",
                          showLabel: true,
                          longDateName: true,
                          daysTextLong: "d ",
                          hoursTextLong: "h ",
                          minutesTextLong: "m ",
                          secondsTextLong: "s",
                          style: GoogleFonts.quicksand(
                            color: colorWhite,
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
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
      ),
    );
  }

  Widget itemEventTrending({int? index, EventData? data}) {
    return Container(
      margin: const EdgeInsets.only(left: dimen20, right: dimen4),
      decoration: BoxDecoration(
        color: colorTransparent,
        borderRadius: BorderRadius.circular(dimen6),
      ),
      child: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: colorE8F2FC,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(dimen4),
                bottomLeft: Radius.circular(dimen4),
              ),
            ),
            width: dimen40,
            height: dimen75,
            child: Center(
              child: Text(
                '${(index as int) + 1}',
                style: GoogleFonts.quicksand(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Container(
            width: dimen75,
            height: dimen75,
            decoration: BoxDecoration(
              color: colorBlack,
              borderRadius: BorderRadius.circular(dimen4),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(dimen4),
              child: CachedNetworkImage(
                imageUrl: data?.bannerUrl ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  padding: const EdgeInsets.all(dimen20),
                  width: dimen30,
                  height: dimen30,
                  child: Image.asset(
                    'assets/images/loading.gif',
                    width: dimen30,
                    height: dimen30,
                  ),
                ),
                errorWidget: (context, url, error) => GestureDetector(
                  onTap: () {
                    // setAvatar();
                  },
                  child: const Icon(
                    Icons.error_outline,
                    size: dimen20,
                    color: colorWhite,
                  ),
                ),
              ),
            ),
          ),
          // horizontalSpace10,
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: dimen10),
              decoration: const BoxDecoration(
                color: colorTransparent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(dimen6),
                  bottomRight: Radius.circular(dimen6),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data?.name ?? '',
                    style: GoogleFonts.quicksand(
                      color: colorBlack,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,

                      // fontFamily: 'Termina',
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  verticalSpace3,
                  Text(
                    DateFormat('EE, dd MMMM yyyy')
                        .format(
                          DateFormat('dd-MM-yyyy HH:mm:ss').parse(
                            '${data?.date}',
                          ),
                        )
                        .toString(),
                    style: GoogleFonts.quicksand(
                      color: color898989,
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  verticalSpace3,
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
                          data?.address ?? '',
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
          ),
        ],
      ),
    );
  }
}

class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    int curveHeight = 40;
    Offset controlPoint = Offset(size.width / 2, size.height + curveHeight);
    Offset endPoint = Offset(size.width, size.height - curveHeight);

    Path path = Path()
      ..lineTo(0, size.height - curveHeight)
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
