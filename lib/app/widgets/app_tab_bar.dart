import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';

class AppTabBar extends StatefulWidget {
  final List<String> tabs;

  int currentIndex;
  List<Widget> tabViews;

  AppTabBar(
      {Key? key,
      required this.tabs,
      required this.currentIndex,
      required this.tabViews})
      : super(key: key) {
    // Validate values
    if (currentIndex > tabs.length - 1) {
      currentIndex = 0;
    }
  }

  @override
  State<AppTabBar> createState() => _AppTabBarState();
}

class _AppTabBarState extends State<AppTabBar> with TickerProviderStateMixin {
  late TabController tabController;
  late TabBarView tabBarView;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
      initialIndex: widget.currentIndex,
      length: widget.tabs.length,
      vsync: this,
    );
    tabController.addListener(() {
      setState(() {
        widget.currentIndex = tabController.index;
      });
    });
    tabBarView = TabBarView(
      controller: tabController,
      children: widget.tabViews,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Tab> tabs = <Tab>[];
    widget.tabs.asMap().forEach((index, tab) => tabs.add(Tab(
          child: Text(tab,
              style: (widget.currentIndex == index)
                  ? text14_primary_600
                  : text14_898989_600),
        )));
    return Column(
      children: [
        ColoredBox(
          color: colorWhite,
          child: Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.bottomCenter,
            children: [
              TabBar(
                controller: tabController,
                tabs: tabs,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: colorPrimary, width: dimen2),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: tabBarView)
      ],
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}
