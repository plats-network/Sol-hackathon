// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:like_button/like_button.dart';
// import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
// import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
// import 'package:plat_app/app/widgets/app_cached_image.dart';
// import 'package:plat_app/app/widgets/common_appbar_page.dart';
// import 'package:plat_app/base/resources/constants/base_colors.dart';
// import 'package:plat_app/base/resources/constants/base_constraint.dart';
// import 'package:plat_app/base/resources/constants/base_text_styles.dart';
// import 'package:plat_app/base/resources/constants/dimens.dart';
// import 'package:plat_app/base/resources/constants/radius.dart';
// import 'package:plat_app/base/routes/base_pages.dart';
// import 'package:plat_app/app/page/home/page/home_tab/models/task_pool_list_reponse.dart';

// class ListEventPage extends StatefulWidget {
//   const ListEventPage({Key? key}) : super(key: key);

//   @override
//   State<ListEventPage> createState() => _ListEventPageState();
// }

// class _ListEventPageState extends State<ListEventPage> {
//   final HomeTabController homeTabController = Get.find();
//   @override
//   void initState() {
//     homeTabController.fetchEventTask();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () => Scaffold(
//         body: CommonAppBarPage(
//           title: 'Events'.tr,
//           child: RefreshIndicator(
//             displacement: dimen50,
//             backgroundColor: Colors.white,
//             color: colorPrimary,
//             strokeWidth: dimen3,
//             triggerMode: RefreshIndicatorTriggerMode.onEdge,
//             onRefresh: () async {
//               homeTabController.fetchEventTask();
//             },
//             child: SizedBox(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//               child: TabPage(
//                   tasks: homeTabController.taskEventData.value.data?.data ?? [],
//                   description:
//                       'Experience the thrill of the event and reap the rewards. Join now and start winning big!',
//                   title: ''),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget TabPage({
//     String? title,
//     String? description,
//     required List<Data> tasks,
//   }) {
//     return SingleChildScrollView(
//       physics: const AlwaysScrollableScrollPhysics(),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(
//               left: dimen16,
//               right: dimen16,
//               bottom: dimen30,
//               top: dimen24,
//             ),
//             child: Text(
//               '$description',
//               style: text14_32302D_700.copyWith(
//                 color: color878998,
//                 fontWeight: FontWeight.w400,
//               ),
//               textAlign: TextAlign.left,
//               // overflow: TextOverflow.ellipsis,
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: dimen16),
//             child: ListView.separated(
//               itemBuilder: (context, index) {
//                 return Container(
//                   margin: const EdgeInsets.only(bottom: dimen16),
//                   decoration: const BoxDecoration(
//                     color: colorWhite,
//                     borderRadius: border8,
//                     boxShadow: [
//                       BoxShadow(
//                         color: colorE4E1E1,
//                         offset: Offset(0, dimen4),
//                         blurRadius: dimen24,
//                       ),
//                     ],
//                   ),
//                   clipBehavior: Clip.antiAlias,
//                   child: Material(
//                     color: colorWhite,
//                     child: InkWell(
//                       borderRadius: border8,
//                       onTap: () => [
//                         Get.toNamed(Routes.socialTaskDetail, arguments: {
//                           'task_id': tasks[index].id,
//                           'is_done': tasks[index].taskStart,
//                         })
//                       ],
//                       child: TaskItem(task: tasks[index]),
//                     ),
//                   ),
//                 );
//               },
//               shrinkWrap: true,
//               physics: const ClampingScrollPhysics(),
//               separatorBuilder: (context, index) => const SizedBox(
//                   // height: 8,
//                   ),
//               itemCount: tasks.length,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TaskItem extends StatefulWidget {
//   final Data task;
//   final double width;
//   const TaskItem({Key? key, required this.task, this.width = 0})
//       : super(key: key);

//   @override
//   State<TaskItem> createState() => _TaskItemState();
// }

// class _TaskItemState extends State<TaskItem> {
//   bool isPin = false;
//   final IndexController indexController = Get.find();
//   @override
//   void initState() {
//     super.initState();
//     isPin = widget.task.pin?.isPin ?? false;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       padding: const EdgeInsets.all(dimen16),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(2),
//                       color: color1DA5F2.withOpacity(0.8),
//                     ),
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                     child: Text(
//                       'Free on Plats',
//                       style: text10_white_600.copyWith(fontSize: 10),
//                     ),
//                   ),
//                 ],
//               ),
//               // Container(
//               //   child: LikeButton(
//               //     isLiked: widget.task.pin?.isPin,
//               //     likeCountPadding: EdgeInsets.zero,
//               //     onTap: (bool value) async {
//               //       setState(
//               //         () {
//               //           isPin = !isPin;
//               //           widget.task.pin?.isPin = isPin;
//               //           if (isPin == true) {
//               //             indexController.fetchLikeOrPin(
//               //                 widget.task.id as String, 'pin');
//               //           } else {
//               //             indexController.fetchLikeOrPin(
//               //                 widget.task.id as String, 'unpin');
//               //           }
//               //         },
//               //       );
//               //       return Future.value(!value);
//               //     },
//               //     size: 20,
//               //     circleColor: const CircleColor(
//               //       start: colorFFB800,
//               //       end: Color.fromARGB(255, 255, 208, 90),
//               //     ),
//               //     bubblesColor: const BubblesColor(
//               //       dotPrimaryColor: Color.fromARGB(255, 255, 208, 90),
//               //       dotSecondaryColor: Color.fromARGB(255, 226, 199, 131),
//               //     ),
//               //     likeBuilder: (bool isLiked) {
//               //       return Image.asset(
//               //         getAssetImage(
//               //           widget.task.pin?.isPin as bool || isPin
//               //               ? AssetImagePath.bookmark
//               //               : AssetImagePath.bookmark_line,
//               //         ),
//               //         width: dimen20,
//               //         height: dimen20,
//               //         color: widget.task.pin?.isPin as bool || isPin
//               //             ? colorFFB800
//               //             : colorB7BBCB,
//               //       );
//               //     },
//               //   ),
//               // ),
//             ],
//           ),
//           verticalSpace10,
//           SizedBox(
//             height: dimen96,
//             child: Row(
//               children: [
//                 SizedBox(
//                   height: dimen96,
//                   width: dimen96,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(4),
//                     child: AppCachedImage(
//                       imageUrl: widget.task.bannerUrl ?? '',
//                       width: double.infinity,
//                       height: dimen125,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 horizontalSpace10,
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.task.name.toString(),
//                         style: text16_32302D_700,
//                         maxLines: dimen2.toInt(),
//                         textAlign: TextAlign.left,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       verticalSpace4,
//                       Text(
//                         'by ${widget.task.postBy.toString()}',
//                         style: const TextStyle(
//                           color: color9C9C9C,
//                           fontSize: dimen12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                         maxLines: dimen2.toInt(),
//                         textAlign: TextAlign.left,
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                       const Spacer(),
//                       Text(
//                         DateFormat('EEEE, dd MMMM yyyy')
//                             .format(
//                               DateFormat('dd-MM-yyyy HH:mm:ss').parse(
//                                 '${widget.task.endAt}',
//                               ),
//                             )
//                             .toString(),
//                         style: const TextStyle(
//                           color: color495057,
//                           fontSize: dimen13,
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
