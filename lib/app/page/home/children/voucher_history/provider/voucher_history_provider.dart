import 'package:plat_app/base/provider/base/action_provider.dart';

class VoucherHistoryProvider extends ActionProvider {
  fetchUsedVoucherList(int page) {
    return get(
      '/gifts?type=gift&status=used&page=$page',
    );
  }

  fetchExpiredVoucherList(int page) {
    return get(
      '/gifts?type=gift&status=expired&page=$page',
    );
  }
}
