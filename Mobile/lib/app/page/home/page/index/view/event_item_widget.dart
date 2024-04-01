// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:like_button/like_button.dart';
// import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
// import 'package:plat_app/base/resources/constants/base_colors.dart';
// import 'package:plat_app/base/resources/constants/base_constraint.dart';
// import 'package:plat_app/base/resources/constants/base_text_styles.dart';
// import 'package:plat_app/base/resources/constants/dimens.dart';
// import 'package:plat_app/app/page/home/page/home_tab/models/task_pool_list_reponse.dart';

// class EventItem extends StatefulWidget {
//   final Data task;
//   final double width;
//   const EventItem({Key? key, required this.task, this.width = 0})
//       : super(key: key);

//   @override
//   State<EventItem> createState() => _EventItemState();
// }

// class _EventItemState extends State<EventItem> {
//   bool isPin = false;
//   final IndexController indexController = Get.find();
//   @override
//   void initState() {
//     super.initState();
//     isPin = widget.task.pin?.isPin ?? false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: 200,
//           decoration: BoxDecoration(
//             image: DecorationImage(
//               // colorFilter: ColorFilter.mode(
//               //   colorBlack.withOpacity(.5),
//               //   BlendMode.multiply,
//               // ),
//               image: CachedNetworkImageProvider(
//                 widget.task.bannerUrl ?? '',
//               ),
//               fit: BoxFit.cover,
//             ),
//           ),
//           // padding: const EdgeInsets.all(dimen16),
//           // child: Column(
//           //   children: [
//           //     Row(
//           //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //       children: [
//           //         Row(
//           //           children: [
//           //             Container(
//           //               decoration: BoxDecoration(
//           //                 borderRadius: BorderRadius.circular(2),
//           //                 color: widget.task.type == 'event'
//           //                     ? color1DA5F2
//           //                     : colorFFB800,
//           //               ),
//           //               padding:
//           //                   const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//           //               child: Text(
//           //                 widget.task.type == 'event'
//           //                     ? 'Free on Plats'
//           //                     : widget.task.postBy ?? '',
//           //                 style: text10_white_600.copyWith(fontSize: 10),
//           //               ),
//           //             ),
//           //           ],
//           //         ),
//           //         LikeButton(
//           //           isLiked: widget.task.pin?.isPin,
//           //           likeCountPadding: EdgeInsets.zero,
//           //           onTap: (bool value) async {
//           //             setState(
//           //               () {
//           //                 isPin = !isPin;
//           //                 widget.task.pin?.isPin = isPin;
//           //                 if (isPin == true) {
//           //                   indexController.fetchLikeOrPin(
//           //                       widget.task.id as String, 'pin');
//           //                 } else {
//           //                   indexController.fetchLikeOrPin(
//           //                       widget.task.id as String, 'unpin');
//           //                 }
//           //               },
//           //             );
//           //             return Future.value(!value);
//           //           },
//           //           size: 20,
//           //           circleColor: const CircleColor(
//           //             start: colorFFB800,
//           //             end: Color.fromARGB(255, 255, 208, 90),
//           //           ),
//           //           bubblesColor: const BubblesColor(
//           //             dotPrimaryColor: Color.fromARGB(255, 255, 208, 90),
//           //             dotSecondaryColor: Color.fromARGB(255, 226, 199, 131),
//           //           ),
//           //           likeBuilder: (bool isLiked) {
//           //             return Image.asset(
//           //               getAssetImage(
//           //                 widget.task.pin?.isPin as bool || isPin
//           //                     ? AssetImagePath.bookmark
//           //                     : AssetImagePath.bookmark_line,
//           //               ),
//           //               width: dimen20,
//           //               height: dimen20,
//           //               color: widget.task.pin?.isPin as bool || isPin
//           //                   ? colorFFB800
//           //                   : colorB7BBCB,
//           //             );
//           //           },
//           //         ),
//           //       ],
//           //     ),
//           //     verticalSpace10,
//           //     SizedBox(
//           //       height: dimen96,
//           //       child: Row(
//           //         children: [
//           //           SizedBox(
//           //             height: dimen96,
//           //             width: dimen96,
//           //             child: ClipRRect(
//           //               borderRadius: BorderRadius.circular(4),
//           //               child: AppCachedImage(
//           //                 imageUrl: widget.task.bannerUrl ?? '',
//           //                 width: double.infinity,
//           //                 height: dimen125,
//           //                 fit: BoxFit.cover,
//           //               ),
//           //             ),
//           //           ),
//           //           horizontalSpace10,
//           //           Expanded(
//           //             child: Column(
//           //               mainAxisAlignment: MainAxisAlignment.start,
//           //               crossAxisAlignment: CrossAxisAlignment.start,
//           //               children: [
//           //                 Text(
//           //                   widget.task.name.toString(),
//           //                   style: text16_32302D_700,
//           //                   maxLines: dimen2.toInt(),
//           //                   textAlign: TextAlign.left,
//           //                   overflow: TextOverflow.ellipsis,
//           //                 ),
//           //                 verticalSpace4,
//           //                 widget.task.type == 'event'
//           //                     ? Text(
//           //                         'by ${widget.task.postBy.toString()}',
//           //                         style: const TextStyle(
//           //                           color: color9C9C9C,
//           //                           fontSize: dimen12,
//           //                           fontWeight: FontWeight.w500,
//           //                         ),
//           //                         maxLines: dimen2.toInt(),
//           //                         textAlign: TextAlign.left,
//           //                         overflow: TextOverflow.ellipsis,
//           //                       )
//           //                     : const SizedBox(),
//           //                 const Spacer(),
//           //                 widget.task.type == 'event'
//           //                     ? Text(
//           //                         DateFormat('EEEE, dd MMMM yyyy')
//           //                             .format(
//           //                               DateFormat('dd-MM-yyyy HH:mm:ss').parse(
//           //                                 '${widget.task.endAt}',
//           //                               ),
//           //                             )
//           //                             .toString(),
//           //                         style: const TextStyle(
//           //                           color: color495057,
//           //                           fontSize: dimen13,
//           //                           fontWeight: FontWeight.w400,
//           //                         ),
//           //                       )
//           //                     : const SizedBox(),
//           //                 widget.task.type == 'event'
//           //                     ? const SizedBox()
//           //                     : Row(
//           //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //                         children: [
//           //                           Text(
//           //                             '${widget.task.taskCheckIn?.length ?? 0} Quests',
//           //                             style: const TextStyle(
//           //                               color: color1266B5,
//           //                               fontSize: 13,
//           //                               fontWeight: FontWeight.w600,
//           //                               overflow: TextOverflow.ellipsis,
//           //                               // fontFamily: 'Termina',
//           //                             ),
//           //                             maxLines: 1,
//           //                           ),
//           //                           Container(
//           //                             decoration: BoxDecoration(
//           //                               color: colorE8F2FC,
//           //                               borderRadius: BorderRadius.circular(20),
//           //                             ),
//           //                             padding: const EdgeInsets.symmetric(
//           //                                 horizontal: 1, vertical: 1),
//           //                             child: Row(
//           //                               children: [
//           //                                 Image.asset(
//           //                                   getAssetImage(
//           //                                       AssetImagePath.mystery_box_large),
//           //                                   width: dimen23,
//           //                                   height: dimen23,
//           //                                 ),
//           //                               ],
//           //                             ),
//           //                           )
//           //                         ],
//           //                       )
//           //               ],
//           //             ),
//           //           ),
//           //         ],
//           //       ),
//           //     ),
//           //   ],
//           // ),
//         ),
//         Container(
//           height: dimen200,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(dimen8),
//             gradient: const LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Color.fromARGB(0, 0, 0, 0),
//                 Color(0x00000000),
//                 Color.fromARGB(179, 0, 0, 0),
//                 Color.fromARGB(235, 0, 0, 0),
//               ],
//             ),
//           ),
//         ),
//         Positioned(
//           left: dimen10,
//           bottom: dimen10,
//           right: dimen20,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.task.name.toString(),
//                 style: GoogleFonts.quicksand(
//                   color: colorWhite,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               ),
//               verticalSpace8,
//               Text(
//                 DateFormat('EEEE, dd MMMM yyyy')
//                     .format(
//                       DateFormat('dd-MM-yyyy HH:mm:ss').parse(
//                         '${widget.task.endAt}',
//                       ),
//                     )
//                     .toString(),
//                 style: GoogleFonts.quicksand(
//                   color: colorWhite,
//                   fontSize: 10,
//                   fontWeight: FontWeight.w500,
//                   // fontStyle: FontStyle.italic,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 2,
//               ),
//               verticalSpace2,
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     getAssetImage(AssetImagePath.location_pin),
//                     fit: BoxFit.cover,
//                     width: dimen10,
//                     height: dimen10,
//                     color: color30A1DB,
//                   ),
//                   horizontalSpace2,
//                   Expanded(
//                     child: Text(
//                       widget.task.address ?? '',
//                       style: GoogleFonts.quicksand(
//                         color: color30A1DB,
//                         fontSize: 10,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: dimen10,
//           right: dimen10,
//           child: Container(
//             decoration: BoxDecoration(
//               color: colorDisabledButton.withOpacity(0.3),
//               shape: BoxShape.circle,
//             ),
//             padding: const EdgeInsets.all(dimen3),
//             child: LikeButton(
//               isLiked: widget.task.pin?.isPin,
//               likeCountPadding: EdgeInsets.zero,
//               onTap: (bool value) async {
//                 setState(
//                   () {
//                     isPin = !isPin;
//                     widget.task.pin?.isPin = isPin;
//                     if (isPin == true) {
//                       indexController.fetchLikeOrPin(
//                           widget.task.id as String, 'pin');
//                     } else {
//                       indexController.fetchLikeOrPin(
//                           widget.task.id as String, 'unpin');
//                     }
//                   },
//                 );
//                 return Future.value(!value);
//               },
//               size: 20,
//               circleColor:
//                   const CircleColor(start: Colors.pink, end: Colors.pinkAccent),
//               bubblesColor: const BubblesColor(
//                 dotPrimaryColor: Colors.red,
//                 dotSecondaryColor: Colors.redAccent,
//               ),
//               likeBuilder: (bool isLiked) {
//                 return Icon(
//                   Icons.favorite,
//                   color: widget.task.pin?.isPin as bool || isPin
//                       ? Colors.pink
//                       : colorWhite,
//                   size: 20,
//                 );
//               },
//             ),
//           ),
//         ),
//         Positioned(
//           top: dimen10,
//           left: dimen10,
//           child: Row(
//             children: [
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(2),
//                   color: widget.task.type == 'event'
//                       ? color1DA5F2.withOpacity(0.7)
//                       : colorFFB800.withOpacity(0.7),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                 child: Text(
//                   widget.task.type == 'event'
//                       ? 'Free on Plats'
//                       : widget.task.postBy ?? '',
//                   style: text10_white_600.copyWith(fontSize: 10),
//                 ),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }