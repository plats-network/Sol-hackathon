import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/model/gift_list_response.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/provider/gift_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class GiftController extends GetxController {
  final GiftProvider giftProvider = Get.find();
  final giftListData = Rx(NetworkResource<GiftListResponse>.init());

  final currentPage = 0.obs;
  final giftList = <Data>[].obs;
  num? get totalPage => giftListData.value.data?.meta?.total;

  void fetchGiftList() async {
    giftListData.value = NetworkResource<GiftListResponse>.loading();

    const page = 1;
    currentPage.value = 0;

    giftList.clear();

    final result = await giftProvider.fetchGiftList(page);

    currentPage.value = page;

    NetworkResource.handleResponse(
      result,
      GiftListResponse.fromJson,
      giftListData,
      isShowError: false,
    );

    if (giftListData.value.isSuccess()) {
      if (giftListData.value.data?.data != null) {
        giftList.value = giftListData.value.data!.data!;
      }
    }
  }

  isGiftListLoading() {
    return giftListData.value.isLoading();
  }

  isGiftListError() {
    return giftListData.value.isError();
  }

  void loadMoreGift() async {
    giftListData.value = NetworkResource<GiftListResponse>.loading();

    currentPage.value++;

    final result = await giftProvider.fetchGiftList(currentPage.value);

    NetworkResource.handleResponse(
      result,
      GiftListResponse.fromJson,
      giftListData,
      isShowError: true,
    );

    if (giftListData.value.isSuccess()) {
      if (giftListData.value.data?.data != null) {
        giftList.addAll(giftListData.value.data!.data!);
      }
    }
  }
}
