import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class AppModernTabBar extends StatefulWidget {
  const AppModernTabBar(
      {Key? key, required this.controller, required this.menuItemList})
      : super(key: key);

  // bottom top controller height
  static const indicatorHeight = dimen5;
  final TabController controller;
  final List<String> menuItemList;

  @override
  State<AppModernTabBar> createState() => _AppModernTabBarState();
}

class _AppModernTabBarState extends State<AppModernTabBar> {
  // only change this line
  final double inactiveIndicatorHeight =
      AppModernTabBar.indicatorHeight - AppModernTabBar.indicatorHeight / 4;

  final double inactiveBottom = AppModernTabBar.indicatorHeight / 8;

  var currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    currentIndex.value = widget.controller.index;

    widget.controller.addListener(() {
      currentIndex.value = widget.controller.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Positioned.fill(
        //   bottom: inactiveBottom,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       border: Border(
        //         bottom: BorderSide(
        //             color: colorE8F2FC, width: inactiveIndicatorHeight),
        //       ),
        //     ),
        //   ),
        // ),
        Align(
          alignment: Alignment.centerLeft,
          child: TabBar(
            controller: widget.controller,
            isScrollable: true,
            labelColor: colorWhite,
            unselectedLabelColor: color30A1DB,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight: 0,
            labelPadding: const EdgeInsets.symmetric(horizontal: 4.3),
            indicator: const BubbleTabIndicator(
              indicatorHeight: 30.0,
              indicatorColor: color30A1DB,
              indicatorRadius: 5,
              tabBarIndicatorSize: TabBarIndicatorSize.tab,

              // padding:  EdgeInsets.zero,
              // insets:EdgeInsets.zero,
            ),
            // indicator: BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(
            //       color: color177FE2,
            //       width: AppModernTabBar.indicatorHeight,
            //     ),
            //   ),
            // ),
            tabs: List.generate(
              widget.menuItemList.length,
              (index) => Tab(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(width: 1, color: color30A1DB),
                  ),
                  child: Text(
                    widget.menuItemList[index],
                    style: GoogleFonts.quicksand(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              //  Tab(
              //     child: Obx(
              //   () => Text(
              //     widget.menuItemList[index],
              //     style: currentIndex.value == index
              //         ? text14_177FE2_600
              //         : text14_9C9896_600,
              //   ),
              // )),
            ),
          ),
        ),
      ],
    );
  }
}
