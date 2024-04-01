import 'dart:developer';

import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/tickets/model/ticket_reponse.dart';
import 'package:plat_app/app/page/home/page/tickets/provider/ticket_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class TicketController extends GetxController {
  final TicketProvider ticketProvider = Get.find();
  final ticketData = Rx(NetworkResource<TicketResponse>.init());

  Future<void> fechTicket() async {
    ticketData.value = NetworkResource.loading();

    final result = await ticketProvider.getListTicket();
    NetworkResource.handleResponse(
      result,
      TicketResponse.fromJson,
      ticketData,
    );
  }

  bool isFetchingTicket() {
    return ticketData.value.isLoading();
  }

  bool isTicketFetchSuccess() {
    return ticketData.value.isSuccess();
  }

}
