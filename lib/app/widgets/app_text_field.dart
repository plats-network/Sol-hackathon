import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
      {Key? key,
      required this.title,
      required this.controller,
      this.validationMessage,
      this.keyboardType,
      this.isRequired,
      this.hint,
      this.onSubmitted,
      this.textInputAction,
      this.obscureText,
      this.nodeTextField,
      this.suffixImage})
      : super(key: key);
  final String title;
  final TextEditingController controller;
  final String? validationMessage;
  final TextInputType? keyboardType;
  final bool? isRequired;
  final String? hint;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final bool? obscureText;
  final FocusNode? nodeTextField;
  final Widget? suffixImage;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            title,
            style: text14_2C2C2C_600,
          ),
          (isRequired == true)
              ? Text(' (*)', style: text14_error_600)
              : Container()
        ],
      ),
      Container(
        margin: EdgeInsets.only(top: dimen2, bottom: dimen12),
        child: AppInputView(
          controller: controller,
          textInputAction: textInputAction,
          onSubmitted: onSubmitted,
          hint: hint ?? 'please_enter_text'.tr,
          keyboardType: keyboardType ?? TextInputType.text,
          obscureText: obscureText,
          validationMessage: validationMessage,
          nodeTextField: nodeTextField,
          suffixImage: suffixImage,
        ),
      )
    ]);
  }
}
