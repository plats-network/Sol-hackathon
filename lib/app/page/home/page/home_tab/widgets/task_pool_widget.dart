// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
// import 'package:plat_app/app/page/home/page/home_tab/models/task_pool_list_reponse.dart';
// import 'package:plat_app/app/page/home/page/home_tab/widgets/event_item_widget.dart';
// import 'package:plat_app/app/widgets/app_cached_image.dart';
// import 'package:plat_app/app/widgets/app_modern_tabbar.dart';
// import 'package:plat_app/base/resources/constants/base_colors.dart';
// import 'package:plat_app/base/resources/constants/dimens.dart';
// import 'package:plat_app/base/resources/constants/radius.dart';
// import 'package:plat_app/base/routes/base_pages.dart';

// class TaskPoolWidget extends StatefulWidget {
//   final List<Data> tasks;
//   final List<Data> myTask;
//   final List<Data> taskSocials;
//   final List<Data> taskEvents;
//   const TaskPoolWidget({
//     Key? key,
//     required this.tasks,
//     required this.myTask,
//     required this.taskSocials,
//     required this.taskEvents,
//   }) : super(key: key);

//   @override
//   State<TaskPoolWidget> createState() => _TaskPoolWidgetState();
// }

// class _TaskPoolWidgetState extends State<TaskPoolWidget>
//     with TickerProviderStateMixin {
//   late TabController tabController;
//   final menuItemList = ['All Quest', 'Tasks', 'Event'];
//   final HomeTabController homeTabController = Get.find();
//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: menuItemList.length, vsync: this);
//   }

//   @override
//   void dispose() {
//     tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Widget tabBar = AppModernTabBar(
//       controller: tabController,
//       menuItemList: menuItemList,
//     );
//     return DefaultTabController(
//       length: menuItemList.length,
//       child: SafeArea(
//         child: Scaffold(
//           backgroundColor: colorWhite,
//           appBar: PreferredSize(
//             preferredSize: const Size.fromHeight(80),
//             child: AppBar(
//               elevation: 0,
//               backgroundColor: colorWhite,
//               title: Text(
//                 'task_pool'.tr,
//                 style: GoogleFonts.quicksand(
//                     fontSize: 20,
//                     color: color0E4C88,
//                     fontWeight: FontWeight.w700),
//               ),
//               centerTitle: false,
//               bottom: PreferredSize(
//                 preferredSize: const Size.fromHeight(40),
//                 child: Container(
//                     // color: color0E4B88,
//                     color: colorWhite,
//                     child: tabBar),
//               ),
//             ),
//           ),
//           body: Column(
//             children: [
//               Expanded(
//                 child: TabBarView(
//                   controller: tabController,
//                   children: [
//                     RefreshIndicator(
//                       displacement: dimen20,
//                       backgroundColor: Colors.white,
//                       color: colorPrimary,
//                       strokeWidth: dimen3,
//                       triggerMode: RefreshIndicatorTriggerMode.onEdge,
//                       onRefresh: () async {
//                         homeTabController.fetchTaskPoolTask();
//                         homeTabController.fetchMyTaskProvider();
//                       },
//                       child: TabPage(
//                           tasks: widget.tasks,
//                           title: 'All Quests',
//                           description:
//                               'Discover quests here!Be sure to join now and don’t miss your chance to be part of something big!'),
//                     ),
//                     RefreshIndicator(
//                       displacement: dimen20,
//                       backgroundColor: Colors.white,
//                       color: colorPrimary,
//                       strokeWidth: dimen3,
//                       triggerMode: RefreshIndicatorTriggerMode.onEdge,
//                       onRefresh: () async {
//                         homeTabController.fetchTask();
//                       },
//                       child: TabPage(
//                           tasks: widget.taskSocials,
//                           title: 'Tasks',
//                           description:
//                               'Accomplish goals, reap the benefits. Complete tasks, gain rewards. Take action today and unlock the prizes of tomorrow.'),
//                     ),
//                     RefreshIndicator(
//                       displacement: dimen20,
//                       backgroundColor: Colors.white,
//                       color: colorPrimary,
//                       strokeWidth: dimen3,
//                       triggerMode: RefreshIndicatorTriggerMode.onEdge,
//                       onRefresh: () async {
//                         homeTabController.fetchEventTask();
//                       },
//                       child: TabPage(
//                           tasks: widget.taskEvents,
//                           title: 'Events',
//                           description:
//                               'Experience the thrill of the event and reap the rewards. Join now and start winning big!'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Widget TabPage({
//   String? title,
//   String? description,
//   required List<Data> tasks,
// }) {
//   return SingleChildScrollView(
//     physics: const AlwaysScrollableScrollPhysics(),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(
//               top: dimen16, left: dimen16, right: dimen16, bottom: dimen8),
//           child: Row(
//             children: <Widget>[
//               Text(
//                 '$title',
//                 style: GoogleFonts.quicksand(
//                     color: color171716,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600),
//               ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(
//             left: dimen16,
//             right: dimen16,
//             bottom: dimen30,
//           ),
//           child: Text(
//             '$description',
//             style: GoogleFonts.quicksand(
//               color: color878998,
//               fontWeight: FontWeight.w400,
//               fontSize: 14,
//             ),
//             textAlign: TextAlign.left,
//             // overflow: TextOverflow.ellipsis,
//           ),
//         ),
//         Container(
//           margin: const EdgeInsets.symmetric(horizontal: dimen16),
//           child: ListView.separated(
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.only(bottom: dimen16),
//                 decoration: const BoxDecoration(
//                   color: colorWhite,
//                   borderRadius: border8,
//                   boxShadow: [
//                     BoxShadow(
//                       color: colorE4E1E1,
//                       offset: Offset(0, dimen4),
//                       blurRadius: dimen24,
//                     ),
//                   ],
//                 ),
//                 clipBehavior: Clip.antiAlias,
//                 child: Material(
//                   color: colorWhite,
//                   child: InkWell(
//                     borderRadius: border8,
//                     onTap: () => [
//                       Get.toNamed(Routes.socialTaskDetail, arguments: {
//                         'task_id': tasks[index].id,
//                         'is_done': tasks[index].taskStart,
//                       })
//                     ],
//                     child: EventItem(task: tasks[index]),
//                   ),
//                 ),
//               );
//             },
//             shrinkWrap: true,
//             physics: const ClampingScrollPhysics(),
//             separatorBuilder: (context, index) => const SizedBox(
//                 // height: 8,
//                 ),
//             itemCount: tasks.length,
//           ),
//         ),
//       ],
//     ),
//   );
// }

// Widget itemMyGroups({required String urlImage, final VoidCallback? onTap}) =>
//     InkWell(
//       onTap: onTap,
//       child: AppCachedImage(
//         imageUrl: urlImage,
//         width: dimen50,
//         height: dimen50,
//         cornerRadius: dimen80,
//         backgroundColor: colorWhite,
//       ),
//     );
