// import 'package:flutter/material.dart';
// import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
// import 'package:plat_app/app/page/home/page/assets/controller/assets_controller.dart';
// import 'package:plat_app/app/page/home/page/assets/view/lock_tray/controller/lock_tray_controller.dart';
// import 'package:get/get.dart';
// import 'package:plat_app/base/component/spacer/assets_spacer.dart';
// import 'package:plat_app/app/page/home/page/assets/widgets/assets_tray_item.dart';
// import 'package:plat_app/app/page/home/page/assets/widgets/assets_tray_item_shimmer.dart';
// import 'package:plat_app/app/widgets/app_shimmer.dart';
// import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
// import 'package:plat_app/base/resources/constants/base_constraint.dart';
// import 'package:plat_app/base/resources/constants/base_text_styles.dart';
// import 'package:plat_app/base/resources/constants/dimens.dart';
// import 'package:plat_app/base/resources/network/network_resource.dart';

// class LockTray extends StatefulWidget {
//   final TabController topController;
//   const LockTray({super.key, required this.topController});

//   @override
//   State<LockTray> createState() => _LockTrayState();
// }

// class _LockTrayState extends State<LockTray> {
//   final LockTrayController lockTrayController = Get.find();
//   final AssetsController assetController = Get.find();
//   final ScrollController scrollController = ScrollController();
//   late Worker sendToMainTrayWorker;

//   @override
//   void initState() {
//     super.initState();
//     lockTrayController.fetchLockItemList();

//     sendToMainTrayWorker =
//         ever(lockTrayController.sendToMainTrayData, (NetworkResource callback) {
//       if (callback.isSuccess()) {
//         widget.topController.animateTo(1);
//         assetController.setMainTrayCategoryIndex(2);

//         // Refetch
//         lockTrayController.fetchLockItemList();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     sendToMainTrayWorker.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final shimmerListView = ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return Container(
//                 margin: const EdgeInsets.only(
//                     left: dimen16,
//                     right: dimen16,
//                     top: dimen27,
//                     bottom: dimen24),
//                 child: const AssetsTrayItemShimmer());
//           },
//           separatorBuilder: (context, index) => const AppSpacer(),
//           itemCount: 5);

//       final Widget emptyItemWidget =
//           Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//         Image.asset(
//           getAssetImage(AssetImagePath.no_lock_tray_item),
//           width: dimen180,
//           height: dimen150,
//         ),
//         verticalSpace16,
//         Text('no_tray_item'.tr, style: text14_625F5C_400)
//       ]);

//       final lockTraySingleScrollView = SingleChildScrollView(
//         controller: scrollController,
//         child: ListView.separated(
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             if (index == lockTrayController.lockItemList.length) {
//               return Obx(() => lockTrayController.isLockItemListLoading()
//                   ? Container(
//                       margin: EdgeInsets.only(top: dimen16),
//                       child: Center(
//                         child: CircularProgressIndicator(
//                           strokeWidth: dimen2,
//                         ),
//                       ),
//                     )
//                   : !lockTrayController.hasNextPage() &&
//                           lockTrayController.lockItemList.isNotEmpty
//                       ? Container(
//                           margin: EdgeInsets.symmetric(vertical: dimen16),
//                           child: Center(
//                             child: Text(
//                               'no_more_data'.tr,
//                               style: text14_625F5C_400,
//                             ),
//                           ),
//                         )
//                       : const SizedBox());
//             }

//             return Container(
//               margin: const EdgeInsets.only(
//                   left: dimen16, right: dimen16, top: dimen27, bottom: dimen24),
//               child: AssetsTrayItem(
//                 image: lockTrayController.lockItemList[index].icon ?? '',
//                 // amount: lockTrayController.lockItemList[index]['amount'] ?? '',
//                 // approx: lockTrayController.lockItemList[index]['approx'] ?? '',
//                 name: lockTrayController.lockItemList[index].name ?? '',
//                 // price: lockTrayController.lockItemList[index]['price'] ?? '',
//                 time: int.parse(
//                     lockTrayController.lockItemList[index].timeStamp ?? ''),
//                 onSendToMainTrayTap: () {
//                   if (lockTrayController.lockItemList[index].id != null) {
//                     lockTrayController.sendToMainTray(
//                         lockTrayController.lockItemList[index].id ?? '');

//                     logEvent(
//                         eventName: 'ASSETS_SEND_TO_MAIN_TRAY',
//                         eventParameters: {
//                           'box_id':
//                               lockTrayController.lockItemList[index].id ?? '',
//                         });
//                   }
//                 },
//               ),
//             );
//           },
//           separatorBuilder: (context, index) => const AppSpacer(),
//           itemCount: lockTrayController.lockItemList.length + 1,
//         ),
//       );

//       return lockTrayController.lockItemList.isEmpty
//           ? lockTrayController.isLockItemListLoading()
//               ? shimmerListView
//               : emptyItemWidget
//           : NotificationListener(
//               onNotification: (notification) {
//                 if (notification is ScrollEndNotification) {
//                   if (notification.metrics.pixels >=
//                       notification.metrics.maxScrollExtent - dimen200) {
//                     lockTrayController.loadMoreLockItem();
//                   }
//                 }
//                 return true;
//               },
//               child: lockTraySingleScrollView,
//             );
//     });
//   }
// }
