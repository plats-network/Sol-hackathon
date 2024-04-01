import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/nfts/model/nft_list_response.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/nfts/provider/nft_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class NftController extends GetxController {
  final NftProvider boxProvider = Get.find();
  final nftListData = Rx(NetworkResource<NftListResponse>.init());

  final currentPage = 0.obs;
  final nftList = <Data>[].obs;
  num? get totalPage => nftListData.value.data?.meta?.total;

  void fetchNftList() async {
    nftListData.value = NetworkResource<NftListResponse>.loading();

    nftList.clear();

    const page = 1;

    final result = await boxProvider.fetchNftList(page);

    currentPage.value = page;

    NetworkResource.handleResponse(
      result,
      NftListResponse.fromJson,
      nftListData,
      isShowError: false,
    );

    if (nftListData.value.isSuccess()) {
      if (nftListData.value.data?.data != null) {
        nftList.value = nftListData.value.data!.data!;
      }
    }
  }

  bool isNftListLoading() {
    return nftListData.value.isLoading();
  }

  bool isNftListError() {
    return nftListData.value.isError();
  }

  void loadMoreNftItem() async {
    if (!hasNextPage()) return;

    nftListData.value = NetworkResource<NftListResponse>.loading();

    currentPage.value++;

    final result = await boxProvider.fetchNftList(currentPage.value);

    NetworkResource.handleResponse(
      result,
      NftListResponse.fromJson,
      nftListData,
      isShowError: true,
    );

    if (nftListData.value.isSuccess()) {
      if (nftListData.value.data?.data != null) {
        nftList.addAll(nftListData.value.data!.data!);
      }
    }
  }

  bool hasNextPage() =>
      nftListData.value.data?.meta?.currentPage != null &&
      nftListData.value.data?.meta?.lastPage != null &&
      (nftListData.value.data!.meta!.currentPage ?? 0) <
          (nftListData.value.data!.meta!.lastPage ?? 0);
}
