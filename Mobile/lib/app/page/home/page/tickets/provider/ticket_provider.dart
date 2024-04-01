import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/user_provider.dart';

class TicketProvider extends UserProvider {
  Future<Response<dynamic>> getListTicket() => get('/tickets');
}
