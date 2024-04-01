import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/voucher_history/provider/voucher_history_provider.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/model/gift_list_response.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class VoucherHistoryController extends GetxController {
  final usedVoucherListData = Rx(NetworkResource<GiftListResponse>.init());
  final expiredVoucherListData = Rx(NetworkResource<GiftListResponse>.init());
  final VoucherHistoryProvider voucherHistoryProvider = Get.find();
  final usedVoucherPage = 0.obs;
  final expiredVoucherPage = 0.obs;

  final usedVoucherList = <Data>[].obs;
  final expiredVoucherList = <Data>[].obs;

  get usedVoucherTotalPage => usedVoucherListData.value.data?.meta?.total;
  get expiredVoucherTotalPage => expiredVoucherListData.value.data?.meta?.total;

  void fetchVoucherHistory() {
    _fetchUsedVoucherList();
    _fetchExpiredVoucherList();
  }

  void _fetchUsedVoucherList() async {
    usedVoucherListData.value = NetworkResource<GiftListResponse>.loading();

    const page = 1;
    final result = await voucherHistoryProvider.fetchUsedVoucherList(page);

    usedVoucherPage.value = page;

    NetworkResource.handleResponse(
      result,
      GiftListResponse.fromJson,
      usedVoucherListData,
      isShowError: false,
    );

    if (usedVoucherListData.value.isSuccess()) {
      if (usedVoucherListData.value.data?.data != null) {
        usedVoucherList.value = usedVoucherListData.value.data!.data!;
      }
    }
  }

  void _fetchExpiredVoucherList() async {
    expiredVoucherListData.value = NetworkResource<GiftListResponse>.loading();

    const page = 1;
    final result = await voucherHistoryProvider.fetchExpiredVoucherList(page);

    expiredVoucherPage.value = page;

    NetworkResource.handleResponse(
      result,
      GiftListResponse.fromJson,
      expiredVoucherListData,
      isShowError: false,
    );

    if (expiredVoucherListData.value.isSuccess()) {
      if (expiredVoucherListData.value.data?.data != null) {
        expiredVoucherList.value = expiredVoucherListData.value.data!.data!;
      }
    }
  }

  void loadMoreUsedVoucher() async {
    usedVoucherListData.value = NetworkResource<GiftListResponse>.loading();

    usedVoucherPage.value++;

    final result = await voucherHistoryProvider
        .fetchUsedVoucherList(usedVoucherPage.value);

    NetworkResource.handleResponse(
      result,
      GiftListResponse.fromJson,
      usedVoucherListData,
      isShowError: true,
    );

    if (usedVoucherListData.value.isSuccess()) {
      if (usedVoucherListData.value.data?.data != null) {
        usedVoucherList.addAll(usedVoucherListData.value.data!.data!);
      }
    }
  }

  void loadMoreExpiredVoucher() async {
    expiredVoucherListData.value = NetworkResource<GiftListResponse>.loading();

    expiredVoucherPage.value++;

    final result = await voucherHistoryProvider
        .fetchExpiredVoucherList(expiredVoucherPage.value);

    NetworkResource.handleResponse(
      result,
      GiftListResponse.fromJson,
      expiredVoucherListData,
      isShowError: true,
    );

    if (expiredVoucherListData.value.isSuccess()) {
      if (expiredVoucherListData.value.data?.data != null) {
        expiredVoucherList.addAll(expiredVoucherListData.value.data!.data!);
      }
    }
  }

  bool isVoucherHistoryLoading() {
    return usedVoucherListData.value.isLoading() ||
        expiredVoucherListData.value.isLoading();
  }

  bool isUsedVoucherLoading() {
    return usedVoucherListData.value.isLoading();
  }

  bool isExpiredVoucherLoading() {
    return expiredVoucherListData.value.isLoading();
  }

  bool isUsedVoucherListError() {
    return usedVoucherListData.value.isError();
  }

  bool isExpiredVoucherListError() {
    return expiredVoucherListData.value.isError();
  }
}
