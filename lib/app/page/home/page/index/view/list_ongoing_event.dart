import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plat_app/app/page/home/page/index/model/list_ongoing_event_reponse.dart';
import 'package:plat_app/app/page/home/page/index/view/ongoing_event_screen.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class ListOngoingEvent extends StatefulWidget {
  final List<OngoingEventData> listOngoingEventResponse;
  const ListOngoingEvent({super.key, required this.listOngoingEventResponse});

  @override
  State<ListOngoingEvent> createState() => _ListOngoingEventState();
}

class _ListOngoingEventState extends State<ListOngoingEvent> {
  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OnGoingEventScreen(
                    eventId:
                        widget.listOngoingEventResponse[index].eventId ?? ''),
              ),
            );
          },
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                decoration: BoxDecoration(
                  color: colorBlack,
                  borderRadius: BorderRadius.circular(dimen16),
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
                      widget.listOngoingEventResponse[index].bannerUrl ?? '',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: dimen10,
                left: dimen10,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: dimen8,
                    vertical: dimen4,
                  ),
                  decoration: BoxDecoration(
                    color: color30A1DB.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(dimen4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        getAssetImage(AssetImagePath.idea),
                        fit: BoxFit.cover,
                        width: dimen10,
                        height: dimen10,
                        color: colorWhite,
                      ),
                      horizontalSpace4,
                      Text(
                        'Ongoing',
                        style: GoogleFonts.quicksand(
                          color: colorWhite,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      itemCount: widget.listOngoingEventResponse.length ?? 0,
      itemWidth: MediaQuery.of(context).size.width,
      itemHeight: 300,
      layout: SwiperLayout.TINDER,
      indicatorLayout: PageIndicatorLayout.SLIDE,
      pagination: const SwiperPagination(
        alignment: Alignment.bottomCenter,
        builder: SwiperPagination.dots,
      ),
    );
  }
}
