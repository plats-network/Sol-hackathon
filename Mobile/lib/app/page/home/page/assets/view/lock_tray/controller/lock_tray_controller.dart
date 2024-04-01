import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/model/asset_response.dart'
    as asset_response;
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/model/lock_tray_response.dart'
    as lock_tray_response;
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/model/update_lock_tray_response.dart'
    as update_lock_tray_response;
import 'package:plat_app/app/page/home/page/assets/view/lock_tray/provider/lock_tray_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class LockTrayController extends GetxController {
  final LockTrayProvider lockTrayProvider = Get.find();
  final lockItemListData =
      Rx(NetworkResource<lock_tray_response.LockTrayResponse>.init());
  final assetListData =
      Rx(NetworkResource<asset_response.AssetResponse>.init());
  final sendToMainTrayData = Rx(
      NetworkResource<update_lock_tray_response.UpdateLockTrayResponse>.init());

  final currentPage = 0.obs;
  final lockItemList = <lock_tray_response.Data>[].obs;
  final assetList = <asset_response.Data>[].obs;
  num? get totalPage => lockItemListData.value.data?.meta?.total;

  void fetchLockItemList() async {
    lockItemListData.value =
        NetworkResource<lock_tray_response.LockTrayResponse>.loading();

    const page = 1;

    final result = await lockTrayProvider.fetchLockItemList(page);

    currentPage.value = page;

    NetworkResource.handleResponse(
      result,
      lock_tray_response.LockTrayResponse.fromJson,
      lockItemListData,
      isShowError: false,
    );

    if (lockItemListData.value.isSuccess()) {
      if (lockItemListData.value.data?.data != null) {
        lockItemList.value = lockItemListData.value.data!.data!;
      }
    } else if (lockItemListData.value.isError()) {
      lockItemList.value = [];
    }
  }

  void fetchAssetList() async {
    assetListData.value =
        NetworkResource<asset_response.AssetResponse>.loading();
    final result = await lockTrayProvider.fetchRewrdList();
    NetworkResource.handleResponse(
      result,
      asset_response.AssetResponse.fromJson,
      assetListData,
      isShowError: false,
    );
    print('log $assetListData');
    if (assetListData.value.isSuccess()) {
      if (assetListData.value.data?.data != null) {
        assetList.value = assetListData.value.data!.data!;
        print('done');
      }
    } else if (assetListData.value.isError()) {
      assetList.value = [];
      print('errer');
    }
  }

  void sendToMainTray(String itemId) async {
    sendToMainTrayData.value = NetworkResource<
        update_lock_tray_response.UpdateLockTrayResponse>.loading();

    final result = await lockTrayProvider.putSendToMainTray(
      itemId.toString(),
    );

    NetworkResource.handleResponse(
      result,
      update_lock_tray_response.UpdateLockTrayResponse.fromJson,
      sendToMainTrayData,
      isShowError: false,
    );

    sendToMainTrayData.value = NetworkResource<
        update_lock_tray_response.UpdateLockTrayResponse>.init();
  }

  bool isLockItemListLoading() {
    return lockItemListData.value.isLoading();
  }

  bool isLockItemListError() {
    return lockItemListData.value.isError();
  }

  bool hasNextPage() =>
      lockItemListData.value.data?.meta?.currentPage != null &&
      lockItemListData.value.data?.meta?.lastPage != null &&
      (lockItemListData.value.data!.meta!.currentPage ?? 0) <
          (lockItemListData.value.data!.meta!.lastPage ?? 0);

  void loadMoreLockItem() async {
    if (!hasNextPage()) {
      return;
    }

    lockItemListData.value =
        NetworkResource<lock_tray_response.LockTrayResponse>.loading();

    currentPage.value++;

    final result = await lockTrayProvider.fetchLockItemList(currentPage.value);

    NetworkResource.handleResponse(
      result,
      lock_tray_response.LockTrayResponse.fromJson,
      lockItemListData,
      isShowError: true,
    );

    if (lockItemListData.value.isSuccess()) {
      if (lockItemListData.value.data?.data != null) {
        lockItemList.addAll(lockItemListData.value.data!.data!);
      }
    }
  }
}
