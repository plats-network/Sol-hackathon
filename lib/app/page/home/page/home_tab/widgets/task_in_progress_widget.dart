import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/task_perform/model/doing_task_response.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class TaskInProgressWidget extends StatelessWidget {
  final Task? task;
  const TaskInProgressWidget({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorWhite,
      height: dimen235,
      child: Padding(
        padding: const EdgeInsets.all(dimen16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: dimen16),
              child: Text(
                'task_in_progress'.tr,
                style: text18_32302D_700,
              ),
            ),
            SizedBox(
              height: dimen154,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppCachedImage(
                    width: dimen161,
                    height: dimen154,
                    imageUrl: task!.coverUrl ?? '',
                    fit: BoxFit.cover,
                    cornerRadius: dimen16,
                  ),
                  horizontalSpace16,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          task?.name.toString() ?? '',
                          style: text16_32302D_700,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: dimen34),
                          child: AppButton(
                            margin: dimen0,
                            horizontalPadding: dimen4,
                            isPrimaryStyle: false,
                            title: 'back_to_task'.tr,
                            onTap: () {
                              Get.toNamed(Routes.taskPerform,
                                  arguments: {'task_id': task?.id});
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
