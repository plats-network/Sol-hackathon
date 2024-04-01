import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class AppInputView extends StatefulWidget {
  final TextEditingController controller;
  final String? label;
  final isRequired;
  final String? validationMessage;
  final String hint;
  final TextInputType keyboardType;
  final Widget? prefixImage;
  final Widget? suffixImage;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final bool autoFocus;
  final bool? obscureText;
  final FocusNode? nodeTextField;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;

  const AppInputView(
      {Key? key,
      required this.controller,
      this.label,
      this.isRequired = false,
      this.validationMessage,
      this.obscureText,
      required this.hint,
      this.keyboardType = TextInputType.text,
      this.prefixImage,
      this.suffixImage,
      this.textInputAction,
      this.onSubmitted,
      this.autoFocus = false,
      this.nodeTextField,
      this.maxLength,
      this.inputFormatters});

  @override
  State<AppInputView> createState() => _AppInputViewState();
}

class _AppInputViewState extends State<AppInputView> {
  final showClear = false.obs;

  @override
  void initState() {
    super.initState();
    showClear.value = widget.controller.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label == null
            ? Container()
            : Row(
                children: [
                  Text(
                    widget.label.toString(),
                    style: text14_32302D_700,
                  ),
                  widget.isRequired
                      ? const Text(
                          ' *',
                          style: text16_error_600,
                        )
                      : Container(),
                ],
              ),
        widget.label != null ? verticalSpace12 : verticalSpace2,
        TextField(
            autofocus: widget.autoFocus,
            textAlign: TextAlign.start,
            focusNode: widget.nodeTextField,
            onChanged: (value) {
              showClear.value = value.isNotEmpty;
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxLength),
              ...widget.inputFormatters ?? []
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hint,
              isDense: true,
              filled: true,
              fillColor: colorEEF1F5,
              hintStyle: text14_9C9896_400.copyWith(color: color898989),
              isCollapsed: widget.prefixImage == null ? true : false,
              contentPadding: const EdgeInsets.all(dimen18),
              prefixIcon: widget.prefixImage != null
                  ? Container(
                      width: dimen24,
                      height: dimen24,
                      margin:
                          const EdgeInsets.only(left: dimen10, right: dimen10),
                      child: widget.prefixImage)
                  : const SizedBox(
                      width: dimen0,
                      height: dimen0,
                    ),
              prefixIconConstraints: const BoxConstraints(minWidth: dimen16),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  widget.suffixImage != null
                      ? Container(
                          width: dimen24,
                          height: dimen24,
                          margin: const EdgeInsets.only(right: dimen10),
                          child: widget.suffixImage)
                      : const SizedBox(
                          width: dimen0,
                          height: dimen0,
                        ),
                  Obx(() {
                    if (showClear.value) {
                      return Container(
                          width: dimen16,
                          height: dimen16,
                          margin: const EdgeInsets.only(right: dimen10),
                          child: InkWell(
                              child: const Icon(
                                CupertinoIcons.clear_thick_circled,
                                size: dimen18,
                                color: color878998,
                              ),
                              onTap: () {
                                widget.controller.text = '';
                                showClear.value = false;
                                widget.nodeTextField?.requestFocus();
                              }));
                    } else {
                      return Container();
                    }
                  })
                ],
              ),
              suffixIconConstraints: const BoxConstraints(minWidth: dimen16),
              enabledBorder: OutlineInputBorder(
                borderRadius: border8,
                borderSide: BorderSide(
                    color: (widget.validationMessage?.isNotEmpty == true)
                        ? colorError
                        : colorEEF1F5,
                    width: dimen1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: border8,
                borderSide: BorderSide(
                    color: (widget.validationMessage?.isNotEmpty == true)
                        ? colorError
                        : colorEEF1F5,
                    width: dimen1),
              ),
            ),
            style: text16_32302D_400.copyWith(color: color565C6E),
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction ?? TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).nextFocus();
            },
            onSubmitted: widget.onSubmitted,
            obscureText: widget.obscureText ?? false),
        (widget.validationMessage?.isNotEmpty == true)
            ? Container(
                margin: const EdgeInsets.only(right: dimen16, top: dimen4),
                child: Text(
                  '${widget.validationMessage}',
                  style: text12_error_600,
                ))
            : Container()
      ],
    );
  }
}
