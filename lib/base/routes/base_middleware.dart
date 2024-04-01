import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class BaseMiddleWare extends GetMiddleware {
  @override
  int? get priority => 2;

  @override
  RouteSettings? redirect(String? route) {
    final AuthController authController = Get.find();
    if (authController.isLoggedIn()) {
      if (route == Routes.splash || route == Routes.login) {
        return const RouteSettings(name: Routes.home);
      } else {
        return null;
      }
    } else if (route != null && !route.contains(Routes.login)) {
      return const RouteSettings(name: Routes.login);
    } else {
      return null;
    }
  }
}
