import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';

class AppPostalCodeSplit extends StatelessWidget {
  const AppPostalCodeSplit(
      {Key? key,
      required this.zipCodeFirstController,
      required this.zipCodeSecondController,
      this.zipCodeFirstValidationMessage,
      this.zipCodeSecondValidationMessage,
      this.hint,
      this.onSubmitted,
      this.textInputAction,
      required this.validate,
      this.focusNode})
      : super(key: key);
  final TextEditingController zipCodeFirstController;
  final TextEditingController zipCodeSecondController;
  final String? zipCodeFirstValidationMessage;
  final String? zipCodeSecondValidationMessage;
  final String? hint;
  final ValueChanged<String>? onSubmitted;
  final TextInputAction? textInputAction;
  final Function(bool) validate;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        children: [
          Text(
            'postal_code_zip'.tr,
            style: text14_2C2C2C_600,
          ),
          const Text(
            ' (*)',
            style: text14_error_600,
          )
        ],
      ),
      Container(
        margin: const EdgeInsets.only(top: dimen2, bottom: dimen12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: AppInputView(
              controller: zipCodeFirstController,
              textInputAction: TextInputAction.next,
              hint: hint ?? 'XXX',
              maxLength: 3,
              keyboardType: TextInputType.number,
              validationMessage: zipCodeFirstValidationMessage,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]"))
              ],
            )),
            horizontalSpace8,
            Container(
              width: dimen8,
              height: dimen2,
              color: color495057,
              margin: const EdgeInsets.only(top: dimen20),
            ),
            horizontalSpace8,
            Expanded(
                child: AppInputView(
              controller: zipCodeSecondController,
              textInputAction: TextInputAction.next,
              hint: hint ?? 'XXXX',
              maxLength: 4,
              nodeTextField: focusNode,
              keyboardType: TextInputType.number,
              validationMessage: zipCodeSecondValidationMessage,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]"))
              ],
            )),
            horizontalSpace8,
            Expanded(
              child: AppButton(
                title: 'search_postal_code'.tr,
                onTap: () async {
                  // Validate
                  validate(true);
                },
                height: dimen40,
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
