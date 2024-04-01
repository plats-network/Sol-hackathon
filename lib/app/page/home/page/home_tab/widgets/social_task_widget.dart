import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/social_task_list_response.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class SocialTaskWidget extends StatelessWidget {
  final List<Data> tasks;

  const SocialTaskWidget({Key? key, required this.tasks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: colorWhite,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(dimen16),
                child: Row(
                  children: <Widget>[
                    Text(
                      'task_pool'.tr,
                      style: text18_32302D_700,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.socialList);
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
                    double calculateCurrentProgress() {
                      final currentProgress = tasks[index].socials?.length !=
                              null
                          ? tasks[index].socials?.fold<int>(
                                  0,
                                  (previousValue, element) =>
                                      previousValue + (element.action?.status == true ? 1 : 0)) ??
                              0
                          : 0;
                      return currentProgress / (tasks[index].socials?.length ?? 1);
                    }
                    return Container(
                      decoration: const BoxDecoration(
                        color: colorWhite,
                        borderRadius: border16,
                        boxShadow: [
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
                          onTap: () => Get.toNamed(Routes.socialTaskDetail,
                              arguments: {'task_id': tasks[index].id, 'is_done': false}),
                          child: SocialTaskItem(
                            name: tasks[index].name,
                            rewards: tasks[index].rewards,
                            coverUrl: tasks[index].coverUrl,
                            progress: calculateCurrentProgress(),
                            isDone: tasks[index].isDone,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: min(4, tasks.length),
                ),
              ),
              verticalSpace16
            ]));
  }
}

class SocialTaskItem extends StatelessWidget {
  final String? name;
  final Rewards? rewards;
  final String? coverUrl;
  final double? progress;
  final bool? isDone;

  const SocialTaskItem({Key? key, this.name, this.rewards, this.coverUrl, this.progress, this.isDone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imgSize = dimen96;

    return SizedBox(
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
                      imageUrl: coverUrl ?? '',
                      width: double.infinity,
                      height: dimen125,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: dimen12,
                    left: dimen16,
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: border3,
                        color: color469B59,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: dimen6,
                          right: dimen6,
                          top: dimen2,
                          bottom: dimen2,
                        ),
                        child: Text(
                          'Social task'.tr,
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
                    name.toString(),
                    style: text14_32302D_700,
                    maxLines: dimen3.toInt(),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: dimen12),
                  margin: EdgeInsets.only(top: dimen10, bottom: dimen6),
                  decoration: BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(dimen20),
                    child: LinearProgressIndicator(
                      value: progress ?? 0.0,
                      backgroundColor: colorE4E1E1,
                      color: isDone == true ? color00FA9A : colorEA4335,
                      minHeight: dimen10,
                    ),
                  ),
                ),
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
                             isDone == true ? SizedBox() : Text('Reward'.tr, style: text10_9C9896_400) ,
                              Row(
                                children: [
                                  Text(
                                    rewards?.name.toString() ?? '',
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
