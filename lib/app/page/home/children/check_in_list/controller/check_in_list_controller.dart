import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/check_in_list/provider/check_in_list_provider.dart';
import 'package:plat_app/app/page/home/page/home_tab/models/check_in_task_list_response.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class CheckInListController extends GetxController {
  late CheckInListProvider checkInListProvider = Get.find();
  late CheckInListController checkInListController = Get.find();
  final checkInListData = Rx(NetworkResource<CheckInTaskListResponse>.init());
  final tasks = RxList<Data>([]);
  final currentPage = 0.obs;
  final totalPage = 1.obs;

//get all check in task
  fetchCheckInTaskWithPage(int page) async {
    checkInListData.value = NetworkResource<CheckInTaskListResponse>.loading(
        data: checkInListData.value.data);
    final result =
        await checkInListProvider.fetchCheckInTaskWithPageProvider(page);
    NetworkResource.handleResponse(
        result, CheckInTaskListResponse.fromJson, checkInListData);
  }

  void loadMoreCheckInTask(int page) async {
    await fetchCheckInTaskWithPage(page);
    if (isCheckInListSuccess() && checkInListData.value.data != null) {
      tasks.addAll(checkInListData.value.data!.data!);
      currentPage.value = page;
      totalPage.value = checkInListData.value.data!.meta!.lastPage! as int;
      update();
    }
  }

  bool isCheckInListError() {
    return checkInListData.value.isError();
  }

  bool isCheckInListSuccess() {
    return checkInListData.value.isSuccess();
  }

  bool isCheckInListLoading() {
    return checkInListData.value.isLoading();
  }
}
