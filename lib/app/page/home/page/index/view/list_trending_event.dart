import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
import 'package:plat_app/app/page/home/page/index/model/trending_event_reponse.dart';
import 'package:plat_app/app/widgets/animations/animations.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class ListTrendingEventPage extends StatefulWidget {
  const ListTrendingEventPage({Key? key}) : super(key: key);

  @override
  State<ListTrendingEventPage> createState() => _ListTrendingEventPageState();
}

class _ListTrendingEventPageState extends State<ListTrendingEventPage> {
  final IndexController indexController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      indexController.fetchTrendingEvent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: CommonAppBarPage(
          title: 'Trending Events'.tr,
          child: RefreshIndicator(
            displacement: dimen50,
            backgroundColor: Colors.white,
            color: colorPrimary,
            strokeWidth: dimen3,
            triggerMode: RefreshIndicatorTriggerMode.onEdge,
            onRefresh: () async {
              indexController.fetchTrendingEvent();
            },
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: listTrendingEvents(
                    tasks: indexController.trendingEvent.value.data?.data ?? [],
                    description:
                        'Experience the thrill of the event and reap the rewards. Join now and start winning big!',
                  ),
                ),
                indexController.isFetchingTrendingEvent()
                    ? const FullScreenProgress()
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listTrendingEvents({
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
              style: GoogleFonts.quicksand(
                fontSize: 14,
                color: color878998,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.left,
              // overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: dimen16),
            child: ListView.separated(
              itemBuilder: (context, index) {
                return SlideAnimation(
                  intervalStart: 0.4,
                  begin: const Offset(0, 30),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: dimen16),
                    decoration: const BoxDecoration(
                      color: colorWhite,
                      borderRadius: border8,
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
                        borderRadius: border8,
                        onTap: () => [
                          Get.toNamed(Routes.socialTaskDetail, arguments: {
                            'task_id': tasks[index].id,
                            'is_done': false,
                          })
                        ],
                        child: trendingEventItem(task: tasks[index]),
                      ),
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

  // Widget trendingEventItem(
  //     {required EventData task, double width = 0}) {
  //   return Stack(
  //     children: [
  //       Container(
  //         height: 230,
  //         decoration: BoxDecoration(
  //           image: DecorationImage(
  //             // colorFilter: ColorFilter.mode(
  //             //   colorBlack.withOpacity(.5),
  //             //   BlendMode.multiply,
  //             // ),
  //             image: CachedNetworkImageProvider(
  //               task.bannerUrl ?? '',
  //             ),
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //       ),
  //       Container(
  //         height: dimen230,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(dimen8),
  //           gradient: const LinearGradient(
  //             begin: Alignment.topCenter,
  //             end: Alignment.bottomCenter,
  //             colors: [
  //               Color.fromARGB(0, 0, 0, 0),
  //               Color(0x00000000),
  //               Color.fromARGB(179, 0, 0, 0),
  //               Color.fromARGB(235, 0, 0, 0),
  //             ],
  //           ),
  //         ),
  //       ),
  //       Positioned(
  //         left: dimen16,
  //         bottom: dimen16,
  //         right: dimen16,
  //         child: ClipRect(
  //           child: BackdropFilter(
  //             filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  //             child: Container(
  //               decoration: BoxDecoration(
  //                 color: colorWhite.withOpacity(0.2),
  //                 borderRadius: BorderRadius.circular(8),
  //               ),
  //               padding: const EdgeInsets.symmetric(
  //                   horizontal: dimen10, vertical: dimen10),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text(
  //                     task.name.toString(),
  //                     style: GoogleFonts.quicksand(
  //                       color: colorWhite,
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w700,
  //                     ),
  //                     overflow: TextOverflow.ellipsis,
  //                     maxLines: 2,
  //                   ),
  //                   verticalSpace6,
  //                   Text(
  //                     DateFormat('EEEE, dd MMMM yyyy')
  //                         .format(
  //                           DateFormat('dd-MM-yyyy HH:mm:ss').parse(
  //                             '${task.date}',
  //                           ),
  //                         )
  //                         .toString(),
  //                     style: GoogleFonts.quicksand(
  //                       color: colorWhite,
  //                       fontSize: 10,
  //                       fontWeight: FontWeight.w500,
  //                       // fontStyle: FontStyle.italic,
  //                     ),
  //                     overflow: TextOverflow.ellipsis,
  //                     maxLines: 2,
  //                   ),
  //                   verticalSpace2,
  //                   Row(
  //                     crossAxisAlignment: CrossAxisAlignment.center,
  //                     children: [
  //                       Image.asset(
  //                         getAssetImage(AssetImagePath.location_pin),
  //                         fit: BoxFit.cover,
  //                         width: dimen10,
  //                         height: dimen10,
  //                         color: color30A1DB,
  //                       ),
  //                       horizontalSpace2,
  //                       Expanded(
  //                         child: Text(
  //                           task.address ?? '',
  //                           style: GoogleFonts.quicksand(
  //                             color: color30A1DB,
  //                             fontSize: 10,
  //                             fontWeight: FontWeight.w600,
  //                           ),
  //                           overflow: TextOverflow.ellipsis,
  //                           maxLines: 1,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       // Positioned(
  //       //   top: dimen10,
  //       //   right: dimen10,
  //       //   child: Container(
  //       //     decoration: BoxDecoration(
  //       //       color: colorDisabledButton.withOpacity(0.3),
  //       //       shape: BoxShape.circle,
  //       //     ),
  //       //     padding: const EdgeInsets.all(dimen3),
  //       //     child: LikeButton(
  //       //       isLiked: widget.task.pin?.isPin,
  //       //       likeCountPadding: EdgeInsets.zero,
  //       //       onTap: (bool value) async {
  //       //         setState(
  //       //           () {
  //       //             isPin = !isPin;
  //       //             widget.task.pin?.isPin = isPin;
  //       //             if (isPin == true) {
  //       //               indexController.fetchLikeOrPin(
  //       //                   widget.task.id as String, 'pin');
  //       //             } else {
  //       //               indexController.fetchLikeOrPin(
  //       //                   widget.task.id as String, 'unpin');
  //       //             }
  //       //           },
  //       //         );
  //       //         return Future.value(!value);
  //       //       },
  //       //       size: 20,
  //       //       circleColor:
  //       //           const CircleColor(start: Colors.pink, end: Colors.pinkAccent),
  //       //       bubblesColor: const BubblesColor(
  //       //         dotPrimaryColor: Colors.red,
  //       //         dotSecondaryColor: Colors.redAccent,
  //       //       ),
  //       //       likeBuilder: (bool isLiked) {
  //       //         return Icon(
  //       //           Icons.favorite,
  //       //           color: widget.task.pin?.isPin as bool || isPin
  //       //               ? Colors.pink
  //       //               : colorWhite,
  //       //           size: 20,
  //       //         );
  //       //       },
  //       //     ),
  //       //   ),
  //       // ),
  //       Positioned(
  //         top: dimen10,
  //         left: dimen10,
  //         child: Row(
  //           children: [
  //             Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(dimen60),
  //                 color: colorWhite,
  //               ),
  //               padding: const EdgeInsets.symmetric(
  //                   horizontal: dimen10, vertical: dimen6),
  //               child: Text(
  //                 'Free on Plats',
  //                 style: GoogleFonts.quicksand(
  //                   color: colorBlack,
  //                   fontSize: 10,
  //                   fontWeight: FontWeight.w600,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }
  Widget trendingEventItem({required EventData task, double width = 0}) {
    return Stack(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
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
          height: dimen200,
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
                task.name.toString(),
                style: GoogleFonts.quicksand(
                  color: colorWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              verticalSpace8,
              Text(
                DateFormat('EEEE, dd MMMM yyyy')
                    .format(
                      DateFormat('dd-MM-yyyy HH:mm:ss').parse(
                        '${task.date}',
                      ),
                    )
                    .toString(),
                style: GoogleFonts.quicksand(
                  color: colorWhite,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  // fontStyle: FontStyle.italic,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              verticalSpace2,
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
        //   top: dimen10,
        //   right: dimen10,
        //   child: Container(
        //     decoration: BoxDecoration(
        //       color: colorDisabledButton.withOpacity(0.3),
        //       shape: BoxShape.circle,
        //     ),
        //     padding: const EdgeInsets.all(dimen3),
        //     child: LikeButton(
        //       isLiked: widget.task.pin?.isPin,
        //       likeCountPadding: EdgeInsets.zero,
        //       onTap: (bool value) async {
        //         setState(
        //           () {
        //             isPin = !isPin;
        //             widget.task.pin?.isPin = isPin;
        //             if (isPin == true) {
        //               indexController.fetchLikeOrPin(
        //                   widget.task.id as String, 'pin');
        //             } else {
        //               indexController.fetchLikeOrPin(
        //                   widget.task.id as String, 'unpin');
        //             }
        //           },
        //         );
        //         return Future.value(!value);
        //       },
        //       size: 20,
        //       circleColor:
        //           const CircleColor(start: Colors.pink, end: Colors.pinkAccent),
        //       bubblesColor: const BubblesColor(
        //         dotPrimaryColor: Colors.red,
        //         dotSecondaryColor: Colors.redAccent,
        //       ),
        //       likeBuilder: (bool isLiked) {
        //         return Icon(
        //           Icons.favorite,
        //           color: widget.task.pin?.isPin as bool || isPin
        //               ? Colors.pink
        //               : colorWhite,
        //           size: 20,
        //         );
        //       },
        //     ),
        //   ),
        // ),
        Positioned(
          top: dimen10,
          left: dimen10,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: color1DA5F2.withOpacity(0.7)),
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Text(
                  'Free on Plats',
                  style: GoogleFonts.quicksand(
                    color: colorWhite,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
