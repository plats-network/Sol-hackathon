import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:plat_app/base/controllers/auth/auth_controller.dart';
import 'package:plat_app/base/controllers/language/language_controller.dart';
import 'package:plat_app/base/provider/base/provider_utils.dart';
import 'package:plat_app/base/resources/constants/base_constraint.dart';
import 'package:plat_app/base/routes/base_pages.dart';

abstract class BaseProvider extends GetConnect {
  late AuthController authController = Get.find();
  final LanguageController languageController = Get.find();
  final storage = GetStorage();

  String apiUrlEnvKey();

  @override
  void onInit() async {
    httpClient.baseUrl = dotenv.env[apiUrlEnvKey()];
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.addRequestModifier<dynamic>((request) async {
      // Set accept
      request.headers['Accept'] = "application/json";
      // Set bearer token
      final accessToken = storage.read(keyAccessToken);
      final token =
          authController.authData.value.data?.data?.jwt?.accessToken ??
              accessToken;
      request.headers['Authorization'] = "Bearer $token";
      logProviderRequest(request);
      return request;
    });
    httpClient.addResponseModifier((request, response) async {
      logProviderResponse(response);
      if (response.statusCode == 403 || response.statusCode == 401) {
        authController.logout();
        Get.offAllNamed(Routes.login);
      }
      return response;
    });
  }
}
