import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/controller/app_notification_controller.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/category_model.dart';

class AssetsController extends GetxController {
  final mainTrayCategoryIndex = 0.obs;

  void setMainTrayCategoryIndex(int index) {
    mainTrayCategoryIndex.value = index;

    switch (index) {
      case 0:
        logEvent(eventName: 'ASSETS_TOKEN', eventParameters: {});
        break;
      case 1:
        logEvent(eventName: 'ASSETS_NFT', eventParameters: {});
        break;
      case 2:
        logEvent(eventName: 'ASSETS_GIFT', eventParameters: {});
        break;
      case 3:
        logEvent(eventName: 'ASSETS_WALLET', eventParameters: {});
        break;
    }
  }
}
