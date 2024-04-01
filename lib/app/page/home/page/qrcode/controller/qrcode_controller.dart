import 'dart:developer';

import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/qrcode/model/qr_code_reponse.dart'
    as qrCode;
import 'package:plat_app/app/page/home/page/qrcode/model/result_scan_qr_code_reponse.dart' as resultScanQrCode;
import 'package:plat_app/app/page/home/children/social_task_detail/model/get_ticket_reponse.dart' as getTicket;
import 'package:plat_app/app/page/home/page/qrcode/provider/qr_code_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class QrCodeController extends GetxController {
  final QrCodeProvider qrCodeProvider = Get.find();
  final submitQrCode = Rx(NetworkResource<qrCode.QrCodeResponse>.init());
  final resultQrCode = Rx(NetworkResource<resultScanQrCode.ResultScanQRCodeResponse>.init());
  final resultGetTicket = Rx(NetworkResource<getTicket.GetTicketResponse>.init());

  Future<void> fetchScanQrCode(String type, String code) async {
    submitQrCode.value = NetworkResource.loading();

    final result = await qrCodeProvider.scanQrCode(type, code);
    NetworkResource.handleResponse(
      result,
      qrCode.QrCodeResponse.fromJson,
      submitQrCode,
    );
  }

  bool isFetchingQrCode() {
    return submitQrCode.value.isLoading();
  }

  bool isQrCodeFetchSuccess() {
    return submitQrCode.value.isSuccess();
  }

  Future<void> fetchResultScanQrCode(String taskId) async {
    resultQrCode.value = NetworkResource.loading();

    final result = await qrCodeProvider.resultScanQrCode(taskId);
    NetworkResource.handleResponse(
      result,
      resultScanQrCode.ResultScanQRCodeResponse.fromJson,
      resultQrCode,
    );
  }
   bool isFetchingResultQrCode() {
    return resultQrCode.value.isLoading();
  }

  bool isResultQrCodeFetchSuccess() {
    return resultQrCode.value.isSuccess();
  }

}
