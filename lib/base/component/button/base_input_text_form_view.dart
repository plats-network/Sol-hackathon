import 'package:flutter/material.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class BaseInputTextFormField extends StatelessWidget {
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onChanged;
  final TextEditingController controller;
  final String? errorMessage;
  final TextStyle? labelStyle;
  final Color? borderColor;
  final Color? borderFocusColor;
  final Color? borderErrorColor;
  final double? paddingContent;
  final Color? backgroundColor;
  final ValueChanged<String>? onSubmitted;
  final bool autoFocus;
  final bool? obscureText;

  const BaseInputTextFormField(
      {Key? key,
      required this.hint,
      this.prefixIcon,
      this.suffixIcon,
      this.label,
      this.keyboardType = TextInputType.text,
      this.textInputAction = TextInputAction.none,
      this.onChanged,
      required this.controller,
      this.errorMessage,
      this.borderColor = colorWhite,
      this.borderFocusColor,
      this.borderErrorColor,
      this.paddingContent,
      this.backgroundColor,
      this.labelStyle,
      this.onSubmitted,
      this.autoFocus = false,
      this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        label == null
            ? Container()
            : Container(
                padding: const EdgeInsets.only(bottom: dimen8),
                child: Text(
                  label.toString(),
                ),
              ),
        TextFormField(
          autofocus: autoFocus,
          onFieldSubmitted: onSubmitted,
          obscureText: obscureText ?? false,
          autovalidateMode: AutovalidateMode.disabled,
          decoration: InputDecoration(
            isDense: true,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            errorText: errorMessage == '' || errorMessage == null
                ? null
                : errorMessage,
            errorStyle: Theme.of(context)
                .textTheme
                .subtitle2,
            hintText: hint,
            contentPadding:
                const EdgeInsets.fromLTRB(dimen16, dimen13, dimen0, dimen13),
            filled: true,
            fillColor: backgroundColor ?? colorWhite,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor ?? colorWhite),
              borderRadius: border8,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: borderFocusColor ?? Theme.of(context).focusColor),
              borderRadius: border8,
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: borderErrorColor ?? Theme.of(context).errorColor),
              borderRadius: border8,
            ),
          ),
          controller: controller,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          onChanged: (value) {
            if (onChanged != null) {
              onChanged!(value);
            }
          },
        ),
      ],
    );
  }
}
