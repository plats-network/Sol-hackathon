import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/controller/edit_profile_controller.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/model/edit_profile_gender_dropdown_value.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/widgets/edit_profile_gender_dropdown.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/controller/password_security_controller.dart';
import 'package:plat_app/app/page/home/page/setting/controller/setting_controller.dart';
import 'package:plat_app/app/widgets/app_button.dart';
import 'package:plat_app/app/widgets/app_input_widget.dart';
import 'package:plat_app/app/widgets/common_appbar_page.dart';
import 'package:plat_app/base/component/bottom_sheet/getx_bottom_sheet.dart';
import 'package:plat_app/base/component/progress/full_screen_progress.dart';
import 'package:plat_app/base/resources/constants/base_colors.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/resources/constants/base_text_styles.dart';
import 'package:plat_app/base/resources/constants/dimens.dart';
import 'package:plat_app/base/resources/constants/radius.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';
import 'package:plat_app/base/routes/base_pages.dart';

part 'edit_profile_page_action.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isShowError = false;
  final _isError = true.obs;
  final EditProfileController editProfileController = Get.find();
  final SettingController settingController = Get.find();
  final PasswordSecurityController passwordSecurityController = Get.find();

  final TextEditingController fullNameController = TextEditingController();
  final fullNameValidationMessage = ''.obs;
  final hideFullName = true.obs;
  final FocusNode _nodeFullName = FocusNode();

  final TextEditingController emailController = TextEditingController();
  final emailValidationMessage = ''.obs;
  final hideEmail = true.obs;
  final FocusNode _nodeEmail = FocusNode();
  final List<EditProfileGenderDropdownValue> genderValues = [
    EditProfileGenderDropdownValue(key: 0, value: 'male'.tr),
    EditProfileGenderDropdownValue(key: 1, value: 'female'.tr),
    EditProfileGenderDropdownValue(key: 2, value: 'other'.tr),
  ];

  final sex = Rx<EditProfileGenderDropdownValue?>(null);
  final dateOfBirth = Rx<String?>(null);

  late Worker updateProfileWorker;

  @override
  void initState() {
    super.initState();
    fullNameController.text =
        settingController.userProfile.value.data?.data?.name ?? '';
    emailController.text =
        settingController.userProfile.value.data?.data?.email ?? '';
    // Set gender
    final gender = settingController.userProfile.value.data?.data?.gender;
    if (gender != null) {
      for (var element in genderValues) {
        if (element.key == gender) {
          sex.value = element;
        }
      }
    }
    // Set date of birth
    final birth = settingController.userProfile.value.data?.data?.birth;
    if (birth != null) {
      dateOfBirth.value = birth;
    }
    fullNameController.addListener(() {
      _validate(false);
    });
    emailController.addListener(() {
      _validate(false);
    });
    updateProfileWorker =
        ever(editProfileController.updateProfileData, (NetworkResource data) {
      if (data.isSuccess()) {
        onUpdateProfileSuccess();
        settingController.fetchUserProfile();
        _isError.value = true;
      }
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    _nodeFullName.dispose();
    emailController.dispose();
    _nodeEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget fullNameWidget = Obx(() {
      return AppInputView(
        controller: fullNameController,
        hint: 'full_name'.tr,
        label: 'full_name'.tr,
        isRequired: true,
        validationMessage: fullNameValidationMessage.value,
        textInputAction: TextInputAction.next,
        onSubmitted: (value) {
          _nodeEmail.requestFocus();
        },
        nodeTextField: _nodeFullName,
      );
    });

    Widget emailWidget = Obx(() {
      return AppInputView(
        controller: emailController,
        hint: 'email'.tr,
        label: 'email'.tr,
        isRequired: true,
        validationMessage: emailValidationMessage.value,
        textInputAction: TextInputAction.next,
        onSubmitted: (value) {
          Get.focusScope?.unfocus();
        },
        nodeTextField: _nodeEmail,
      );
    });

    Widget sexWidget = Obx(() {
      return EditProfileGenderDropdown(
        values: genderValues,
        currentValue: sex.value,
        onChanged: (value) {
          sex.value = value;
          // Validate
          _validate(false);
        },
      );
    });

    Widget dateOfBirthWidget = Column(
      children: [
        Row(
          children: [
            Text(
              'date_of_birth'.tr,
              style: text16_32302D_700,
            ),
          ],
        ),
        verticalSpace12,
        GestureDetector(
          onTap: () {
            showDatePicker(
                    context: context,
                    initialDate: DateTime(DateTime.now().year - 20),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now())
                .then((value) {
              if (value != null) {
                dateOfBirth.value = DateFormat('dd/MM/yyyy').format(value);
                // Validate
                _validate(false);
              }
            });
          },
          child: Obx(() {
            return Container(
              height: dimen60,
              decoration: BoxDecoration(
                borderRadius: border8,
                border: Border.all(color: colorF3F1F1, width: dimen1),
                color: colorEEF1F5,
              ),
              padding: const EdgeInsets.symmetric(horizontal: dimen16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      dateOfBirth.value ?? 'date_of_birth'.tr,
                      style: (dateOfBirth.value != null)
                          ? text16_32302D_400
                          : text14_898989_400,
                    ),
                  ),
                  horizontalSpace8,
                  Image.asset(
                    getAssetImage(AssetImagePath.ic_calendar),
                    width: dimen24,
                    height: dimen24,
                    color: color878998,
                  )
                ],
              ),
            );
          }),
        ),
      ],
    );

    return Stack(
      children: [
        CommonAppBarPage(
            title: 'edit_profile'.tr,
            onBackButtonClick: () {
              onBackButtonClick();
            },
            child: Container(
              decoration: const BoxDecoration(
                color: colorWhite,
              ),
              padding:
                  const EdgeInsets.fromLTRB(dimen16, dimen0, dimen16, dimen16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding:
                          const EdgeInsets.only(top: dimen16, bottom: dimen40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          verticalSpace24,
                          fullNameWidget,
                          verticalSpace24,
                          emailWidget,
                          verticalSpace24,
                          sexWidget,
                          verticalSpace24,
                          dateOfBirthWidget,
                          verticalSpace30,
                          GestureDetector(
                            onTap: () {
                              isShowError = true;
                              _validate(true);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              decoration: BoxDecoration(
                                borderRadius: border8,
                                color: colorPrimary,
                                boxShadow: [
                                  BoxShadow(
                                      color: colorPrimary.withOpacity(0.5),
                                      blurRadius: dimen5,
                                      offset: const Offset(0, 2)),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'save'.tr,
                                  style: const TextStyle(
                                    color: colorWhite,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     GetXDefaultBottomSheet.warningBottomSheet(
                  //         title: 'delete_account'.tr,
                  //         text: Text(
                  //           'delete_account_help_text'.tr,
                  //           textAlign: TextAlign.center,
                  //           style: text14_32302D_400,
                  //         ),
                  //         buttons: [
                  //           Expanded(
                  //             child: AppButton(
                  //               title: 'yes'.tr,
                  //               onTap: () async {
                  //                 passwordSecurityController.deleteAccount();
                  //                 Get.back();
                  //               },
                  //               isPrimaryStyle: false,
                  //             ),
                  //           ),
                  //           horizontalSpace8,
                  //           Expanded(
                  //             child: AppButton(
                  //               title: 'no'.tr,
                  //               onTap: () {
                  //                 Get.back();
                  //               },
                  //             ),
                  //           ),
                  //         ]);
                  //   },
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       Image.asset(
                  //         getAssetImage(AssetImagePath.trash),
                  //         fit: BoxFit.cover,
                  //         color: colorEA4335,
                  //         width: 16,
                  //         height: 16,
                  //       ),
                  //       horizontalSpace6,
                  //       Text(
                  //         'delete_account'.tr,
                  //         style: const TextStyle(
                  //           color: colorEA4335,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  verticalSpace16,
                ],
              ),
            )),
        Obx(() => (editProfileController.isUpdatingProfile()
            ? const FullScreenProgress()
            : Container())),
      ],
    );
  }
}
