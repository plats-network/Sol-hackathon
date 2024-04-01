import 'package:flutter/material.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/controller/social_task_detail_controller.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class CommonAppPage extends StatefulWidget {
  const CommonAppPage(
      {Key? key,
      required this.children,
      this.appBar,
      this.padding = const EdgeInsets.all(dimen16),
      this.backgroundColor,
      this.hasSafeAreaBottom = true,
      this.hasSafeAreaTop = true,
      this.hasLikeButton = false,
      this.buttom,
      this.onTap})
      : super(key: key);
  final List<Widget> children;
  final PreferredSizeWidget? appBar; // for override default appbar
  final EdgeInsets padding;
  final Color? backgroundColor;
  final bool hasSafeAreaBottom;
  final bool hasSafeAreaTop;
  final bool hasLikeButton;
  final Widget? buttom;
  final Function()? onTap;
  @override
  State<CommonAppPage> createState() => _CommonAppPageState();
}

class _CommonAppPageState extends State<CommonAppPage> {
  final SocialTaskDetailController socialTaskDetailController = Get.find();
  @override
  Widget build(BuildContext context) {
    final backButton = Padding(
      padding: widget.padding,
      child: widget.hasLikeButton
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppBackButton(
                    onTab: widget.onTap ??
                        () {
                          Get.back();
                        }),
                widget.buttom ?? Container(),
              ],
            )
          : AppBackButton(
              onTab: widget.onTap ??
                  () {
                    Get.back();
                  }),
    );

    return Scaffold(
      appBar: widget.appBar,
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        bottom: widget.hasSafeAreaBottom,
        top: widget.hasSafeAreaTop,
        child: Stack(
          children: [
            ...widget.children,
            widget.appBar == null ? backButton : Container(),
          ],
        ),
      ),
    );
  }
}
