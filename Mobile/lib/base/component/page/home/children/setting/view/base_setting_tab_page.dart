import 'package:flutter/material.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';

class BaseSettingTabPage extends StatefulWidget {
  const BaseSettingTabPage({Key? key}) : super(key: key);

  @override
  State<BaseSettingTabPage> createState() => _BaseSettingTabPageState();
}

class _BaseSettingTabPageState extends State<BaseSettingTabPage> {
  final AuthController authController = Get.find();
  late Worker logoutWorker;

  @override
  void initState() {
    super.initState();
    logoutWorker = ever(authController.authData, (NetworkResource callback) {
      if (authController.isNotLoggedIn()) {
        Get.toNamed(Routes.login);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            AppButton(title: 'Logout', onTap: () {
              authController.logout();
            },),
          ],
        ),
        Obx(() => (authController.isLoggingIn())
            ? FullScreenProgress()
            : Container())
      ],
    );
  }
}
