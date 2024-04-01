import 'package:get/get.dart';
import 'package:plat_app/app/page/login/children/forgot_password/model/forgot_password_model.dart';
import 'package:plat_app/app/page/login/children/forgot_password/provider/forgot_password_provider.dart';
import 'package:plat_app/app/resources/constants/app_constraint.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class ForgotPasswordController extends GetxController {
  late ForgotPasswordProvider forgotPasswordProvider = Get.find();

  final forgotPasswordData = Rx(NetworkResource<ForgotPasswordModel>.init());
  final RxInt errorCode = ErrorCode.UNKNOWN_ERROR.obs;

  bool isRequestError() {
    return forgotPasswordData.value.isError();
  }

  bool isRequestSuccess() {
    return forgotPasswordData.value.isSuccess();
  }

  bool isRequesting() {
    return forgotPasswordData.value.isLoading();
  }

  void forgotPassword(email) async {
    forgotPasswordData.value = NetworkResource<ForgotPasswordModel>.loading();

    final result = await forgotPasswordProvider.postForgotPassword(email);

    errorCode.value = result.body?['errorCode'] ?? ErrorCode.UNKNOWN_ERROR;

    NetworkResource.handleResponse(
        result, ForgotPasswordModel.fromJson, forgotPasswordData,
        isShowError: false);
  }
}
