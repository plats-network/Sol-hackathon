import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppValidationPageState<T extends StatefulWidget>
    extends State<T> {
  final List<TextEditingController> controllers;
  AppValidationPageState({required this.controllers});
  bool isShowError = false;
  final _isError = true.obs;

  @override
  void initState() {
    super.initState();
    for (var controller in controllers) {
      controller.addListener(() {
        _validate(false);
      });
    }
  }

  @override
  void dispose() {
    for(var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _validate(bool isNavigate);
}
