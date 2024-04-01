import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _goToLogin();
  }

  void _goToLogin() async {
    await Future.delayed(const Duration(seconds: 1));
    Get.offAndToNamed(Routes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            backgroundColor: colorPrimary,
            body: Container(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image:
                        AssetImage(getAssetImage(AssetImagePath.logo_plats_05)),
                    width: dimen150,
                  )
                ],
              ),
            ))));
  }
}
