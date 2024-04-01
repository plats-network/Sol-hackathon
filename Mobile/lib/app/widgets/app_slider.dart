import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AppSlider extends StatelessWidget {
  final List<String> images;
  final String? label;
  const AppSlider({Key? key, required this.images, this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    const marginBetween = dimen14;
    const viewPortFraction = dimen1 + marginBetween / dimen14 * 0.08;
    final controller =
        PageController(viewportFraction: viewPortFraction, keepPage: true);

    final pages = images
        .map((e) => Container(
              margin: EdgeInsets.symmetric(horizontal: marginBetween),
              decoration: BoxDecoration(
                image: DecorationImage(
                  //TODO add default image
                  image: CachedNetworkImageProvider(e),
                  fit: BoxFit.cover,
                ),
                borderRadius: border16,
                boxShadow: const [
                  BoxShadow(
                    color: colorE4E1E1,
                    blurRadius: dimen3,
                  ),
                ],
              ),
              child: Container(),
            ))
        .toList();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Stack(
            children: [
              SizedBox(
                height: dimen343,
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      child: pages[index % pages.length],
                      onTap: () {
                        if (kDebugMode) {
                          print('slider item $index');
                        }
                      },
                    );
                  },
                ),
              ),
              pages.isNotEmpty
                  ? Positioned(
                      bottom: dimen24,
                      right: dimen16,
                      child: SmoothPageIndicator(
                        controller: controller,
                        count: pages.length,
                        effect: ExpandingDotsEffect(
                          dotHeight: dimen8,
                          dotWidth: dimen8,
                          spacing: dimen4,
                          dotColor: colorWhite.withOpacity(0.6),
                          activeDotColor: colorWhite,
                        ),
                      ),
                    )
                  : Container(),
              label != null
                  ? Positioned(
                      bottom: dimen24,
                      left: dimen16,
                      child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: const BoxDecoration(
                              color: color469B59,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3))),
                          child: Text(label!, style: text10_white_600)),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
