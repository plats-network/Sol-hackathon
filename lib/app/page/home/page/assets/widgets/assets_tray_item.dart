import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class AssetsTrayItem extends StatefulWidget {
  final String image;
  final String name;
  final String amount;
  final String approx;
  final int? time;
  final bool noBottomRow;
  final VoidCallback? onSendToMainTrayTap;

  const AssetsTrayItem({
    super.key,
    this.image = 'https://i.imgur.com/EEfVkX7.png',
    this.name = '',
    this.amount = '',
    this.approx = '',
    this.time,
    this.noBottomRow = false,
    this.onSendToMainTrayTap,
  });

  @override
  State<AssetsTrayItem> createState() => _AssetsTrayItemState();
}

class _AssetsTrayItemState extends State<AssetsTrayItem> {
  String parseUnlockTimeFromUnix(int time) {
    if (isTrayItemUnlocked()) {
      return 'Unlocked';
    }

    final dayDiff = DateTime.fromMillisecondsSinceEpoch(time * 1000)
        .difference(DateTime.now())
        .inDays;
    final hourDiff = DateTime.fromMillisecondsSinceEpoch(time * 1000)
            .difference(DateTime.now())
            .inHours %
        24;
    final minuteDiff = DateTime.fromMillisecondsSinceEpoch(time * 1000)
            .difference(DateTime.now())
            .inMinutes %
        60;

    final dayText = dayDiff <= 0
        ? ''
        : dayDiff == 1
            ? '$dayDiff Day '
            : '$dayDiff Days ';
    final hourText = hourDiff <= 0
        ? ''
        : hourDiff == 1
            ? '$hourDiff Hour '
            : '$hourDiff Hours ';
    final minuteText = minuteDiff <= 0
        ? ''
        : minuteDiff == 1
            ? '$minuteDiff Minute '
            : '$minuteDiff Minutes ';

    return '$dayText$hourText$minuteText' 'to unlock';
  }

  bool isTrayItemUnlocked() {
    return (widget.time ?? 0) <= DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecoratedBox(
                      decoration: BoxDecoration(borderRadius: border50),
                      child: AppCachedImage(
                        imageUrl: widget.image,
                        width: dimen32,
                        height: dimen32,
                        fit: BoxFit.contain,
                        cornerRadius: dimen50,
                      ),
                    ),
                    horizontalSpace8,
                    Flexible(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.name,
                              style: text14_32302D_700,
                              // overflow: TextOverflow.ellipsis,
                            ),
                            widget.amount.isNotEmpty
                                ? Column(
                                    children: [
                                      verticalSpace4,
                                      Text(
                                        widget.amount,
                                        style: text12_9C9896_400,
                                      ),
                                    ],
                                  )
                                : Container(),
                          ]),
                    )
                  ],
                ),
                // Text(mockTrayListItem)
              ],
            ),
          ),

          // right column
          widget.amount.isNotEmpty && widget.approx.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(widget.amount, style: text12_9C9896_400),
                    verticalSpace7,
                    Text('≈ ${widget.approx} \$', style: text14_469B59_700),
                  ],
                )
              : Container(),
        ]),
        !widget.noBottomRow
            ? Column(
                children: [
                  verticalSpace12,
                  // bottom row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(dimen4),
                        decoration: const BoxDecoration(color: colorE9F4EC),
                        child: Text(parseUnlockTimeFromUnix(widget.time ?? 0),
                            style: text10_469B59_400),
                      ),
                      widget.onSendToMainTrayTap != null
                          ? AppButton(
                              title: 'send_to_main_tray'.tr,
                              horizontalPadding: dimen12,
                              height: dimen28,
                              isPrimaryStyle: false,
                              isEnable: isTrayItemUnlocked(),
                              onTap: widget.onSendToMainTrayTap,
                            )
                          : Container()
                    ],
                  )
                ],
              )
            : Container()
      ],
    );
  }
}
