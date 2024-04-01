import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class OverViewScreen extends StatelessWidget {
  final title = Get.arguments['title'];
  OverViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: dimen0,
        leadingWidth: dimen72,
        leading: Padding(
          padding: const EdgeInsets.only(left: dimen24),
          child: AppBackButton(
            onTab: () {
              Get.back();
            },
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: dimen10),
              child: Html(
                data: title ?? '',
                // style: {
                //   "body": Style(
                //     margin: EdgeInsets.zero,
                //     padding: EdgeInsets.zero,
                //     fontSize: FontSize.medium,
                //     color: colorBlack,
                //   )
                //   //   'body': Style(
                //   //     fontSize: const FontSize(dimen14),
                //   //     color: color565C6E,
                //   //     fontWeight: FontWeight.w400,
                //   //     fontStyle: FontStyle.normal,
                //   //   ),
                //   //   'p': Style(
                //   //     fontSize: const FontSize(dimen14),
                //   //     fontWeight: FontWeight.w400,
                //   //   ),
                //   //   'strong': Style(
                //   //     fontSize: const FontSize(dimen14),
                //   //     fontWeight: FontWeight.w400,
                //   //   ),
                // },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
