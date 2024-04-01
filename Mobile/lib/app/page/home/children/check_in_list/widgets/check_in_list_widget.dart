import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/check_in_task_list_response.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class CheckInListWidget extends StatelessWidget {
  final List<Data> tasks;
  const CheckInListWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorWhite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                child: ListView.builder(
                  padding: const EdgeInsets.only(
                      top: dimen0,
                      left: dimen16,
                      right: dimen16,
                      bottom: dimen16),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    //TODO add animation
                    return GestureDetector(
                      child: TaskItem(task: tasks[index]),
                      onTap: () {
                        Get.toNamed(Routes.taskDetail,
                            arguments: {'task_id': tasks[index].id});
                      },
                    );
                  },
                ),
              )
            ]));
  }
}

class TaskItem extends StatelessWidget {
  final Data task;
  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: dimen8, bottom: dimen8),
      child: Container(
        height: dimen309,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: colorWhite,
          borderRadius: border16,
          boxShadow: [
            BoxShadow(
              color: colorE4E1E1,
              blurRadius: dimen3,
            ),
          ],
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: dimen190,
                    width: double.infinity,
                    child: AppCachedImage(
                      imageUrl: task.coverUrl ?? '',
                      width: double.infinity,
                      height: dimen190,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: dimen12,
                    left: dimen16,
                    child: Container(
                      height: dimen16,
                      decoration: const BoxDecoration(
                          color: color469B59, borderRadius: border3),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: dimen6,
                          right: dimen6,
                        ),
                        child: Text(
                          'check_in'.tr,
                          style: text10_white_600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  height: dimen71,
                  padding: const EdgeInsets.only(
                      top: dimen12,
                      left: dimen16,
                      right: dimen16,
                      bottom: dimen12),
                  child: Text(task.name.toString(),
                      style: text16_32302D_700_24,
                      maxLines: 2,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis)),
              Container(
                  padding: const EdgeInsets.only(
                      top: dimen0, left: dimen16, right: dimen10),
                  child: Row(
                    children: [
                      AppCachedImage(
                          imageUrl: task.rewards?.image ?? "",
                          width: dimen28,
                          height: dimen28),
                      Padding(
                        padding: const EdgeInsets.only(left: dimen8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(task.rewards?.name ?? "",
                                style: text10_9C9896_400,
                                maxLines: 1,
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis),
                            Row(
                              children: [
                                Text(
                                  task.rewards?.name.toString() ?? '',
                                  style: text12_32302D_700,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }
}
