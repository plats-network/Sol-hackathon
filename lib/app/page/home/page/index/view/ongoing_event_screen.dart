import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_count_down/date_count_down.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
import 'package:plat_app/app/page/home/page/index/model/ongoing_event_reponse.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:tab_container/tab_container.dart';
import 'package:flutter_html/flutter_html.dart';

class OnGoingEventScreen extends StatefulWidget {
  final String? eventId;
  const OnGoingEventScreen({super.key, this.eventId});

  @override
  State<OnGoingEventScreen> createState() => _OnGoingEventScreenState();
}

class _OnGoingEventScreenState extends State<OnGoingEventScreen> {
  final IndexController indexController = Get.find();

  @override
  void initState() {
    super.initState();
    indexController.fetchOngoingEvent(widget.eventId ?? '');
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: colorWhite,
            body: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    slivers: [
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
                                      indexController.ongoingEvent.value.data
                                              ?.data?.bannerUrl ??
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
                        child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: dimen16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              verticalSpace10,
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: dimen8,
                                  vertical: dimen4,
                                ),
                                width: dimen80,
                                decoration: BoxDecoration(
                                  color: color30A1DB.withOpacity(0.7),
                                  borderRadius: BorderRadius.circular(dimen4),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      getAssetImage(AssetImagePath.idea),
                                      fit: BoxFit.cover,
                                      width: dimen10,
                                      height: dimen10,
                                      color: colorWhite,
                                    ),
                                    horizontalSpace4,
                                    Text(
                                      'Ongoing',
                                      style: GoogleFonts.quicksand(
                                        color: colorWhite,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              verticalSpace10,
                              Text(
                                indexController
                                        .ongoingEvent.value.data?.data?.name ??
                                    '',
                                style: GoogleFonts.quicksand(
                                  color: colorBlack,
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              verticalSpace10,
                              Html(
                                data: indexController
                                        .ongoingEvent.value.data?.data?.desc ??
                                    '',
                                style: {
                                  'body': Style(
                                    fontFamily:
                                        GoogleFonts.quicksand().fontFamily,
                                    color: colorBlack,
                                    fontSize: const FontSize(dimen14),
                                    wordSpacing: 1.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                },
                              ),
                              // Text(indexController
                              //           .ongoingEvent.value.data?.data?.desc ??
                              //       '',
                              //   style: GoogleFonts.quicksand(
                              //     color: colorBlack,
                              //     fontSize: 14,
                              //     wordSpacing: dimen1,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      // SliverPadding(
                      //   padding: const EdgeInsets.only(
                      //     top: dimen30,
                      //     bottom: dimen30,
                      //     left: dimen16,
                      //     right: dimen16,
                      //   ),
                      //   sliver: SliverToBoxAdapter(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         Text(
                      //           'Layout diagram of booths',
                      //           style: GoogleFonts.quicksand(
                      //             color: colorBlack,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.w600,
                      //           ),
                      //         ),
                      //         verticalSpace10,
                      //         Container(
                      //           height: dimen190,
                      //           decoration: BoxDecoration(
                      //             color: colorBlack,
                      //             borderRadius: BorderRadius.circular(dimen6),
                      //             boxShadow: const [
                      //               BoxShadow(
                      //                 color: colorDCDCDC,
                      //                 blurRadius: dimen4,
                      //                 offset: Offset(0, dimen2),
                      //               ),
                      //             ],
                      //             image: const DecorationImage(
                      //               // colorFilter: ColorFilter.mode(
                      //               //   colorBlack.withOpacity(.5),
                      //               //   BlendMode.multiply,
                      //               // ),
                      //               image: CachedNetworkImageProvider(
                      //                 'https://media.koelnmesse.io/aps2021/redaktionell/aps/img/bilder-1200x675/hallenplan_neu_1200x675_m24_full_m36_1025.jpg',
                      //               ),
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      SliverPadding(
                        padding: const EdgeInsets.only(
                          top: dimen30,
                          bottom: dimen30,
                          left: dimen16,
                          right: dimen16,
                        ),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Check-in Tasks',
                                style: GoogleFonts.quicksand(
                                  color: colorBlack,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              verticalSpace10,
                              SizedBox(
                                height: 450,
                                width: MediaQuery.of(context).size.width,
                                child: TabContainer(
                                  color: colorE8F2FC,
                                  tabs: const [
                                    'Sessions',
                                    'Booths',
                                  ],
                                  tabExtent: 40,
                                  selectedTextStyle: GoogleFonts.quicksand(
                                    color: colorPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  unselectedTextStyle: GoogleFonts.quicksand(
                                    color: colorBlack,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  children: [
                                    indexController
                                                    .ongoingEvent
                                                    .value
                                                    .data
                                                    ?.data
                                                    ?.listSessions
                                                    ?.isNotEmpty ==
                                                true &&
                                            indexController.ongoingEvent.value
                                                    .data?.data?.listSessions !=
                                                null
                                        ? listSessions(
                                            listSessions: indexController
                                                    .ongoingEvent
                                                    .value
                                                    .data
                                                    ?.data
                                                    ?.listSessions ??
                                                [])
                                        : noInfoWidget(title: 'No Session'),
                                    indexController
                                                    .ongoingEvent
                                                    .value
                                                    .data
                                                    ?.data
                                                    ?.listBooths
                                                    ?.isNotEmpty ==
                                                true &&
                                            indexController.ongoingEvent.value
                                                    .data?.data?.listBooths !=
                                                null
                                        ? listBooths(
                                            listBooths: indexController
                                                    .ongoingEvent
                                                    .value
                                                    .data
                                                    ?.data
                                                    ?.listBooths ??
                                                [])
                                        : noInfoWidget(title: 'No Booth'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      indexController.ongoingEvent.value.data?.data
                                      ?.listSessionsGame !=
                                  null ||
                              indexController.ongoingEvent.value.data?.data
                                      ?.listBoothsGame !=
                                  null
                          ? SliverPadding(
                              padding: const EdgeInsets.only(
                                top: dimen30,
                                bottom: dimen30,
                                left: dimen16,
                                right: dimen16,
                              ),
                              sliver: SliverToBoxAdapter(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '#MiniGame',
                                      style: GoogleFonts.quicksand(
                                        color: colorBlack,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    verticalSpace10,
                                    listMiniGame(
                                      indexController.ongoingEvent.value.data
                                              ?.data?.listSessionsGame ??
                                          [],
                                    ),
                                    listMiniGame(
                                      indexController.ongoingEvent.value.data
                                              ?.data?.listBoothsGame ??
                                          [],
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SliverToBoxAdapter(),
                    ],
                  ),
                ),
                Positioned(
                  // top: Platform.isIOS && MediaQuery.of(context).size.height >= 700
                  //     ? dimen50
                  //     : dimen20,
                  left: dimen16,
                  child: SafeArea(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, Routes.home, (_) => false);
                      },
                      child: Image.asset(
                        getAssetImage(AssetImagePath.back_button),
                        width: dimen48,
                        height: dimen48,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          indexController.isFetchingOngoingEvent()
              ? const FullScreenProgress()
              : Container()
        ],
      ),
    );
  }

  void showMoreSessionOrBooth(
      {String? name,
      String? decription,
      String? success,
      List<dynamic>? jobs}) {
    showBarModalBottomSheet(
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
                  ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: jobs?.length ?? 0,
                    physics: const AlwaysScrollableScrollPhysics(),
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
                              margin: const EdgeInsets.only(top: dimen2),
                              decoration: BoxDecoration(
                                color: jobs?[index].flag == true
                                    ? color27AE60
                                    : colorB7BBCB,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: dimen0,
                                  color: colorB7BBCB,
                                ),
                              ),
                              child: jobs?[index].flag == true
                                  ? Image(
                                      image: AssetImage(
                                        getAssetImage(AssetImagePath.check),
                                      ),
                                      width: dimen16,
                                      height: dimen16,
                                    )
                                  : const SizedBox(),
                            ),
                            horizontalSpace12,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    jobs?[index].name ?? '',
                                    style: GoogleFonts.quicksand(
                                      color: jobs?[index].flag == true
                                          ? colorBlack
                                          : colorB7BBCB,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    jobs?[index].desc ?? '',
                                    style: GoogleFonts.quicksand(
                                      color: jobs?[index].flag == true
                                          ? colorBlack
                                          : colorB7BBCB,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
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
                    getAssetImage(AssetImagePath.clear),
                  ),
                  width: dimen26,
                  height: dimen26,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget listSessions({
    List<Sessions>? listSessions,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: dimen20),
      child: Column(
        children: [
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: min(5, listSessions?.length ?? 0),
            physics: const NeverScrollableScrollPhysics(),
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
                      margin: const EdgeInsets.only(top: dimen2),
                      decoration: BoxDecoration(
                        color: listSessions?[index].flag == true
                            ? color27AE60
                            : colorB7BBCB,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: dimen0,
                          color: colorB7BBCB,
                        ),
                      ),
                      child: listSessions?[index].flag == true
                          ? Image(
                              image: AssetImage(
                                getAssetImage(AssetImagePath.check),
                              ),
                              width: dimen16,
                              height: dimen16,
                            )
                          : const SizedBox(),
                    ),
                    horizontalSpace12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listSessions?[index].name ?? '',
                            style: GoogleFonts.quicksand(
                              color: listSessions?[index].flag == true
                                  ? colorBlack
                                  : colorB7BBCB,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            listSessions?[index].desc ?? '',
                            style: GoogleFonts.quicksand(
                              color: listSessions?[index].flag == true
                                  ? colorBlack
                                  : colorB7BBCB,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Spacer(),
          listSessions?.isNotEmpty == true &&
                  listSessions != null &&
                  listSessions.length > 5
              ? GestureDetector(
                  onTap: () {
                    showMoreSessionOrBooth(
                      name: 'Sessions',
                      decription:
                          'In order to have a chance to receive valuable gifts, complete the check-in mission.',
                      success: '',
                      jobs: listSessions ?? [],
                    );
                  },
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(dimen4),
                          color: colorPrimary),
                      padding: const EdgeInsets.symmetric(
                        horizontal: dimen18,
                        vertical: dimen7,
                      ),
                      child: Text(
                        'Show All',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          color: colorWhite,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          verticalSpace10,
        ],
      ),
    );
  }

  Widget listBooths({
    List<Booths>? listBooths,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: dimen20),
      child: Column(
        children: [
          ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: min(5, listBooths?.length ?? 0),
            physics: const NeverScrollableScrollPhysics(),
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
                      margin: const EdgeInsets.only(top: dimen2),
                      decoration: BoxDecoration(
                        color: listBooths?[index].flag == true
                            ? color27AE60
                            : colorB7BBCB,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: dimen0,
                          color: colorB7BBCB,
                        ),
                      ),
                      child: listBooths?[index].flag == true
                          ? Image(
                              image: AssetImage(
                                getAssetImage(AssetImagePath.check),
                              ),
                              width: dimen16,
                              height: dimen16,
                            )
                          : const SizedBox(),
                    ),
                    horizontalSpace12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            listBooths?[index].name ?? '',
                            style: GoogleFonts.quicksand(
                              color: listBooths?[index].flag == true
                                  ? colorBlack
                                  : colorB7BBCB,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            listBooths?[index].desc ?? '',
                            style: GoogleFonts.quicksand(
                              color: listBooths?[index].flag == true
                                  ? colorBlack
                                  : colorB7BBCB,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const Spacer(),
          listBooths?.isNotEmpty == true &&
                  listBooths != null &&
                  listBooths.length > 5
              ? GestureDetector(
                  onTap: () {
                    showMoreSessionOrBooth(
                      name: 'Booths',
                      decription:
                          'In order to have a chance to receive valuable gifts, complete the check-in mission.',
                      success: '',
                      jobs: listBooths ?? [],
                    );
                  },
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          // border: Border.all(
                          //   width: dimen1,
                          //   color: colorA2CCF3,
                          // ),
                          borderRadius: BorderRadius.circular(dimen4),
                          color: colorPrimary),
                      padding: const EdgeInsets.symmetric(
                        horizontal: dimen18,
                        vertical: dimen7,
                      ),
                      child: Text(
                        'Show All',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          color: colorWhite,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
          verticalSpace10,
        ],
      ),
    );
  }

  Widget listMiniGame(List<dynamic> listGame) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: listGame.length ?? 0,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: dimen10),
          child: Row(
            children: [
              Container(
                width: dimen35,
                height: dimen200,
                padding: const EdgeInsets.symmetric(vertical: dimen10),
                decoration: const BoxDecoration(
                  color: colorBlack,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(4),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: RotatedBox(
                    quarterTurns: -1,
                    child: CountDownText(
                      due: DateTime.parse(
                        DateFormat('yyyy-MM-dd HH:mm').format(
                          DateFormat('dd-MM-yyyy HH:mm').parse(
                            listGame[index].prizeAt ?? '',
                          ),
                        ),
                      ),
                      finishedText: "Ongoing",
                      showLabel: true,
                      longDateName: true,
                      daysTextLong: "d ",
                      hoursTextLong: "h ",
                      minutesTextLong: "m ",
                      secondsTextLong: "s",
                      style: GoogleFonts.quicksand(
                        color: colorWhite,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              horizontalSpace4,
              Expanded(
                child: Container(
                  height: dimen200,
                  padding: const EdgeInsets.all(dimen16),
                  decoration: const BoxDecoration(
                    color: color00FA9A,
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          colorFFC006,
                          colorf8b200,
                        ]),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(4),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        listGame[index].name ?? '',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorBlack,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      verticalSpace10,
                      Text(
                        listGame[index].note ?? '',
                        style: GoogleFonts.quicksand(
                          color: colorWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Meet requirement: ',
                              style: GoogleFonts.quicksand(
                                color: colorWhite,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text:
                                  'Complete checkin of Session/Booths in the event.',
                              style: GoogleFonts.quicksand(
                                color: colorWhite,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      listGame[index].codes != null
                          ? SizedBox(
                              height: 30,
                              child: ListView.separated(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: listGame[index].codes?.length ?? 0,
                                separatorBuilder: (context, index) {
                                  return horizontalSpace8;
                                },
                                itemBuilder: (ctx, i) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: colorWhite,
                                        borderRadius:
                                            BorderRadius.circular(dimen4)),
                                    width: 80,
                                    height: 30,
                                    child: Center(
                                      child: Text(
                                        '${listGame[index].codes?[i]}' ?? '',
                                        style: GoogleFonts.quicksand(
                                          color: colorBlack,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  color: colorWhite,
                                  borderRadius: BorderRadius.circular(dimen4)),
                              width: 80,
                              height: 30,
                              child: Center(
                                child: Text(
                                  'XXXXXX',
                                  style: GoogleFonts.quicksand(
                                    color: colorBlack,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget noInfoWidget({String? title}) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Image(
              image: AssetImage(
                getAssetImage(AssetImagePath.no_info),
              ),
              width: MediaQuery.of(context).size.width * 0.65,
            ),
          ),
          Text(
            title ?? '',
            style: GoogleFonts.quicksand(
              color: colorBlack,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace4,
          // Text(
          //   'You have no notifications right now.\nCome back later',
          //   style: GoogleFonts.quicksand(
          //     color: color4E5260,
          //     fontSize: 14,
          //     fontWeight: FontWeight.w500,
          //   ),
          //   textAlign: TextAlign.center,
          // ),
        ],
      ),
    );
  }
}

class LogoPainter extends CustomPainter {
  LogoPainter();
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color171716.withOpacity(0.5);
    var path = Path();
    path.lineTo(0, size.height - size.height / 5);
    path.lineTo(size.width / 1.2, size.height - 40);
    path.lineTo(size.width, size.height - size.height / 5);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class LogoPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color0E4B88;
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
