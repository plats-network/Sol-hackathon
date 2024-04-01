import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/mock_home_hot_task_slider_model.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotTaskSliderWidget extends StatelessWidget {
  final List<MockHomeHotTaskSliderModel> hotTaskSliders;
  const HotTaskSliderWidget({Key? key, required this.hotTaskSliders})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: dimen1, keepPage: true);
    final pages = hotTaskSliders
        .map((item) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  //TODO add default image
                  image: CachedNetworkImageProvider(
                    item.imageUrl,
                  ),
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
              margin: const EdgeInsets.symmetric(horizontal: dimen16),
              child: Container(),
            ))
        .toList();

    return Container(
      height: dimen350,
      color: colorWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(dimen16),
            child: Text(
              'hot_task'.tr,
              style: text22_32302D_700,
            ),
          ),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Container(
                height: dimen269,
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
              Positioned(
                bottom: dimen16,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: pages.length,
                  effect: const ExpandingDotsEffect(
                      dotHeight: dimen8,
                      dotWidth: dimen8,
                      spacing: dimen2,
                      dotColor: color66FFFFFF,
                      activeDotColor: colorWhite),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
