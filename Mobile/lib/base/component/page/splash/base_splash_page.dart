import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:plat_app/base/routes/base_pages.dart';
import 'package:get/get.dart';

class BaseSplashPage extends StatefulWidget {
  const BaseSplashPage({Key? key}) : super(key: key);

  @override
  State<BaseSplashPage> createState() => _BaseSplashPageState();
}

class _BaseSplashPageState extends State<BaseSplashPage> {
  @override
  void initState() {
    super.initState();
    _goToHome();
  }

  void _goToHome() async {
    await Future.delayed(Duration(seconds: 1));
    Get.offAndToNamed(Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(body: SafeArea(child: Text('Splash'))));
  }
}
