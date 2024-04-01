import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/qrcode/controller/qrcode_controller.dart';
import 'package:plat_app/app/widgets/app_modern_tabbar.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:flutter_html/flutter_html.dart';
import 'dart:io' show Platform;

import 'package:plat_app/base/routes/base_pages.dart';

class ListSesionScreen extends StatefulWidget {
  final String id;
  final String type;
  final bool flagSession;
  final bool flagBooth;
  final String numSession;
  final String numBooth;
  final dynamic data;
  const ListSesionScreen(
      {Key? key,
      required this.id,
      required this.type,
      required this.data,
      required this.flagSession,
      required this.flagBooth,
      required this.numSession,
      required this.numBooth})
      : super(key: key);

  @override
  State<ListSesionScreen> createState() => _ListSesionScreenState();
}

class _ListSesionScreenState extends State<ListSesionScreen>
    with TickerProviderStateMixin {
  final QrCodeController qrCodeController = Get.find();
  final List<String> menuItemList = [];
  TabController? tabController;

  final isOverviewCollapsed = true.obs;
  toggleOverviewCollapsed() {
    isOverviewCollapsed.value = !isOverviewCollapsed.value;
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.data.taskEvent
          ?.forEach((unit) => menuItemList.add(unit.type as String));
    });
    tabController = TabController(length: menuItemList.length, vsync: this);
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget tabBar = AppModernTabBar(
      controller: tabController as TabController,
      menuItemList: menuItemList,
    );

    return Obx(
      () => Stack(
        children: [
          CommonAppBarPage(
            isHeader: false,
            title: ''.tr,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          getAssetImage(AssetImagePath.backgroud_plats)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: dimen2),
                          child: tabBar),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            for (int i = 0; i < menuItemList.length; i++)
                              tabItem(i)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: dimen0,
                  left: dimen16,
                  right: dimen16,
                  child: GestureDetector(
                    onTap: () {
                      // Get.back();
                      Get.toNamed(Routes.socialTaskDetail, arguments: {
                        'task_id': widget.id,
                        'is_done': true,
                        'is_back': true,
                      });
                    },
                    child: Container(
                      margin: Platform.isIOS &&
                              MediaQuery.of(context).size.height >= 812
                          ? const EdgeInsets.only(top: dimen10, bottom: dimen24)
                          : const EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: color1D93E3,
                        borderRadius: BorderRadius.circular(dimen8),
                      ),
                      child: Center(
                        child: Text(
                          'Go to event '.tr,
                          style: const TextStyle(
                            color: colorWhite,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          qrCodeController.isFetchingResultQrCode()
              ? const FullScreenProgress()
              : Container()
        ],
      ),
    );
  }

  Widget tabItem(int index) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(
          left: dimen24,
          right: dimen24,
          top: dimen60,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            index == 0
                ? widget.numSession != ''
                    ? Row(
                        children: [
                          const Text(
                            'Your lucky draw code is',
                            style: TextStyle(
                              color: color177FE2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.numSession,
                            style: const TextStyle(
                              color: colorBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        'Complete all tasks to get the lucky draw code!',
                        style: TextStyle(
                          color: color177FE2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                : const SizedBox(),
            index == 1
                ? widget.numBooth != ''
                    ? Row(
                        children: [
                          const Text(
                            'Your lucky draw code is',
                            style: TextStyle(
                              color: color177FE2,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.numBooth,
                            style: const TextStyle(
                              color: colorBlack,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )
                    : const Text(
                        'Complete all tasks to get the lucky draw code!',
                        style: TextStyle(
                          color: color177FE2,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                : const SizedBox(),
            verticalSpace10,
            Text(
              '${widget.data.taskEvent?[index].name}',
              style: const TextStyle(
                color: colorBlack,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            // const Text(
            //   'Booth 02',
            //   style: TextStyle(
            //     fontSize: 14,
            //   ),
            // ),
            verticalSpace20,
            Html(
              data: widget.data.taskEvent?[index].description ?? '',
              // style: {
              //   "body": Style(
              //     margin: EdgeInsets.zero,
              //     padding: EdgeInsets.zero,
              //     color: color878998,
              //     fontSize: const FontSize(dimen13),
              //     fontWeight: FontWeight.w400,
              //     maxLines: isOverviewCollapsed.value ? 1 : null,
              //   )
              // },
            ),
            InkWell(
              onTap: () {
                toggleOverviewCollapsed();
              },
              child: Text(
                isOverviewCollapsed.value ? 'more'.tr : 'show_less'.tr,
                style: text14_177FE2_600,
              ),
            ),
            verticalSpace10,
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                itemCount: widget.data.taskEvent?[index].jobs?.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: dimen10,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: dimen22,
                          height: dimen22,
                          decoration: BoxDecoration(
                            color: qrCodeController
                                        .resultQrCode
                                        .value
                                        .data
                                        ?.data
                                        ?.taskEvent?[index]
                                        .jobs?[i]
                                        .statusDone ==
                                    true
                                ? color27AE60
                                : colorWhite,
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: qrCodeController
                                          .resultQrCode
                                          .value
                                          .data
                                          ?.data
                                          ?.taskEvent?[index]
                                          .jobs?[i]
                                          .statusDone ==
                                      true
                                  ? dimen0
                                  : dimen2,
                              color: colorB7BBCB,
                            ),
                          ),
                          child: widget.data.taskEvent?[index].jobs?[i]
                                      .statusDone ==
                                  true
                              ? Image(
                                  image: AssetImage(
                                    getAssetImage(AssetImagePath.check),
                                  ),
                                  width: dimen20,
                                  height: dimen20,
                                )
                              : const SizedBox(),
                        ),
                        horizontalSpace12,
                        Text(
                          '${widget.data.taskEvent?[index].jobs?[i].name}',
                          style: TextStyle(
                            color: qrCodeController
                                        .resultQrCode
                                        .value
                                        .data
                                        ?.data
                                        ?.taskEvent?[index]
                                        .jobs?[i]
                                        .statusDone ==
                                    true
                                ? color1D71F2
                                : colorB7BBCB,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            verticalSpace70,
          ],
        ),
      ),
    );
  }
}
