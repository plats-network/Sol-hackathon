import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/box_history/provider/box_history_provider.dart';
import 'package:plat_app/app/page/home/page/assets/view/main_tray/gifts/model/gift_list_response.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class BoxHistoryController extends GetxController {
  final BoxHistoryProvider boxHistoryProvider = Get.find();
  final boxHistoryData =
      Rx<NetworkResource<GiftListResponse>>(NetworkResource.init());
  final boxList = <Data>[].obs;

  Future<void> fetchBoxHistory() async {
    boxHistoryData.value = NetworkResource.loading();

    final currentPage = boxHistoryData.value.data?.meta?.currentPage ?? 1;
    final result = await boxHistoryProvider.fetchBoxHistory(currentPage);

    NetworkResource.handleResponse(
      result,
      GiftListResponse.fromJson,
      boxHistoryData,
      isShowError: true,
    );

    boxList.value = boxHistoryData.value.data?.data ?? [];
  }

  Future<void> fetchNextPageBoxHistory() async {
    if (!hasNextPage()) return;

    final currentPage = boxHistoryData.value.data?.meta?.currentPage ?? 1;
    final result = await boxHistoryProvider.fetchBoxHistory(currentPage + 1);

    NetworkResource.handleResponse(
      result,
      GiftListResponse.fromJson,
      boxHistoryData,
      isShowError: true,
    );

    boxList.addAll(boxHistoryData.value.data?.data ?? []);
  }

  bool hasNextPage() =>
      boxHistoryData.value.data?.meta?.currentPage != null &&
      boxHistoryData.value.data?.meta?.lastPage != null &&
      (boxHistoryData.value.data!.meta!.currentPage ?? 0) <
          (boxHistoryData.value.data!.meta!.lastPage ?? 0);

  bool isBoxHistoryLoading() => boxHistoryData.value.isLoading();
}
