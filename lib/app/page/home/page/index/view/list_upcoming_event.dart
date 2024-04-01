import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
import 'package:plat_app/app/page/home/page/index/model/trending_event_reponse.dart';
import 'package:plat_app/app/widgets/app_cached_image.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/task_pool_list_reponse.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class ListUpcomingEventPage extends StatefulWidget {
  const ListUpcomingEventPage({Key? key}) : super(key: key);

  @override
  State<ListUpcomingEventPage> createState() => _ListUpcomingEventPageState();
}

class _ListUpcomingEventPageState extends State<ListUpcomingEventPage> {
  final IndexController indexController = Get.find();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      indexController.fetchUpcomingEvent();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: colorWhite,
        body: CommonAppBarPage(
          title: 'Upcoming Events'.tr,
          child: RefreshIndicator(
            displacement: dimen100,
            backgroundColor: colorWhite,
            color: colorPrimary,
            strokeWidth: dimen3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              indexController.fetchUpcomingEvent();
            },
            child: Stack(
              children: [
                Container(
                  color: colorWhite,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: tabPage(
                    tasks: indexController.upcomingEvent.value.data?.data ?? [],
                    description:
                        'Be an early registrant for upcoming events to receive event-exclusive benefits.',
                    title: '',
                  ),
                ),
                indexController.isFetchingUpcomingEvent()
                    ? const FullScreenProgress()
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget tabPage({
    String? title,
    String? description,
    required List<EventData> tasks,
  }) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: dimen16,
              right: dimen16,
              bottom: dimen30,
              top: dimen24,
            ),
            child: Text(
              '$description',
              style: text14_32302D_700.copyWith(
                color: color878998,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            // padding: const EdgeInsets.symmetric(horizontal: dimen16),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: dimen16),
                  decoration: const BoxDecoration(
                    color: colorWhite,
                    borderRadius: border8,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Material(
                    color: colorWhite,
                    child: InkWell(
                      borderRadius: border8,
                      onTap: () => [
                        Get.toNamed(Routes.socialTaskDetail, arguments: {
                          'task_id': tasks[index].id,
                          'is_done': false,
                        })
                      ],
                      child: itemEvent(task: tasks[index]),
                    ),
                  ),
                );
              },
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              separatorBuilder: (context, index) => const SizedBox(
                  // height: 8,
                  ),
              itemCount: tasks.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget itemEvent({required EventData task}) {
    return Container(
      margin: const EdgeInsets.only(bottom: dimen0),
      width: MediaQuery.of(context).size.width,
      height: 190,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: dimen45,
                height: dimen60,
                decoration: BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.circular(dimen12),
                  boxShadow: const [
                    BoxShadow(
                      color: colorDCDCDC,
                      blurRadius: dimen4,
                      offset: Offset(0, dimen2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      task.date.toString().split('-')[0],
                      style: GoogleFonts.quicksand(
                        color: colorBlack,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${task.date.toString().split('-')[1]}/${task.date.toString().split('-')[2].split(" ")[0].substring(2)}',
                      style: GoogleFonts.quicksand(
                        color: color9C9C9C,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace10,
              const DottedLine(
                direction: Axis.vertical,
                lineLength: 120,
                lineThickness: 1.5,
                dashLength: 4.0,
                dashColor: colorE5E5E5,
                dashRadius: 40.0,
                dashGapLength: 12.0,
              )
            ],
          ),
          horizontalSpace16,
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: colorBlack,
                    borderRadius: BorderRadius.circular(dimen8),
                    boxShadow: const [
                      BoxShadow(
                        color: colorDCDCDC,
                        blurRadius: dimen4,
                        offset: Offset(0, dimen2),
                      ),
                    ],
                    image: DecorationImage(
                      // colorFilter: ColorFilter.mode(
                      //   colorBlack.withOpacity(.5),
                      //   BlendMode.multiply,
                      // ),
                      image: CachedNetworkImageProvider(
                        task.bannerUrl ?? '',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 170,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(dimen8),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(0, 0, 0, 0),
                        Color(0x00000000),
                        Color.fromARGB(179, 0, 0, 0),
                        Color.fromARGB(235, 0, 0, 0),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: dimen10,
                  bottom: dimen10,
                  right: dimen20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.name ?? "",
                        style: GoogleFonts.quicksand(
                          color: colorWhite,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          // fontStyle: FontStyle.italic,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            getAssetImage(AssetImagePath.location_pin),
                            fit: BoxFit.cover,
                            width: dimen10,
                            height: dimen10,
                            color: color30A1DB,
                          ),
                          horizontalSpace2,
                          Expanded(
                            child: Text(
                              task.address ?? '',
                              style: GoogleFonts.quicksand(
                                color: color30A1DB,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   top: dimen6,
                //   right: dimen6,
                //   child: Container(
                //     // padding: const EdgeInsets.all(dimen2),
                //     width: 30,
                //     height: 30,
                //     decoration: BoxDecoration(
                //       color: colorDisabledButton.withOpacity(0.3),
                //       borderRadius: BorderRadius.circular(60),
                //     ),
                //     child: Align(
                //       alignment: Alignment.center,
                //       child: LikeButton(
                //         likeCountPadding: EdgeInsets.zero,
                //         onTap: (bool value) async {
                //           // setState(
                //           //   () {
                //           //     isLike = !isLike;
                //           //     eventTasks[index].like?.isLike = isLike;
                //           //     if (isLike == true) {
                //           //       indexController.fetchLikeOrPin(
                //           //           eventTasks[index].id as String, 'like');
                //           //     } else {
                //           //       indexController.fetchLikeOrPin(
                //           //           eventTasks[index].id as String,
                //           //           'unlike');
                //           //     }
                //           //   },
                //           // );
                //           return Future.value(!value);
                //         },
                //         size: 20,
                //         circleColor: const CircleColor(
                //             start: Colors.pink, end: Colors.pinkAccent),
                //         bubblesColor: const BubblesColor(
                //           dotPrimaryColor: Colors.red,
                //           dotSecondaryColor: Colors.redAccent,
                //         ),
                //         likeBuilder: (bool isLiked) {
                //           return const Icon(
                //             Icons.favorite,
                //             color:
                //                 // eventTasks[index].like?.isLike as bool
                //                 //     ? Colors.pink
                //                 //     :
                //                 colorE4E1E1,
                //             size: 18,
                //           );
                //         },
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final Data task;
  final double width;
  const TaskItem({Key? key, required this.task, this.width = 0})
      : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isPin = false;
  final IndexController indexController = Get.find();
  @override
  void initState() {
    super.initState();
    isPin = widget.task.pin?.isPin ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: const EdgeInsets.all(dimen16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: colorFFB800,
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    child: Text(
                      widget.task.postBy ?? '',
                      style: text10_white_600.copyWith(fontSize: 10),
                    ),
                  ),
                ],
              ),
              // task.pin?.isPin == true
              //     ? Image.asset(
              //         getAssetImage(AssetImagePath.pin_bold),
              //         width: dimen16,
              //         height: dimen16,
              //         color: colorEA4335,
              //       )
              //     : Image.asset(
              //         getAssetImage(AssetImagePath.pin),
              //         width: dimen16,
              //         height: dimen16,
              //       ),
              // Container(
              //   child: LikeButton(
              //     isLiked: widget.task.pin?.isPin,
              //     likeCountPadding: EdgeInsets.zero,
              //     onTap: (bool value) async {
              //       setState(
              //         () {
              //           isPin = !isPin;
              //           widget.task.pin?.isPin = isPin;
              //           if (isPin == true) {
              //             indexController.fetchLikeOrPin(
              //                 widget.task.id as String, 'pin');
              //           } else {
              //             indexController.fetchLikeOrPin(
              //                 widget.task.id as String, 'unpin');
              //           }
              //         },
              //       );
              //       return Future.value(!value);
              //     },
              //     size: 20,
              //     circleColor: const CircleColor(
              //       start: colorFFB800,
              //       end: Color.fromARGB(255, 255, 208, 90),
              //     ),
              //     bubblesColor: const BubblesColor(
              //       dotPrimaryColor: Color.fromARGB(255, 255, 208, 90),
              //       dotSecondaryColor: Color.fromARGB(255, 226, 199, 131),
              //     ),
              //     likeBuilder: (bool isLiked) {
              //       return Image.asset(
              //         getAssetImage(
              //           widget.task.pin?.isPin as bool || isPin
              //               ? AssetImagePath.bookmark
              //               : AssetImagePath.bookmark_line,
              //         ),
              //         width: dimen20,
              //         height: dimen20,
              //         color: widget.task.pin?.isPin as bool || isPin
              //             ? colorFFB800
              //             : colorB7BBCB,
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
          verticalSpace10,
          SizedBox(
            height: dimen96,
            child: Row(
              children: [
                SizedBox(
                  height: dimen96,
                  width: dimen96,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: AppCachedImage(
                      imageUrl: widget.task.bannerUrl ?? '',
                      width: double.infinity,
                      height: dimen125,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                horizontalSpace10,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.name.toString(),
                        style: text16_32302D_700,
                        maxLines: dimen2.toInt(),
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Html(
                          data:
                              "<body>${widget.task.description.toString()}</body>",
                          // style: {
                          //   'body': Style(
                          //     fontSize: const FontSize(dimen12),
                          //     color: color565C6E,
                          //     fontWeight: FontWeight.w400,
                          //     fontStyle: FontStyle.normal,
                          //     maxLines: 1,
                          //     padding: EdgeInsets.zero,
                          //     margin: EdgeInsets.zero,
                          //   ),
                          //   'p': Style(
                          //     fontSize: const FontSize(dimen14),
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          //   'strong': Style(
                          //     fontSize: const FontSize(dimen14),
                          //     fontWeight: FontWeight.w400,
                          //   ),
                          // },
                        ),
                        // Text(
                        //   task.description.toString(),
                        //   style: text12_32302D_700.copyWith(
                        //     fontWeight: FontWeight.w400,
                        //   ),
                        //   maxLines: dimen1.toInt(),
                        //   textAlign: TextAlign.left,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${widget.task.taskCheckIn?.length ?? 0} Quests',
                            style: const TextStyle(
                              color: color1266B5,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              overflow: TextOverflow.ellipsis,
                              // fontFamily: 'Termina',
                            ),
                            maxLines: 1,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: colorE8F2FC,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 1, vertical: 1),
                            child: Row(
                              children: [
                                Image.asset(
                                  getAssetImage(
                                      AssetImagePath.mystery_box_large),
                                  width: dimen23,
                                  height: dimen23,
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
