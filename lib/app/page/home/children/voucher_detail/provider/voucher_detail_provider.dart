import 'package:plat_app/base/provider/base/action_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class VoucherDetailProvider extends ActionProvider {
  String fetchWebViewVoucherUrl(String voucherId) {
    return '${dotenv.env['BASE_ACTIONHUB_URL']}/voucher/$voucherId';
  }
}
