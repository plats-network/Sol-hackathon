import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/mock_home_hot_task_slider_model.dart';
import 'package:plat_app/app/widgets/app_shimmer.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HotTaskSliderShimmerWidget extends StatelessWidget {
  const HotTaskSliderShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = PageController(viewportFraction: dimen1, keepPage: true);
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
                  itemCount: 1,
                  itemBuilder: (_, index) {
                    return AppShimmer(
                      width: double.infinity,
                      height: dimen350,
                      cornerRadius: dimen16,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
