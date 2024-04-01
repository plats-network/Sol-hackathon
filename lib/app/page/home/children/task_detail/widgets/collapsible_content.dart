import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class CollapsibleContent extends StatelessWidget {
  CollapsibleContent({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;
  final isOverviewCollapsed = true.obs;

  toggleOverviewCollapsed() {
    isOverviewCollapsed.value = !isOverviewCollapsed.value;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Text(text,
                  style: text14_625F5C_400,
                  maxLines: isOverviewCollapsed.value ? 4 : null),
            ],
          ),
          verticalSpace8,
          InkWell(
            onTap: () {
              toggleOverviewCollapsed();
            },
            child: Text(
              isOverviewCollapsed.value ? 'more'.tr : 'show_less'.tr,
              style: text14_177FE2_600,
            ),
          ),
        ],
      ),
    );
  }
}
