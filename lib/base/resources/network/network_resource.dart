import 'dart:convert';

import 'package:get/get.dart';
import 'package:plat_app/base/component/snackbar/getx_default_snack_bar.dart';
import 'package:plat_app/base/model/login_response.dart';

class NetworkResource<T> {
  NetworkResource._({this.message, this.data});

  String? message;
  T? data;

  factory NetworkResource.init({String? message, T? data}) = InitState;

  factory NetworkResource.loading({String? message, T? data}) = LoadingState;

  factory NetworkResource.success({String? message, T? data}) = SuccessState;

  factory NetworkResource.error({String? message, T? data}) = ErrorState;

  bool isInit() {
    return this is InitState;
  }

  bool isSuccess() {
    return this is SuccessState;
  }

  bool isLoading() {
    return this is LoadingState;
  }

  bool isError() {
    return this is ErrorState;
  }

  static void handleLoginResponse(Response result,
      {required Function(LoginResponse) onSuccess,
      required Function(String?) onFail}) {
    if (result.isSuccess) {
      try {
        final jsonStr = jsonDecode(result.bodyString.toString());
        final _response = LoginResponse.fromJson(jsonStr);
        onSuccess(_response);
      } catch (e) {
        e.printError();
        onFail(e.toString());
      }
    } else {
      try {
        final jsonStr = jsonDecode(result.bodyString.toString());
        final _response = LoginResponse.fromJson(jsonStr);
        onFail(_response.message ?? result.statusText);
      } catch (e) {
        e.printError();
        onFail('please_check_internet'.tr);
      }
    }
  }

  static void handleResponse<T>(
      Response result, Function(dynamic) decoder, Rx<NetworkResource<T>> _data,
      {bool isShowError = false}) {
    if (result.isSuccess) {
      try {
        final jsonStr = jsonDecode(result.bodyString.toString());
        final _response = decoder(jsonStr);
        _data.value = NetworkResource<T>.success(data: _response);
      } catch (e) {
        e.printError();
        if (isShowError) {
          // Show error
          // GetXDefaultSnackBar.errorSnackBar(
          //     title: 'server_error'.tr, message: 'api_parsing_error'.tr);
        }
        _data.value = NetworkResource<T>.error(
            message: e.toString(), data: _data.value.data);
      }
    } else {
      try {
        final jsonStr = jsonDecode(result.bodyString.toString());
        if (jsonStr == null) {
          // Show network error
          // GetXDefaultSnackBar.errorSnackBar(
          //     title: 'network_error'.tr, message: 'please_check_internet'.tr);
        } else {
          final _response = decoder(jsonStr);
          _data.value = NetworkResource<T>.error(
            message: _response.message ?? result.statusText,
            data: _response,
          );
          if (isShowError) {
            // Show error
            // GetXDefaultSnackBar.errorSnackBar(
            //     title: 'error'.tr,
            //     message: _response.message ?? result.statusText);
          }
        }
      } catch (e) {
        e.printError();
        _data.value = NetworkResource<T>.error(
            message: result.statusText, data: _data.value.data);
        if (isShowError) {
          // Show error
          // GetXDefaultSnackBar.errorSnackBar(
          //     title: 'network_error'.tr, message: 'please_check_internet'.tr);
        }
      }
    }
  }
}

class InitState<T> extends NetworkResource<T> {
  InitState({String? message, T? data}) : super._(message: message, data: data);
}

class LoadingState<T> extends NetworkResource<T> {
  LoadingState({String? message, T? data})
      : super._(message: message, data: data);
}

class ErrorState<T> extends NetworkResource<T> {
  ErrorState({String? message, T? data})
      : super._(message: message, data: data);
}

class SuccessState<T> extends NetworkResource<T> {
  SuccessState({String? message, T? data})
      : super._(message: message, data: data);
}

extension ResponseExtension on Response {
  bool get isSuccess => isOk && body != null;
}
