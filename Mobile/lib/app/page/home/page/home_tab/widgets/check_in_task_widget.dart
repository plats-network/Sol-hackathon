import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/check_in_task_list_response.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CheckInTaskWidget extends StatelessWidget {
  final List<Data> tasks;
  const CheckInTaskWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorWhite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(dimen16),
                child: Row(
                  children: <Widget>[
                    Text(
                      'check_in_tasks'.tr,
                      style: text18_32302D_700,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.checkInList);
                      },
                      child: Text('see_more'.tr, style: text14_177FE2_400),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: dimen16),
                child: AlignedGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: dimen16,
                  crossAxisSpacing: dimen16,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      decoration: BoxDecoration(
                        color: colorWhite,
                        borderRadius: border16,
                        boxShadow: const [
                          BoxShadow(
                            color: colorE4E1E1,
                            offset: Offset(0, dimen4),
                            blurRadius: dimen24,
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: Material(
                        color: colorWhite,
                        child: InkWell(
                          borderRadius: border16,
                          onTap: () => Get.toNamed(Routes.taskDetail,
                              arguments: {'task_id': tasks[index].id}),
                          child: TaskItem(task: tasks[index]),
                        ),
                      ),
                    );
                  },
                  itemCount: 4,
                ),
              ),
              verticalSpace16
            ]));
  }
}

class TaskItem extends StatelessWidget {
  final Data task;
  const TaskItem({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //TODO add dimen

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(children: [
                  SizedBox(
                    height: dimen125,
                    width: double.infinity,
                    child: AppCachedImage(
                      imageUrl: task.coverUrl ?? '',
                      width: double.infinity,
                      height: dimen125,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: dimen12,
                    left: dimen16,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: border3,
                        color: color469B59,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: dimen6,
                            right: dimen6,
                            top: dimen2,
                            bottom: dimen2),
                        child: Text(
                          'check_in'.tr,
                          style: text10_white_600,
                        ),
                      ),
                    ),
                  ),
                ]),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: dimen16,
                    vertical: dimen12,
                  ),
                  child: Text(
                    task.name.toString(),
                    style: text14_32302D_700,
                    maxLines: dimen3.toInt(),
                    textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis)),
              ],
            ),
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        top: dimen0, left: dimen16, right: dimen10),
                    child: Row(
                      children: [
                        //image box
                        Image(
                          image: AssetImage(getAssetImage(
                              AssetImagePath.mystery_box_style_1)),
                          width: dimen28,
                          height: dimen28,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: dimen8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Reward'.tr, style: text10_9C9896_400),
                              Row(
                                children: [
                                  // Text(
                                  //   task.rewards?.amount.toString() ?? '',
                                  //   style: text12_32302D_700,
                                  // ),
                                  // horizontalSpace1,
                                  //TODO API return wrong name value "Mystery box." => "Mystery box"
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
                    )),
                verticalSpace20,
              ],
            ),
          ]),
    );
  }
}
