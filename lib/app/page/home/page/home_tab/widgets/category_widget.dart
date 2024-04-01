import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/category_model.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/base/component/snackbar/getx_default_snack_bar.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';

class CategoryWidget extends StatelessWidget {
  final List<Category> categories;
  final int selectedIndex;
  final double paddingHorizontal;
  final Function(int)? setSelectedIndex;
  final Key listViewKey;

  const CategoryWidget({
    Key? key,
    required this.categories,
    required this.selectedIndex,
    this.paddingHorizontal = dimen6,
    this.setSelectedIndex,
    required this.listViewKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: dimen40,
      // color: color1877F2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        key: PageStorageKey(listViewKey),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(
                left: index == 0 ? dimen16 : paddingHorizontal,
                right: paddingHorizontal),
            child: AppButton(
              title: categories[index].name,
              onTap: !categories[index].isComingSoon
                  ? () {
                      if (setSelectedIndex != null) {
                        setSelectedIndex!(index);
                      }
                    }
                  : () {
                      GetXDefaultSnackBar.defaultSnackBar(
                          message: 'coming soon'.tr);
                    },
              horizontalPadding: dimen12,
              isPrimaryStyle: selectedIndex == index ? true : false,
              backgroundColor:
                  selectedIndex == index ? colorPrimary : colorE4E1E1,
              textStyle:
                  selectedIndex == index ? text16_white_700 : text16_32302D_400,
            ),
          );
        },
      ),
    );
  }
}
