import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/setting/children/password_security/provider/password_security_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class PasswordSecurityController extends GetxController {
  final PasswordSecurityProvider passwordSecurityProvider =
      Get.find<PasswordSecurityProvider>();

  final Rx<NetworkResource<dynamic>> deleteAccountData =
      Rx(NetworkResource<dynamic>.init());

  Future<void> deleteAccount() async {
    deleteAccountData.value = NetworkResource<dynamic>.loading();
    final Response result = await passwordSecurityProvider.deleteAccount();
    NetworkResource.handleResponse(result, (json) => json, deleteAccountData);
  }

  bool isDeleteAccountLoading() {
    return deleteAccountData.value.isLoading();
  }
}
