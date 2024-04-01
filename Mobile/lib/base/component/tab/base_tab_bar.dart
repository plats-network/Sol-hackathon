import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class BaseTabBar extends StatefulWidget {
  final List<String> tabs;

  int currentIndex;
  List<Widget> tabViews;

  BaseTabBar(
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
  State<BaseTabBar> createState() => _BaseTabBarState();
}

class _BaseTabBarState extends State<BaseTabBar> with TickerProviderStateMixin {
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
          child: Text(
            tab,
            style: TextStyle(
                color:
                    (widget.currentIndex == index) ? color2C2C2C : color898989),
          ),
        )));
    return Column(
      children: [
        ColoredBox(
          color: colorWhite,
          child: Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: colorDCDCDC, width: dimen2),
                  ),
                ),
              ),
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
