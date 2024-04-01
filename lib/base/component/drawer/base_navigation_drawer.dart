import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class BaseNavigationDrawerWidget extends StatelessWidget {
  const BaseNavigationDrawerWidget(
      {Key? key, required this.currentIndex, required this.closeDrawer})
      : super(key: key);
  final int currentIndex;
  final VoidCallback closeDrawer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: colorPrimary,
        child: ListView(
          children: [
            Container(
                margin: EdgeInsets.all(dimen16),
                child: Text(
                  'online_pharmacy'.tr,
                  style: text20_white_600,
                )),
            // navigationMenuItem(
            //     index: 0,
            //     text: 'questionnaire'.tr,
            //     icon: AssetImagePath.questionnaire_form,
            //     onTap: () {
            //       gotoScreen(Routes.questionnaire);
            //     }),
            // navigationMenuItem(
            //     index: 1,
            //     text: 'pharmacy_information'.tr,
            //     icon: AssetImagePath.list_pharmacies,
            //     onTap: () {
            //       gotoScreen(Routes.pharmacyList);
            //     }),
            // navigationMenuItem(
            //     index: 2,
            //     text: 'drug_information'.tr,
            //     icon: AssetImagePath.medicine_list,
            //     onTap: () {
            //       gotoScreen(Routes.drugList);
            //     }),
            // navigationMenuItem(
            //     index: 3,
            //     text: 'order_history'.tr,
            //     icon: AssetImagePath.order_history,
            //     onTap: () {
            //       gotoScreen(Routes.orderHistory);
            //     }),
            // navigationMenuItem(
            //     index: 4,
            //     text: 'cart'.tr,
            //     icon: AssetImagePath.cart,
            //     onTap: () {
            //       gotoScreen(Routes.orderList);
            //     }),
            // navigationMenuItem(
            //     index: 5,
            //     text: 'registration_information'.tr,
            //     icon: AssetImagePath.settings,
            //     onTap: () {
            //       gotoScreen(Routes.registrationInformation);
            //     }),
            // navigationMenuItem(
            //     index: 6,
            //     text: 'home'.tr,
            //     icon: AssetImagePath.home,
            //     onTap: () {
            //       Get.offAllNamed(Routes.home);
            //     }),
          ],
        ),
      ),
    );
  }

  void gotoScreen(String screenName) {
    if (currentIndex == -1) {
      Get.toNamed(screenName);
    } else {
      Get.offNamed(screenName);
    }
  }

  Widget navigationMenuItem(
      {required int index,
      required String text,
      required String icon,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: () {
        onTap();
        closeDrawer();
      },
      child: Container(
        padding: const EdgeInsets.only(left: dimen12, top: dimen8, bottom: dimen8),
        color:
            (index == currentIndex) ? colorDialogBackground : colorTransparent,
        child: Row(
          children: [
            Image(
              image: AssetImage(getAssetImage(icon)),
              height: dimen44,
            ),
            horizontalSpace8,
            Flexible(
              child: Text(
                text,
                style: text14_white_400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
