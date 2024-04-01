import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
import 'package:plat_app/app/widgets/app_back_button.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class OrganizerScreen extends StatefulWidget {
  const OrganizerScreen({super.key});

  @override
  State<OrganizerScreen> createState() => _OrganizerScreenState();
}

class _OrganizerScreenState extends State<OrganizerScreen>
    with TickerProviderStateMixin {
  bool isFollow = false;
  bool isShowContact = false;
  double scrollPosition = 0.0;
  @override
  ScrollController scrollController = ScrollController();
  _scrollListener() {
    scrollPosition = scrollController.position.pixels;
    setState(() {});
  }

  void followButtonClick() {
    setState(() {
      isFollow = !isFollow;
    });
  }

  void showContactButtonClick() {
    setState(() {
      isShowContact = !isShowContact;
    });
  }

  final HomeTabController homeTabController = Get.find();
  @override
  void initState() {
    scrollController.addListener(_scrollListener);
    // homeTabController.fetchEventTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Obx(
        //   () =>
        Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        backgroundColor: colorWhite,
        elevation: dimen0,
        leadingWidth: dimen65,
        leading: Padding(
          padding: const EdgeInsets.only(left: dimen16),
          child: AppBackButton(
            onTab: () {
              Get.back();
            },
          ),
        ),
        title: scrollPosition > 250
            ? Text(
                'Admin',
                style: GoogleFonts.quicksand(
                  fontSize: 16,
                  color: colorBlack,
                  fontWeight: FontWeight.w600,
                ),
              )
            : const SizedBox(),
        centerTitle: false,
        actions: [
          scrollPosition > 250
              ? GestureDetector(
                  onTap: () {
                    followButtonClick();
                  },
                  child: Container(
                    height: dimen26,
                    width: dimen90,
                    padding: const EdgeInsets.symmetric(
                      vertical: dimen0,
                      horizontal: dimen16,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: dimen12,
                      horizontal: dimen12,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: border4,
                      color: isFollow ? colorWhite : colorPrimary,
                      border: Border.all(
                        width: 1.5,
                        color: colorPrimary,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        !isFollow ? 'Follow' : 'Following',
                        style: GoogleFonts.quicksand(
                          color: !isFollow ? colorWhite : colorPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: scrollController,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: dimen80,
                  height: dimen80,
                  decoration: const BoxDecoration(
                    color: colorA2CCF3,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      'Admin'.substring(0, 1),
                      style: GoogleFonts.quicksand(
                        fontSize: 40,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                verticalSpace20,
                Text(
                  'Admin',
                  style: GoogleFonts.quicksand(
                    fontSize: 20,
                    color: colorBlack,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                verticalSpace20,
                SizedBox(
                  width: dimen250,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                color: colorBlack,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Followers',
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                color: color565C6E,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const VerticalDivider(
                        color: colorBlack,
                        thickness: 1,
                        width: dimen0,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '0',
                              style: GoogleFonts.quicksand(
                                fontSize: 20,
                                color: colorBlack,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Total events',
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                color: color565C6E,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                verticalSpace20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        followButtonClick();
                      },
                      child: Container(
                        height: dimen45,
                        width: dimen150,
                        padding: const EdgeInsets.symmetric(
                          vertical: dimen0,
                          horizontal: dimen16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: border4,
                          color: isFollow ? colorWhite : colorPrimary,
                          border: Border.all(
                            width: 1.5,
                            color: colorPrimary,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            !isFollow ? 'Follow' : 'Following',
                            style: GoogleFonts.quicksand(
                              color: !isFollow ? colorWhite : colorPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    horizontalSpace10,
                    GestureDetector(
                      onTap: () {
                        showContactButtonClick();
                      },
                      child: Container(
                        width: dimen45,
                        height: dimen45,
                        padding: const EdgeInsets.all(dimen19),
                        decoration: const BoxDecoration(
                          borderRadius: border4,
                          color: colorF3F1F1,
                        ),
                        child: Image.asset(
                          isShowContact
                              ? getAssetImage(AssetImagePath.caret_arrow_up)
                              : getAssetImage(AssetImagePath.down),
                          color: colorBlack,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                verticalSpace10,
                isShowContact
                    ? SizedBox(
                        // color: color00FA9A,
                        height: dimen80,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                          separatorBuilder: (ctx, index) {
                            return const SizedBox(width: dimen16);
                          },
                          padding:
                              const EdgeInsets.symmetric(horizontal: dimen16),
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 6,
                          itemBuilder: (ctx, index) {
                            return GestureDetector(
                              onTap: () {},
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: dimen40,
                                    height: dimen40,
                                    decoration: const BoxDecoration(
                                      color: colorF5F7F9,
                                      shape: BoxShape.circle,
                                    ),
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(dimen60),
                                      child: Image.asset(
                                        index == 0
                                            ? getAssetImage(
                                                AssetImagePath.facebook_icon)
                                            : index == 1
                                                ? getAssetImage(
                                                    AssetImagePath.twitter_icon)
                                                : index == 2
                                                    ? getAssetImage(
                                                        AssetImagePath
                                                            .telegram_icon)
                                                    : index == 3
                                                        ? getAssetImage(
                                                            AssetImagePath
                                                                .email_icon)
                                                        : index == 4
                                                            ? getAssetImage(
                                                                AssetImagePath
                                                                    .linkedin_icon)
                                                            : index == 5
                                                                ? getAssetImage(
                                                                    AssetImagePath
                                                                        .whatsApp_icon)
                                                                : getAssetImage(
                                                                    AssetImagePath
                                                                        .more_icon),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  verticalSpace6,
                                  Text(
                                    index == 0
                                        ? 'Facebook'
                                        : index == 1
                                            ? 'Twitter'
                                            : index == 2
                                                ? 'Telegram'
                                                : index == 3
                                                    ? 'Email'
                                                    : index == 4
                                                        ? 'Linkedin'
                                                        : index == 5
                                                            ? 'WhatsApp'
                                                            : 'Other',
                                    style: GoogleFonts.quicksand(
                                      fontSize: 12,
                                      color: colorBlack,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox(),
                verticalSpace30,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: dimen16, bottom: dimen10),
                    child: Text(
                      'Event organized',
                      style: GoogleFonts.quicksand(
                        fontSize: 16,
                        color: colorBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 2000,
                  color: colorWhite,
                ),
                // Container(
                //   margin: const EdgeInsets.symmetric(horizontal: dimen16),
                //   child: ListView.separated(
                //     itemBuilder: (context, index) {
                //       return SlideAnimation(
                //         intervalStart: 0.4,
                //         begin: const Offset(0, 30),
                //         child: Container(
                //           margin: const EdgeInsets.only(bottom: dimen16),
                //           decoration: const BoxDecoration(
                //             color: colorWhite,
                //             borderRadius: border8,
                //             boxShadow: [
                //               BoxShadow(
                //                 color: colorE4E1E1,
                //                 offset: Offset(0, dimen4),
                //                 blurRadius: dimen24,
                //               ),
                //             ],
                //           ),
                //           clipBehavior: Clip.antiAlias,
                //           child: Material(
                //             color: colorWhite,
                //             child: InkWell(
                //               borderRadius: border8,
                //               onTap: () => [
                //                 // Get.toNamed(Routes.socialTaskDetail, arguments: {
                //                 //   'task_id': tasks[index].id,
                //                 //   'is_done': tasks[index].taskStart,
                //                 // })
                //               ],
                //               child: EventItem(
                //                   task: (homeTabController
                //                           .taskEventData.value.data?.data ??
                //                       [])[index]),
                //             ),
                //           ),
                //         ),
                //       );
                //     },
                //     shrinkWrap: true,
                //     physics: const ClampingScrollPhysics(),
                //     separatorBuilder: (context, index) => const SizedBox(
                //         // height: 8,
                //         ),
                //     itemCount: homeTabController
                //             .taskEventData.value.data?.data?.length ??
                //         0,
                //   ),
                // ),
              ],
            ),
          ),
        ),
        // ),
      ),
    );
  }
}
