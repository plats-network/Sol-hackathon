import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/widgets/app_checkbox.dart';

class BaseRememberCheckboxWidget extends StatelessWidget {
  final bool remember;
  final Function(bool) onCheckChanged;

  const BaseRememberCheckboxWidget(
      {Key? key, required this.remember, required this.onCheckChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCheckBox(
        text: 'remember'.tr,
        checked: remember,
        onCheckChanged: (value) {
          onCheckChanged(value);
        });
  }
}
