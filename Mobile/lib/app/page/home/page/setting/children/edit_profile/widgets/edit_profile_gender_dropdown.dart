import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/model/edit_profile_gender_dropdown_value.dart';
import 'package:plat_app/app/widgets/app_dropdown_button.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';

class EditProfileGenderDropdown extends StatelessWidget {
  const EditProfileGenderDropdown(
      {Key? key,
      required this.onChanged,
      this.validationMessage,
      required this.currentValue,
      required this.values})
      : super(key: key);
  final EditProfileGenderDropdownValue? currentValue;
  final String? validationMessage;
  final Function(EditProfileGenderDropdownValue?) onChanged;
  final List<EditProfileGenderDropdownValue> values;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: dimen12),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'gender'.tr,
                style: text16_32302D_700,
              ),
            ],
          ),
          verticalSpace12,
          Container(
            padding: const EdgeInsets.only(left: dimen16, right: dimen10),
            width: double.infinity,
            height: dimen60,
            decoration: BoxDecoration(
                color: colorEEF1F5,
                borderRadius: border8,
                border: (validationMessage?.isNotEmpty == true)
                    ? Border.all(color: colorError, width: dimen1)
                    : Border.all(color: colorF3F1F1, width: dimen1)),
            child: DropdownButtonHideUnderline(
              child: AppDropdownButton<EditProfileGenderDropdownValue>(
                value: currentValue,
                hint: Text(
                  'gender'.tr,
                  style: text14_898989_400,
                ),
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: color898989,
                ),
                style: text16_32302D_400,
                onChanged: (EditProfileGenderDropdownValue? newValue) {
                  onChanged(newValue);
                },
                items: values
                    .map<DropdownMenuItem<EditProfileGenderDropdownValue>>(
                        (EditProfileGenderDropdownValue value) {
                  return DropdownMenuItem<EditProfileGenderDropdownValue>(
                    value: value,
                    child: Text(
                      value.value,
                      style: text16_32302D_400,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          (validationMessage?.isNotEmpty == true)
              ? verticalSpace4
              : Container(),
          (validationMessage?.isNotEmpty == true)
              ? Row(
                  children: [
                    Text(
                      '$validationMessage',
                      style: text12_error_400,
                    ),
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
