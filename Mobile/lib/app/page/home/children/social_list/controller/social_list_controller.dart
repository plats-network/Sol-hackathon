import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/social_list/provider/social_list_provider.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/social_task_list_response.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class SocialListController extends GetxController {
  late SocialListProvider socialListProvider = Get.find();
  final socialListData = Rx(NetworkResource<SocialTaskListResponse>.init());
  final tasks = RxList<Data>([]);
  final currentPage = 0.obs;
  final totalPage = 1.obs;

  fetchSocialTaskWithPage(int page) async {
    socialListData.value = NetworkResource<SocialTaskListResponse>.loading(
        data: socialListData.value.data);
    final result =
        await socialListProvider.fetchSocialTaskWithPageProvider(page);
    NetworkResource.handleResponse(
        result, SocialTaskListResponse.fromJson, socialListData);
  }

  void loadMoreSocialTask(int page) async {
    await fetchSocialTaskWithPage(page);
    if (isSocialListSuccess() && socialListData.value.data != null) {
      tasks.addAll(socialListData.value.data!.data!);
      currentPage.value = page;
      totalPage.value = socialListData.value.data!.meta!.lastPage! as int;
      update();
    }
  }

  bool isSocialListError() {
    return socialListData.value.isError();
  }

  bool isSocialListSuccess() {
    return socialListData.value.isSuccess();
  }

  bool isSocialListLoading() {
    return socialListData.value.isLoading();
  }
}
