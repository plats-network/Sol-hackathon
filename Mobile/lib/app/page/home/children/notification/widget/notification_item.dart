import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/notification/controller/notification_controller.dart';
import 'package:plat_app/app/page/home/model/list_notifications_response.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({
    Key? key,
    required this.notification,
    required this.type,
  }) : super(key: key);

  final Data? notification;

  /// - ko có type lấy all
  /// - type=0: New task
  /// - type=1: Unbox
  final int? type;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  final NotificationController notificationController = Get.find();
  late Rx<bool> isRead = Rx(widget.notification?.isRead == true);

  /// Format string either normal or bold
  ///
  /// Example
  /// Sample 1:
  /// Input: Hello {{world}}
  /// Output: "Hello" in normal text style, "world" in bold text style
  /// Sample 2: All other cases that is invalid, return normal text style
  /// Input: Hello {{world! How are you?
  /// Output: Hello world! How are you? in normal text style
  List<TextSpan> parseStringToTextSpan(String text) {
    // split text either by {{ or }}
    final List<String> textList =
        text.split(RegExp(r'\s*(?={{.*?}})|(?<={{.*?}})\s*'));
    const normalTextColor = text16_32302D_400;
    const boldTextColor = text16_32302D_600;
    final boldRegex = RegExp(r'{{|}}');

    //if match is odd
    if (boldRegex.allMatches(text).length % 2 != 0) {
      return [
        TextSpan(text: text.replaceAll(boldRegex, ''), style: normalTextColor)
      ];
    }

    // If text list is 1 in length, means there is no bold text or text is invalid
    if (textList.length == 1) {
      return [
        TextSpan(
          text: textList[0].replaceAll(boldRegex, ''),
          style: normalTextColor,
        )
      ];
    }

    // Mapping text list to text span
    final textSpanList = textList.asMap().entries.map((element) {
      final text = textList[element.key].replaceAll(boldRegex, '');
      final isBold = textList[element.key].contains(boldRegex);

      return TextSpan(
          text: element.key == 0 ? text : ' $text',
          style: isBold ? boldTextColor : normalTextColor);
    });

    return textSpanList.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Material(
        color: isRead.value ? Colors.white : colorE8F2FC,
        child: InkWell(
          onTap: () async {
            if (widget.notification?.data?.action == 'NEW_TASK') {
              final taskType = await notificationController
                  .fetchTaskType(widget.notification?.data?.taskId ?? "");

              switch (taskType) {
                case 'social':
                  Get.toNamed(Routes.socialTaskDetail, arguments: {
                    'task_id': widget.notification?.data?.taskId, 
                    'is_done': false,
                  });
                  break;
                case 'check_in':
                  Get.toNamed(Routes.taskDetail, arguments: {
                    'task_id': widget.notification?.data?.taskId
                  });
                  break;
                default:
                  Get.toNamed(Routes.taskDetail, arguments: {
                    'task_id': widget.notification?.data?.taskId
                  });
                  break;
              }
            } else if (widget.notification?.data?.action == 'UNBOX') {
              Get.toNamed(Routes.boxDetail,
                  arguments: {'box_id': widget.notification?.data?.taskId});
            }
            if (widget.notification?.id != null) {
              isRead.value = true;
              await notificationController
                  .fetchNotificationDetail(widget.notification?.id);
              if (widget.type == 0) {
                await notificationController.fetchNewTaskListNotifications();
              } else if (widget.type == 1) {
                await notificationController.fetchUnboxListNotifications();
              } else {
                await notificationController.fetchListNotifications();
              }
            }
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: colorF3F1F1)),
            ),
            padding:
                EdgeInsets.symmetric(horizontal: dimen16, vertical: dimen8),
            child: Row(children: [
              Container(
                child: widget.notification?.icon != null
                    ? AppCachedImage(
                        imageUrl: widget.notification?.icon ?? '',
                        width: dimen48,
                        height: dimen48,
                        cornerRadius: dimen50,
                      )
                    : Container(),
              ),
              horizontalSpace20,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        softWrap: false,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          children: parseStringToTextSpan(
                              widget.notification?.description ?? ''),
                        )),
                    verticalSpace8,
                    widget.notification?.time != null
                        ? Text(widget.notification?.time ?? '',
                            style: text12_898989_400)
                        : Container(),
                  ],
                ),
              ),
            ]),
          ),
        ),
      );
    });
  }
}
