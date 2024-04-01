import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/register/model/register_response.dart';
import 'package:plat_app/app/page/login/children/register/provider/register_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class RegisterController extends GetxController {
  late RegisterProvider registerProvider = Get.find();

  final registerData = Rx(NetworkResource<RegisterResponse>.init());

  void register(email, password, fullName) async {
    registerData.value = NetworkResource<RegisterResponse>.loading();
    final body = {
      'email': email,
      'password': password,
      'password_confirmation': password,
      'name': fullName,
      'term': true
    };
    final result = await registerProvider.postRegister(body);

    // TODO: mock data

    NetworkResource.handleResponse(
        result, RegisterResponse.fromJson, registerData);
  }

  bool isRegisterError() {
    return registerData.value.isError();
  }

  bool isRegisterSuccess() {
    return registerData.value.isSuccess();
  }

  bool isRegistering() {
    return registerData.value.isLoading();
  }

  Future<String> fetchRemoteConfigForTermsAndConditions() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    final showAssetsTab = remoteConfig.getString('link_privacy');

    return showAssetsTab;
  }
}
