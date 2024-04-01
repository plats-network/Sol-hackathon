import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/token/model/token_list_response.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/token/provider/token_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class TokenController extends GetxController {
  final TokenProvider tokenProvider = Get.find();
  final tokenListData = Rx(NetworkResource<TokenListResponse>.init());

  final currentPage = 0.obs;
  final tokenList = <Data>[].obs;
  num? get totalPage => tokenListData.value.data?.meta?.total;

  void fetchNftList() async {
    tokenListData.value = NetworkResource<TokenListResponse>.loading();

    tokenList.clear();

    const page = 1;
    final result = await tokenProvider.fetchTokenList(page);

    currentPage.value = page;

    NetworkResource.handleResponse(
      result,
      TokenListResponse.fromJson,
      tokenListData,
      isShowError: false,
    );

    if (tokenListData.value.isSuccess()) {
      if (tokenListData.value.data?.data != null) {
        tokenList.value = tokenListData.value.data!.data!;
      }
    }
  }

  bool isTokenListLoading() {
    return tokenListData.value.isLoading();
  }

  bool isTokenListError() {
    return tokenListData.value.isError();
  }

  void loadMoreToken() async {
    if (!hasNextPage()) return;

    tokenListData.value = NetworkResource<TokenListResponse>.loading();

    currentPage.value++;

    final result = await tokenProvider.fetchTokenList(currentPage.value);

    NetworkResource.handleResponse(
      result,
      TokenListResponse.fromJson,
      tokenListData,
      isShowError: true,
    );

    if (tokenListData.value.isSuccess()) {
      if (tokenListData.value.data?.data != null) {
        tokenList.addAll(tokenListData.value.data!.data!);
      }
    }
  }

  bool hasNextPage() =>
      tokenListData.value.data?.meta?.currentPage != null &&
      tokenListData.value.data?.meta?.lastPage != null &&
      (tokenListData.value.data!.meta!.currentPage ?? 0) <
          (tokenListData.value.data!.meta!.lastPage ?? 0);
}
