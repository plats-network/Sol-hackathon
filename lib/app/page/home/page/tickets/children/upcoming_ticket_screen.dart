import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:plat_app/app/page/home/children/notification/controller/notification_controller.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UpcomingTicketTab extends StatefulWidget {
  const UpcomingTicketTab({Key? key}) : super(key: key);

  @override
  State<UpcomingTicketTab> createState() => _UpcomingTicketTabState();
}

class _UpcomingTicketTabState extends State<UpcomingTicketTab> {
  final NotificationController notificationController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      notificationController.fetchListNotifications();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          verticalSpace20,
          ListView.separated(
            shrinkWrap: true,
            padding: const EdgeInsets.only(bottom: dimen24),
            itemCount: 3,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(
              height: dimen10,
            ),
            itemBuilder: (context, index) {
              return ticketContainer(index: index);
            },
          ),
          verticalSpace100,
        ],
      ),

      // Obx(() {
      //   if (notificationController.isGettingListNotifications()) {
      //     return Column(
      //       children: [
      //         Container(
      //             margin: const EdgeInsets.only(
      //                 left: dimen16, right: dimen16, top: dimen12),
      //             alignment: Alignment.topRight,
      //             child: Text('${"unread".tr} (0)', style: text14_9C9896_600)),
      //         verticalSpace20,
      //         ListView(
      //           shrinkWrap: true,
      //           physics: const NeverScrollableScrollPhysics(),
      //           children: List.generate(
      //             mockNotifications.length,
      //             (index) => const NotificationItemShimmer(),
      //           ),
      //         ),
      //       ],
      //     );
      //   } else {
      //     return notificationController.unreadNotificationCount.value != 0
      //         ? Column(
      //             children: [
      //               Container(
      //                 margin: const EdgeInsets.only(
      //                     left: dimen16, right: dimen16, top: dimen12),
      //                 alignment: Alignment.topRight,
      //                 child: Obx(() => Text(
      //                     '${"unread".tr} (${notificationController.unreadNotificationCount.value})',
      //                     style: notificationController
      //                                 .unreadNotificationCount.value >
      //                             0
      //                         ? text14_A73237_600
      //                         : text14_9C9896_600)),
      //               ),
      //               verticalSpace20,
      //               Obx(() {
      //                 final notifications = notificationController
      //                     .listNotificationsData.value.data?.data;
      //                 return ListView.builder(
      //                   shrinkWrap: true,
      //                   padding: const EdgeInsets.only(bottom: dimen24),
      //                   itemCount: notifications?.length ?? 0,
      //                   physics: const NeverScrollableScrollPhysics(),
      //                   itemBuilder: (context, index) {
      //                     final notification = notifications?[index];
      //                     return NotificationItem(
      //                       notification: notification,
      //                       type: null,
      //                     );
      //                   },
      //                 );
      //               }),
      //             ],
      //           )
      //         : SizedBox(
      //             height: MediaQuery.of(context).size.height * 0.7,
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               crossAxisAlignment: CrossAxisAlignment.center,
      //               children: [
      //                 Container(
      //                   alignment: Alignment.center,
      //                   child: Image(
      //                     image: AssetImage(
      //                       getAssetImage(AssetImagePath.no_tickets),
      //                     ),
      //                     width: MediaQuery.of(context).size.width * 0.65,
      //                   ),
      //                 ),
      //                 Text(
      //                   'No Tickets',
      //                   style: GoogleFonts.quicksand(
      //                     color: colorBlack,
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //                 verticalSpace4,
      //                 Text(
      //                   'When you have tickets you’ll see them here.',
      //                   style: GoogleFonts.quicksand(
      //                     color: color4E5260,
      //                     fontSize: 13,
      //                     fontWeight: FontWeight.w500,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           );
      //   }
      // }),
    );
  }

  Widget ticketContainer({int? index}) {
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
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                              "https://s32659.pcdn.co/wp-content/uploads/2022/11/crypto-events-calendar.jpg.optimal.jpg"),
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
                        'Eventrue - Event Boking Mobile App UI KIT',
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
                        'User Name',
                        style: GoogleFonts.quicksand(
                          fontSize: 14,
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
                                '9pm - 12pm',
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
                                '30 - 31 April 2023',
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
                      child: Text(
                        '202 Hoàng Văn Thụ, Phường 9, Phú Nhuận, Thành phố Hồ Chí Minh, Việt Nam',
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
                          QrImage(
                            data: '',
                            version: 1,
                            gapless: true,
                            padding: EdgeInsets.zero,
                          ),
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
                color: index == 0
                    ? color30A1DB
                    : index == 1
                        ? colorFFB800
                        : index == 2
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
                    index == 0
                        ? 'Basic'
                        : index == 1
                            ? 'VVIP'
                            : index == 2
                                ? 'NFT'
                                : '',
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
                  color: index == 0
                      ? color30A1DB
                      : index == 1
                          ? colorFFB800
                          : index == 2
                              ? color171716
                              : color30A1DB,
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(dimen10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '9pm - 12pm',
                          style: GoogleFonts.quicksand(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: color9C9896,
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
                          '30 - 31 April 2023',
                          style: GoogleFonts.quicksand(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: color9C9896,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace10,
                    Text(
                      'Eventrue - Event Boking Mobile App UI KIT',
                      style: GoogleFonts.quicksand(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: colorBlack,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Text(
                      '202 Hoàng Văn Thụ, Phường 9, Phú Nhuận, Thành phố Hồ Chí Minh, Việt Nam',
                      style: GoogleFonts.quicksand(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: color9C9896,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
