import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class CommonAppBarPage extends StatelessWidget {
  const CommonAppBarPage({
    Key? key,
    required this.title,
    required this.child,
    this.padding = const EdgeInsets.fromLTRB(dimen0, dimen0, dimen10, dimen0),
    this.onBackButtonClick,
    this.isBack = true,
    this.isHeader = true,
  }) : super(key: key);
  final String title;
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onBackButtonClick;
  final bool isBack;
  final bool isHeader;

  @override
  Widget build(BuildContext context) {
    final backButton = Padding(
      padding: padding,
      child: AppBackButton(
        onTab: () {
          (onBackButtonClick ?? Get.back)();
        },
      ),
    );
    final titleWidget = Text(
      title,
      style: GoogleFonts.quicksand(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: color0E4C88,
      ),
    );
    final headerWidget = Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: dimen16,
        vertical: dimen4,
      ),
      child: Row(
        children: [
          isBack ? backButton : Container(),
          titleWidget,
        ],
      ),
    );

    return Material(
      child: Scaffold(
        backgroundColor: colorWhite,
        body: SafeArea(
          bottom: false,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              isHeader ? headerWidget : const SizedBox(),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
