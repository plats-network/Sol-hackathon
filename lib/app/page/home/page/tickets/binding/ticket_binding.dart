import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/tickets/controller/ticket_controller.dart';
import 'package:plat_app/app/page/home/page/tickets/provider/ticket_provider.dart';

class TicketBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TicketProvider());
    Get.lazyPut(() => TicketController());
  }
}