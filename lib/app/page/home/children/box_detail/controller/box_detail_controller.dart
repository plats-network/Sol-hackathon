import 'package:get/get.dart';
import 'package:plat_app/app/page/home/children/box_detail/model/box_detail_response.dart';
import 'package:plat_app/app/page/home/children/box_detail/model/box_detail_unbox_response.dart';
import 'package:plat_app/app/page/home/children/box_detail/provider/box_detail_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class BoxDetailController extends GetxController {
  final BoxDetailProvider boxDetailProvider = Get.find();
  final boxDetailData = Rx(NetworkResource<BoxDetailResponse>.init());
  final boxDetailUnboxData = Rx(NetworkResource<BoxDetailUnboxResponse>.init());

  @override
  void dispose() {
    // Get.delete<TaskDetailController>();
    onDelete();
    Get.log('BoxDetailController onDelete() called');
    super.dispose();
  }

  void fetchBoxDetail(boxDetailId) async {
    boxDetailData.value = NetworkResource.loading();

    final result = await boxDetailProvider.fetchBoxDetailProvider(boxDetailId);

    NetworkResource.handleResponse(
      result,
      BoxDetailResponse.fromJson,
      boxDetailData,
      isShowError: true,
    );
  }

  void unbox(boxDetailId) async {
    final result = await boxDetailProvider.putUnbox(boxDetailId);

    NetworkResource.handleResponse(
      result,
      BoxDetailUnboxResponse.fromJson,
      boxDetailUnboxData,
      isShowError: true,
    );
  }

  bool isFetchingBoxDetail() => boxDetailData.value.isLoading();

  bool isUnboxTaskDetailSuccess() => boxDetailUnboxData.value.isSuccess();
}
