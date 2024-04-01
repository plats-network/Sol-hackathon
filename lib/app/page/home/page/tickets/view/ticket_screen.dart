import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plat_app/app/page/home/page/tickets/controller/ticket_controller.dart';
import 'package:plat_app/app/page/home/page/tickets/model/ticket_reponse.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends StatefulWidget {
  final bool isBack;
  const TicketPage({Key? key, this.isBack = true}) : super(key: key);

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> with TickerProviderStateMixin {
  final TicketController ticketController = Get.find();
  // late TabController tabController;
  // final menuItemList = ['Upcoming', 'Past'];

  @override
  void initState() {
    super.initState();
    // tabController = TabController(length: menuItemList.length, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ticketController.fechTicket();
    });
  }

  @override
  void dispose() {
    // tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final Widget tabBar = AppModernTabBar(
    //   controller: tabController,
    //   menuItemList: menuItemList,
    // );

    // const upcomingTab = UpcomingTicketTab();
    // const pastTab = PastTicketTab();

    // final Widget tabViews = TabBarView(
    //   controller: tabController,
    //   children: const [
    //     upcomingTab,
    //     pastTab,
    //   ],
    // );

    return Obx(
      () => Stack(
        children: [
          Scaffold(
            backgroundColor: colorWhite,
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      getAssetImage(AssetImagePath.background_ticket)),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                bottom: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: dimen16,
                        vertical: dimen4,
                      ),
                      child: Row(
                        children: [
                          Text(
                            'Your Tickets',
                            style: GoogleFonts.quicksand(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: color0E4C88,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ticketController.ticketData.value.data?.data !=
                                  null &&
                              ticketController.ticketData.value.data?.data
                                      ?.isNotEmpty ==
                                  true
                          ? RefreshIndicator(
                              displacement: dimen100,
                              backgroundColor: Colors.white,
                              color: colorPrimary,
                              strokeWidth: dimen3,
                              triggerMode: RefreshIndicatorTriggerMode.onEdge,
                              onRefresh: () async {
                                ticketController.fechTicket();
                              },
                              child: SingleChildScrollView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                child: Column(
                                  children: [
                                    verticalSpace20,
                                    ListView.separated(
                                      shrinkWrap: true,
                                      padding: const EdgeInsets.only(
                                          bottom: dimen24),
                                      itemCount: ticketController.ticketData
                                              .value.data?.data?.length ??
                                          0,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        height: dimen10,
                                      ),
                                      itemBuilder: (context, index) {
                                        return ticketContainer(
                                          index: index,
                                          data: ticketController.ticketData
                                              .value.data?.data?[index],
                                        );
                                      },
                                    ),
                                    verticalSpace100,
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Image(
                                      image: AssetImage(
                                        getAssetImage(
                                            AssetImagePath.no_tickets),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.65,
                                    ),
                                  ),
                                  Text(
                                    'No Tickets',
                                    style: GoogleFonts.quicksand(
                                      color: colorBlack,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  verticalSpace4,
                                  Text(
                                    'When you have tickets you’ll see them here.',
                                    style: GoogleFonts.quicksand(
                                      color: color4E5260,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
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
          ),
          ticketController.isFetchingTicket()
              ? const FullScreenProgress()
              : Container()
          // CommonAppBarPage(
          //   title: 'Your Tickets',
          //   isBack: widget.isBack,
          //   child: Container(
          //     decoration: const BoxDecoration(
          //       color: colorWhite,
          //     ),
          //     child: Column(
          //       children: [
          //         Container(
          //             padding: const EdgeInsets.only(top: dimen2), child: tabBar),
          //         Expanded(child: tabViews),
          //       ],
          //     ),
          //   ),
          // ),
          // Obx(() => (notificationController.isGettingListNotifications() ||
          //         notificationController.isGettingListNewTaskNotifications() ||
          //         notificationController.isGettingListUnboxNotifications() ||
          //         notificationController.isFetchingTaskType())
          //     ? const FullScreenProgress()
          //     : Container()),
        ],
      ),
    );
  }

  Widget ticketContainer({int? index, TicketData? data}) {
    return GestureDetector(
      onTap: () {
        showBarModalBottomSheet(
          context: context,
          backgroundColor: colorE8F2FC,
          expand: true,
          useRootNavigator: true,
          builder: (context) => Scaffold(
            backgroundColor: colorECF3F6,
            body: Container(
              decoration: const BoxDecoration(
                  // image: DecorationImage(
                  //   fit: BoxFit.cover,
                  //   image: CachedNetworkImageProvider(
                  //       "https://images.pexels.com/photos/7130486/pexels-photo-7130486.jpeg?cs=srgb&dl=pexels-codioful-%28formerly-gradienta%29-7130486.jpg&fm=jpg"),
                  // ),
                  ),
              child: Container(
                margin: const EdgeInsets.only(
                  left: dimen30,
                  right: dimen30,
                  top: dimen30,
                  bottom: dimen30,
                ),
                padding: const EdgeInsets.only(
                  // left: dimen10,
                  // right: dimen10,
                  top: dimen10,
                  bottom: dimen14,
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(dimen20),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: colorE4E1E1.withOpacity(0.6),
                  //     blurRadius: dimen4,
                  //     offset: const Offset(
                  //         dimen0, dimen0), // changes position of shadow
                  //   ),
                  // ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image.asset(
                    //   getAssetImage(AssetImagePath.xcard_logo),
                    //   fit: BoxFit.cover,
                    //   height: 16,
                    // ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      margin: const EdgeInsets.only(
                        left: dimen10,
                        right: dimen10,
                      ),
                      decoration: BoxDecoration(
                        color: color0E1116,
                        borderRadius: BorderRadius.circular(dimen12),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            data?.bannerUrl ?? '',
                          ),
                        ),
                      ),

                      // child: CachedNetworkImage(
                      //   imageUrl:
                      //       "https://s32659.pcdn.co/wp-content/uploads/2022/11/crypto-events-calendar.jpg.optimal.jpg",
                      //   placeholder: (context, url) =>
                      //       const CircularProgressIndicator(),
                      //   errorWidget: (context, url, error) =>
                      //       const Icon(Icons.error),
                    ),
                    verticalSpace16,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: dimen18,
                        right: dimen18,
                      ),
                      child: Text(
                        data?.eventName ?? '',
                        style: GoogleFonts.quicksand(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: colorBlack,
                        ),
                      ),
                    ),
                    verticalSpace16,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: dimen18,
                        right: dimen18,
                      ),
                      child: Text(
                        'Name',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: color878998,
                        ),
                      ),
                    ),
                    verticalSpace4,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: dimen18,
                        right: dimen18,
                      ),
                      child: Text(
                        data?.userName ?? '',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: colorBlack,
                        ),
                        maxLines: 3,
                      ),
                    ),
                    verticalSpace16,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: dimen18,
                        right: dimen18,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Time',
                                style: GoogleFonts.quicksand(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: color878998,
                                ),
                              ),
                              verticalSpace4,
                              Text(
                                DateFormat('HH:mm')
                                    .format(
                                      DateFormat('yyyy-MM-dd HH:mm').parse(
                                        '${data?.endAt}',
                                      ),
                                    )
                                    .toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: colorBlack,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Date',
                                style: GoogleFonts.quicksand(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: color878998,
                                ),
                              ),
                              verticalSpace4,
                              Text(
                                DateFormat('EEE, dd MMM yyyy')
                                    .format(
                                      DateFormat('yyyy-MM-dd HH:mm').parse(
                                        '${data?.endAt}',
                                      ),
                                    )
                                    .toString(),
                                style: GoogleFonts.quicksand(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: colorBlack,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    verticalSpace16,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: dimen18,
                        right: dimen18,
                      ),
                      child: Text(
                        'Location',
                        style: GoogleFonts.quicksand(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: color878998,
                        ),
                      ),
                    ),
                    verticalSpace4,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: dimen18,
                        right: dimen18,
                      ),
                      child: SelectableText(
                        data?.address ?? '',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: colorBlack,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      color: colorWhite,
                      child: Row(
                        children: [
                          const SizedBox(
                            height: 20,
                            width: 10,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: colorECF3F6,
                                // color: colorD3FFFE,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(dimen20),
                                    bottomRight: Radius.circular(dimen20)),
                              ),
                            ),
                          ),
                          horizontalSpace10,
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: LayoutBuilder(
                              builder: (builtContext, boxConstrainst) {
                                return Flex(
                                  direction: Axis.horizontal,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: List.generate(
                                    (boxConstrainst.constrainWidth() / 13)
                                        .floor(),
                                    (index) => SizedBox(
                                      width: 6,
                                      height: 3,
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                            color: colorECF3F6,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          )),
                          horizontalSpace10,
                          const SizedBox(
                            height: 20,
                            width: 10,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: colorECF3F6,
                                // color: colorD7C4EF,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(dimen20),
                                    bottomLeft: Radius.circular(dimen20)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // verticalSpace30,
                    const Spacer(),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        color: colorF5F7F9,
                        borderRadius: BorderRadius.circular(dimen12),
                      ),
                      margin: const EdgeInsets.only(
                        left: dimen16,
                        right: dimen16,
                      ),
                      padding: const EdgeInsets.only(
                        left: dimen16,
                        right: dimen16,
                        top: dimen16,
                        bottom: dimen16,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Scan QR Code',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: colorBlack,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'Scan this QR Code or show this ticket at of event.',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: color4E4E4E,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(flex: 1),
                          // QrImage(
                          //   data: 'jhefjhef',
                          //   version: 1,
                          //   gapless: true,
                          //   padding: EdgeInsets.zero,
                          // ),
                          _buildQRImage(data?.qrContent ?? ''),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: dimen18,
                        right: dimen18,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: dimen45,
                            height: dimen45,
                            decoration: BoxDecoration(
                              color: colorBlack,
                              borderRadius: BorderRadius.circular(dimen8),
                            ),
                            padding: const EdgeInsets.all(dimen14),
                            child: Image.asset(
                              getAssetImage(AssetImagePath.share),
                              fit: BoxFit.cover,
                              color: colorWhite,
                            ),
                          ),
                          horizontalSpace10,
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: colorBlack,
                                borderRadius: BorderRadius.circular(dimen8),
                              ),
                              height: dimen45,
                              child: Center(
                                child: Text(
                                  'Download Ticket',
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: colorWhite,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: dimen150,
        margin: const EdgeInsets.symmetric(horizontal: dimen16),
        decoration: BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.circular(dimen18),
          boxShadow: [
            BoxShadow(
              color: colorE4E1E1.withOpacity(0.8),
              blurRadius: dimen10,
              offset:
                  const Offset(dimen0, dimen0), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: dimen150,
              width: dimen30,
              decoration: BoxDecoration(
                color: data?.type == 1
                    ? color30A1DB
                    : data?.type == 2
                        ? colorFFB800
                        : data?.type == 3
                            ? color171716
                            : color30A1DB,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(dimen18),
                  bottomLeft: Radius.circular(dimen18),
                ),
              ),
              child: Center(
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    data?.typeName ?? '',
                    style: GoogleFonts.quicksand(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: colorWhite,
                    ),
                  ),
                ),
              ),
            ),
            ClipPath(
              clipper: WaveClipper(),
              child: Container(
                height: dimen150,
                width: dimen4,
                decoration: BoxDecoration(
                  color: data?.type == 1
                      ? color30A1DB
                      : data?.type == 2
                          ? colorFFB800
                          : data?.type == 3
                              ? color171716
                              : color30A1DB,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(dimen10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat('HH:mm')
                              .format(
                                DateFormat('yyyy-MM-dd HH:mm').parse(
                                  '${data?.endAt}',
                                ),
                              )
                              .toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: color30A1DB,
                          ),
                        ),
                        horizontalSpace4,
                        Text(
                          '•',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: color9C9896,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '•',
                          style: GoogleFonts.quicksand(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: color9C9896,
                          ),
                        ),
                        horizontalSpace4,
                        Text(
                          DateFormat('dd MMM yyyy')
                              .format(
                                DateFormat('yyyy-MM-dd HH:mm').parse(
                                  '${data?.endAt}',
                                ),
                              )
                              .toString(),
                          style: GoogleFonts.quicksand(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: color30A1DB,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace10,
                    Text(
                      data?.eventName ?? '',
                      style: GoogleFonts.quicksand(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: colorBlack,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            data?.address ?? '',
                            style: GoogleFonts.quicksand(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: color9C9896,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        horizontalSpace10,
                        Container(
                          width: dimen25,
                          height: dimen25,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  getAssetImage(AssetImagePath.button_next)),
                              fit: BoxFit.cover,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: color30A1DB.withOpacity(0.6),
                                blurRadius: dimen15,
                                offset: const Offset(dimen0, dimen5),
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildQRImage(String data) {
    return QrImage(
      data: data,
      gapless: false,
      padding: EdgeInsets.zero,
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.H,
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(size.height, 0);
    var x = 0.0;
    var numberOfWaves = 34;
    var increment = size.height / numberOfWaves;
    bool startFromTop = false;

    while (x < size.height) {
      if (startFromTop) {
        path.lineTo(0, x);
      } else {
        path.lineTo(size.width, x);
      }
      x += increment;
      startFromTop = !startFromTop;
    }

    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
