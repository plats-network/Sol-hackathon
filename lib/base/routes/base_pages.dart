import 'package:get/get.dart';
import 'package:plat_app/app/page/home/binding/home_binding.dart';
import 'package:plat_app/app/page/home/children/box_detail/binding/box_detail_bindings.dart';
import 'package:plat_app/app/page/home/children/box_detail/page/box_detail_page.dart';
import 'package:plat_app/app/page/home/children/box_history/binding/box_history_binding.dart';
import 'package:plat_app/app/page/home/children/box_history/page/box_history_page.dart';
import 'package:plat_app/app/page/home/children/check_in_list/binding/check_in_binding.dart';
import 'package:plat_app/app/page/home/children/check_in_list/page/check_in_list_page.dart';
import 'package:plat_app/app/page/home/children/mystery_box_detail/binding/mystery_box_detail_binding.dart';
import 'package:plat_app/app/page/home/children/mystery_box_detail/page/mystery_box_detail_page.dart';
import 'package:plat_app/app/page/home/children/nft_detail/binding/nft_detail_bindings.dart';
import 'package:plat_app/app/page/home/children/nft_detail/page/nft_detail_page.dart';
import 'package:plat_app/app/page/home/children/notification/binding/notification_binding.dart';
import 'package:plat_app/app/page/home/children/notification/page/notification_page.dart';
import 'package:plat_app/app/page/home/children/social_list/binding/social_binding.dart';
import 'package:plat_app/app/page/home/children/social_list/page/social_list_page.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/binding/social_task_detail_binding.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/page/overview_screen.dart';
import 'package:plat_app/app/page/home/children/social_task_detail/page/social_task_detail_page.dart';
import 'package:plat_app/app/page/home/children/task_detail/binding/task_detail_binding.dart';
import 'package:plat_app/app/page/home/children/task_detail/page/task_detail_page.dart';
import 'package:plat_app/app/page/home/children/task_perform/binding/task_perform_binding.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/binding/take_photo_binding.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/children/preview_photo/binding/preview_photo_binding.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/children/preview_photo/page/preview_photo_page.dart';
import 'package:plat_app/app/page/home/children/task_perform/children/take_photo/page/take_photo_page.dart';
import 'package:plat_app/app/page/home/children/task_perform/page/task_perform_page.dart';
import 'package:plat_app/app/page/home/children/task_reward/binding/task_reward_binding.dart';
import 'package:plat_app/app/page/home/children/task_reward/page/task_reward_page.dart';
import 'package:plat_app/app/page/home/children/token_info/binding/token_info_binding.dart';
import 'package:plat_app/app/page/home/children/token_info/view/token_info_page.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/binding/voucher_detail_bindings.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/children/voucher_detail_qr/binding/voucher_detail_qr_binding.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/children/voucher_detail_qr/page/voucher_detail_qr_page.dart';
import 'package:plat_app/app/page/home/children/voucher_detail/page/voucher_detail_page.dart';
import 'package:plat_app/app/page/home/children/voucher_history/binding/voucher_history_binding.dart';
import 'package:plat_app/app/page/home/children/voucher_history/page/voucher_history_page.dart';
import 'package:plat_app/app/page/home/page/group/binding/group_binding.dart';
import 'package:plat_app/app/page/home/page/group/children/group_detail/binding/group_detail_binding.dart';
import 'package:plat_app/app/page/home/page/group/children/group_detail/page/group_detail_page.dart';
import 'package:plat_app/app/page/home/page/group/view/group_tab_page.dart';
import 'package:plat_app/app/page/home/page/group/view/my_group_list_page.dart';
import 'package:plat_app/app/page/home/page/home_page.dart';
import 'package:plat_app/app/page/home/page/index/binding/index_binding.dart';
import 'package:plat_app/app/page/home/page/index/view/index_screen.dart';
import 'package:plat_app/app/page/home/page/index/view/list_trending_event.dart';
import 'package:plat_app/app/page/home/page/index/view/list_upcoming_event.dart';
import 'package:plat_app/app/page/home/page/qrcode/binding/qr_code_binding.dart';
import 'package:plat_app/app/page/home/page/qrcode/view/qrcode_screen.dart';
import 'package:plat_app/app/page/home/page/setting/children/about/binding/about_app_binding.dart';
import 'package:plat_app/app/page/home/page/setting/children/about/view/about_screen.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/binding/edit_profile_binding.dart';
import 'package:plat_app/app/page/home/page/setting/children/edit_profile/page/edit_profile_page.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/binding/help_center_binding.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/children/help_template/binding/help_template_binding.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/children/help_template/page/help_template_page.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/children/need_help/binding/need_help_binding.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/children/need_help/page/need_help_page.dart';
import 'package:plat_app/app/page/home/page/setting/children/help_center/page/help_center_page.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/binding/password_security_binding.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/children/change_password/binding/change_password_binding.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/children/change_password/page/change_password_page.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/page/password_security_page.dart';
import 'package:plat_app/app/page/home/page/tickets/binding/ticket_binding.dart';
import 'package:plat_app/app/page/home/page/tickets/view/ticket_screen.dart';
import 'package:plat_app/app/page/login/binding/auth_binding.dart';
import 'package:plat_app/app/page/login/children/forgot_password/binding/forgot_password_binding.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/binding/alert_forgot_password_binding.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/children/otp_change_password/binding/otp_change_password_binding.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/children/otp_change_password/page/otp_change_password_page.dart';
import 'package:plat_app/app/page/login/children/forgot_password/children/alert_forgot_password/page/alert_forgot_password_page.dart';
import 'package:plat_app/app/page/login/children/forgot_password/page/forgot_password_page.dart';
import 'package:plat_app/app/page/login/children/register/children/alert_register_verification_page/binding/alert_register_verification_binding.dart';
import 'package:plat_app/app/page/login/children/register/children/alert_register_verification_page/page/alert_register_verification_page.dart';
import 'package:plat_app/app/page/login/children/register/binding/register_binding.dart';
import 'package:plat_app/app/page/login/children/register/page/register_page.dart';
import 'package:plat_app/app/page/login/page/login_page.dart';
import 'package:plat_app/app/page/splash/splash_page.dart';
import 'package:plat_app/base/routes/base_middleware.dart';

part 'base_routes.dart';

final List<GetPage<dynamic>> pages = [
  GetPage(
      name: _Paths.splash,
      page: () => const SplashPage(),
      transition: Transition.rightToLeft),
  GetPage(
      name: _Paths.login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
      children: [
        GetPage(
          name: _Paths.register,
          page: () => const RegisterPage(),
          binding: RegisterBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.otpVerification,
          page: () => const AlertRegisterVerificationPage(),
          binding: AlertRegisterVerificationBinding(),
          transition: Transition.rightToLeft,
        ),
      ],
      middlewares: [
        BaseMiddleWare(),
      ]),
  GetPage(
      name: _Paths.index,
      page: () => const IndexScreen(),
      bindings: [HomeBinding()],
      transition: Transition.rightToLeft),

  GetPage(
      name: _Paths.listTrendingEvent,
      page: () => const ListTrendingEventPage(),
      binding: IndexBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: _Paths.listUpcomingEvent,
      page: () => const ListUpcomingEventPage(),
      binding: IndexBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: _Paths.ticket,
      page: () => const TicketPage(),
      binding: TicketBinding(),
      transition: Transition.rightToLeft),
  GetPage(
      name: _Paths.forgotPassword,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
      children: [
        //forgot_password_success
        GetPage(
            name: _Paths.alertForgotPassword,
            page: () => const AlertForgotPasswordPage(),
            binding: AlertForgotPasswordBinding(),
            transition: Transition.rightToLeft,
            children: [
              GetPage(
                name: _Paths.otpChangePassword,
                page: () => const OTPChangePasswordPage(),
                binding: OtpChangePasswordBinding(),
                transition: Transition.rightToLeft,
              ),
            ]),
      ],
      transition: Transition.rightToLeft),
  GetPage(
      name: _Paths.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      // transition: Transition.rightToLeft,
      middlewares: [
        BaseMiddleWare(),
      ],
      children: [
        GetPage(
          name: _Paths.checkInList,
          page: () => const CheckInListPage(),
          binding: CheckInListBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.taskDetail,
          page: () => const TaskDetailPage(),
          binding: TaskDetailBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
            name: _Paths.taskPerform,
            page: () => const TaskPerformPage(),
            binding: TaskPerformBinding(),
            transition: Transition.rightToLeft,
            children: [
              GetPage(
                  name: _Paths.takePhoto,
                  page: () => const TakePhotoPage(),
                  binding: TakePhotoBinding(),
                  transition: Transition.rightToLeft,
                  children: [
                    GetPage(
                      name: _Paths.previewPhoto,
                      page: () => const PreviewPhotoPage(),
                      binding: PreviewPhotoBinding(),
                      transition: Transition.rightToLeft,
                    ),
                  ]),
            ]),
        GetPage(
          name: _Paths.taskReward,
          page: () => const TaskRewardPage(),
          binding: TaskRewardBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.notification,
          page: () => const NotificationPage(),
          binding: NotificationBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.mysteryBoxDetail,
          page: () => const MysteryBoxDetailPage(),
          binding: MysteryBoxDetailBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.tokenInfo,
          page: () => const TokenInfoPage(),
          binding: TokenInfoBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
            name: _Paths.voucherDetail,
            page: () => const VoucherDetailPage(),
            binding: VoucherDetailBinding(),
            transition: Transition.rightToLeft,
            children: [
              GetPage(
                name: _Paths.voucherDetailQr,
                page: () => VoucherDetailQrPage(),
                transition: Transition.rightToLeft,
                binding: VoucherDetailQrBinding(),
              ),
            ]),
        GetPage(
          name: _Paths.nftDetail,
          page: () => const NftDetailPage(),
          binding: NftDetailBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
            name: _Paths.passwordSecurity,
            page: () => const PasswordSecurityPage(),
            binding: PasswordSecurityBinding(),
            transition: Transition.rightToLeft,
            children: [
              GetPage(
                name: _Paths.changePassword,
                page: () => const ChangePasswordPage(),
                binding: ChangePasswordBinding(),
                transition: Transition.rightToLeft,
              ),
            ]),
        GetPage(
          name: _Paths.editProfile,
          page: () => const EditProfilePage(),
          binding: EditProfileBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.qrCode,
          page: () => const QRCodeScreen(),
          binding: QrCodeBinding(),
          transition: Transition.upToDown,
        ),
        GetPage(
          name: _Paths.overview,
          page: () => OverViewScreen(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
            name: _Paths.helpCenter,
            page: () => const HelpCenterPage(),
            binding: HelpCenterBinding(),
            transition: Transition.rightToLeft,
            children: [
              GetPage(
                name: _Paths.needHelp,
                page: () => const NeedHelpPage(),
                binding: NeedHelpBinding(),
                transition: Transition.rightToLeft,
              ),
              GetPage(
                name: _Paths.helpTemplate,
                page: () => const HelpTemplatePage(),
                binding: HelpTemplateBinding(),
                transition: Transition.rightToLeft,
              ),
            ]),
        GetPage(
          name: _Paths.voucherHistory,
          page: () => const VoucherHistoryPage(),
          transition: Transition.rightToLeft,
          binding: VoucherHistoryBinding(),
        ),
        GetPage(
          name: _Paths.boxHistory,
          page: () => const BoxHistoryPage(),
          transition: Transition.rightToLeft,
          binding: BoxHistoryBinding(),
          children: [
            GetPage(
              name: _Paths.boxDetail,
              page: () => const BoxDetailPage(),
              transition: Transition.rightToLeft,
              binding: BoxDetailBinding(),
            ),
          ],
        ),
        GetPage(
          name: _Paths.group,
          page: () => const GroupTabPage(),
          binding: GroupBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.groupDetail,
          page: () => const GroupDetailPage(),
          binding: GroupDetailBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.socialList,
          page: () => const SocialListPage(),
          binding: SocialListBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.socialTaskDetail,
          page: () => const SocialTaskDetailPage(),
          binding: SocialTaskDetailBinding(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: _Paths.myGroupList,
          page: () => const MyGroupPage(),
          binding: GroupBinding(),
          transition: Transition.rightToLeft,
        )
      ]),
  GetPage(
      name: _Paths.aboutApp,
      page: () => const AboutScreen(),
      binding: AboutAppBinding(),
      transition: Transition.rightToLeft),
  // GetPage(
  //     name: _Paths.login,
  //     page: () => const LoginPage(),
  //     binding: AuthBinding(),
  //     middlewares: [
  //       AppMiddleWare(),
  //     ],
  //     children: [
  //       GetPage(
  //           name: _Paths.forgotPassword,
  //           page: () => const ForgotPasswordPage(),
  //           binding: ForgotPasswordBinding(),
  //           transition: Transition.rightToLeft,
  //           children: [
  //             GetPage(
  //                 name:  _Paths.alertForgotPassword,
  //                 page: () => const AlertForgotPassword(),
  //                 transition: Transition.rightToLeft),
  //           ]
  //       ),
  //     ]),
  // GetPage(
  //     name: _Paths.loginDeepLink,
  //     page: () => const LoginPage(),
  //     binding: AuthBinding(),
  //     middlewares: [
  //       AppMiddleWare(),
  //     ],
  //     children: [
  //       GetPage(
  //           name: _Paths.forgotPassword,
  //           page: () => const ForgotPasswordPage(),
  //           binding: ForgotPasswordBinding(),
  //           transition: Transition.rightToLeft),
  //     ]),
  // GetPage(
  //     name: _Paths.completeRegistration,
  //     page: () => const CompleteRegistrationPage(),
  //     bindings: [CompleteRegistrationBinding(), UserInformationBinding()],
  //     transition: Transition.rightToLeft),
  // GetPage(
  //     name: _Paths.resetPasswordDeepLink,
  //     page: () => const ResetPasswordPage(),
  //     binding: ResetPasswordBinding(),
  //     transition: Transition.rightToLeft),
  // GetPage(
  //     name: _Paths.home,
  //     page: () => const HomePage(),
  //     middlewares: [
  //       AppMiddleWare(),
  //     ],
  //     binding: HomeBinding(),
  //     children: [
  //       GetPage(
  //           name: _Paths.userSetting,
  //           page: () => UserSettingPage(),
  //           transition: Transition.rightToLeft,
  //           children: [
  //             GetPage(
  //                 name: _Paths.userInformation,
  //                 page: () => const UserInformationPage(),
  //                 binding: UserInformationBinding(),
  //                 transition: Transition.rightToLeft),
  //           ]),
  //       GetPage(
  //           name: _Paths.onlinePharmacy,
  //           page: () => OnlinePharmacyPage(),
  //           transition: Transition.rightToLeft,
  //           children: [
  //             GetPage(
  //                 name: _Paths.questionnaire,
  //                 page: () => QuestionnairePage(),
  //                 binding: QuestionnaireBinding(),
  //                 transition: Transition.rightToLeft),
  //             GetPage(
  //                 name: _Paths.pharmacyList,
  //                 page: () => const PharmacyListPage(),
  //                 transition: Transition.rightToLeft,
  //                 binding: PharmacyBinding(),
  //                 children: [
  //                   GetPage(
  //                     name: _Paths.pharmacyInformation,
  //                     page: () => PharmacyInformationPage(),
  //                     transition: Transition.rightToLeft,
  //                   )
  //                 ]),
  //             GetPage(
  //                 name: _Paths.drugList,
  //                 binding: DrugListBinding(),
  //                 page: () => DrugListPage(),
  //                 transition: Transition.rightToLeft,
  //                 children: [
  //                   GetPage(
  //                       name: _Paths.drugCategory,
  //                       page: () => DrugCategoryPage(),
  //                       transition: Transition.rightToLeft),
  //                 ]),
  //             GetPage(
  //                 name: _Paths.drugDetail,
  //                 page: () => const DrugDetailPage(),
  //                 binding: DrugDetailBinding(),
  //                 transition: Transition.rightToLeft),
  //             GetPage(
  //                 name: _Paths.orderHistory,
  //                 page: () => OrderHistoryPage(),
  //                 binding: OrderHistoryBinding(),
  //                 transition: Transition.rightToLeft,
  //                 children: [
  //                   GetPage(
  //                     name: _Paths.orderHistoryDetail,
  //                     page: () => OrderHistoryDetailPage(),
  //                     binding: OrderHistoryDetailBinding(),
  //                     transition: Transition.rightToLeft,
  //                   )
  //                 ]),
  //             GetPage(
  //                 name: _Paths.orderList,
  //                 binding: OrderListBinding(),
  //                 page: () => OrderListPage(),
  //                 transition: Transition.rightToLeft,
  //                 children: [
  //                   GetPage(
  //                       name: _Paths.confirmOrder,
  //                       binding: ConfirmOrderBinding(),
  //                       page: () => const ConfirmOrderPage(),
  //                       transition: Transition.rightToLeft),
  //                 ]),
  //             GetPage(
  //                 name: _Paths.registrationInformation,
  //                 page: () => RegistrationInformationPage(),
  //                 binding: RegistrationInformationBinding(),
  //                 transition: Transition.rightToLeft),
  //           ]),
  //       GetPage(
  //           name: _Paths.consultationService,
  //           page: () => ConsultationServicePage(),
  //           transition: Transition.rightToLeft),
  //     ]),
  // GetPage(
  //     name: _Paths.qa,
  //     page: () => QAPage(),
  //     transition: Transition.rightToLeft),
];
