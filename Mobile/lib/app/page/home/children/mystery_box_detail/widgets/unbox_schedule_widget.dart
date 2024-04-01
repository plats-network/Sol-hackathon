import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class UnboxScheduleWidget extends StatefulWidget {
  const UnboxScheduleWidget({Key? key}) : super(key: key);

  @override
  State<UnboxScheduleWidget> createState() => _UnboxScheduleWidgetState();
}

class _UnboxScheduleWidgetState extends State<UnboxScheduleWidget> {
  @override
  Widget build(BuildContext context) {
    final daysWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'days'.tr,
          style: text12_9C9896_400,
        ),
        verticalSpace4,
        Text(
          '03',
          style: text14_32302D_700,
        ),
      ],
    );

    final hoursWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'hours'.tr,
          style: text12_9C9896_400,
        ),
        verticalSpace4,
        Text(
          '16',
          style: text14_32302D_700,
        ),
      ],
    );

    final minutesWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'minutes'.tr,
          style: text12_9C9896_400,
        ),
        verticalSpace4,
        Text(
          '59',
          style: text14_32302D_700,
        ),
      ],
    );

    return Container(
      decoration: BoxDecoration(
          borderRadius: border24,
          border: Border.all(color: colorC8E9CF, width: dimen1)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          verticalSpace12,
          Text(
            'unbox_schedule'.tr,
            style: text24_469B59_700,
          ),
          verticalSpace8,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              daysWidget,
              horizontalSpace12,
              hoursWidget,
              horizontalSpace12,
              minutesWidget,
            ],
          ),
          verticalSpace12,
        ],
      ),
    );
  }
}
