import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/notification/controller/notification_controller.dart';
import 'package:plat_app/app/page/home/children/notification/provider/notification_provider.dart';
import 'package:plat_app/app/page/home/children/task_detail/provider/task_detail_provider.dart';
import 'package:plat_app/app/page/home/children/task_perform/controller/task_perform_controller.dart';
import 'package:plat_app/app/page/home/children/task_perform/provider/task_perform_provider.dart';
import 'package:plat_app/app/page/home/page/assets/controller/assets_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/controller/lock_tray_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/provider/lock_tray_provider.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/nfts/controller/nft_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/token/controller/token_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/controller/gift_controller.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/nfts/provider/nft_provider.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/token/provider/token_provider.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/provider/gift_provider.dart';
import 'package:plat_app/app/page/home/page/group/controller/group_controller.dart';
import 'package:plat_app/app/page/home/page/group/provider/group_provider.dart';
import 'package:plat_app/app/page/home/page/home_tab/controller/home_tab_controller.dart';
import 'package:plat_app/app/page/home/page/home_tab/provider/home_task_provider.dart';
import 'package:plat_app/app/page/home/page/index/controller/index_controller.dart';
import 'package:plat_app/app/page/home/page/index/provider/index_provider.dart';
import 'package:plat_app/app/page/home/page/qrcode/controller/qrcode_controller.dart';
import 'package:plat_app/app/page/home/page/qrcode/provider/qr_code_provider.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/controller/password_security_controller.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/provider/password_security_provider.dart';
import 'package:plat_app/app/page/home/page/setting/controller/setting_controller.dart';
import 'package:plat_app/app/page/home/page/setting/provider/setting_user_provider.dart';
import 'package:plat_app/app/page/home/page/tickets/controller/ticket_controller.dart';
import 'package:plat_app/app/page/home/page/tickets/provider/ticket_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeTabController());
    Get.lazyPut(() => GiftProvider());
    Get.put(GiftController());
    Get.lazyPut(() => NftProvider());
    Get.lazyPut(() => NftController());
    Get.lazyPut(() => TokenController());
    Get.lazyPut(() => TokenProvider());
    Get.lazyPut(() => LockTrayProvider());
    Get.lazyPut(() => LockTrayController());
    Get.lazyPut(() => QrCodeProvider());
    Get.lazyPut(() => QrCodeController());
    Get.put(AssetsController());
    Get.lazyPut(() => GroupController());
    Get.lazyPut(() => GroupProvider());
    Get.lazyPut(() => HomeTaskProvider());
    Get.lazyPut(() => TaskPerformProvider());
    Get.lazyPut(() => TaskPerformController());
    Get.lazyPut(() => SettingUserProvider());
    Get.put(SettingController());
    Get.lazyPut(() => NotificationProvider());
    Get.lazyPut(() => TaskDetailProvider());
    Get.put(NotificationController());
    Get.lazyPut(() => PasswordSecurityProvider());
    Get.put(PasswordSecurityController());
    Get.lazyPut(() => IndexProvider());
    Get.lazyPut(() => IndexController());
    Get.lazyPut(() => TicketProvider());
    Get.lazyPut(() => TicketController());
  }
}
