import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/group/provider/group_provider.dart';
import 'package:plat_app/app/page/home/page/home_tab/provider/home_task_provider.dart';
import 'package:plat_app/app/page/home/page/index/model/trending_event_reponse.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class HomeTabController extends GetxController {
  late HomeTaskProvider homeTaskProvider = Get.find();
  late GroupProvider groupProvider = Get.find();
  final eventData = Rx(NetworkResource<EventResponse>.init());
  final isHomeInit = false.obs;

// search event
  Future<void> fetchSearch(String keyword) async {
    eventData.value =
        NetworkResource<EventResponse>.loading(data: eventData.value.data);
    var result = await homeTaskProvider.fetchSearch(keyword);

    NetworkResource.handleResponse(
      result,
      EventResponse.fromJson,
      eventData,
      isShowError: true,
    );
  }

  bool isSearchError() {
    return eventData.value.isError();
  }

  bool isSearchSuccess() {
    return eventData.value.isSuccess();
  }

  bool isSearchLoading() {
    return eventData.value.isLoading();
  }

  Future<bool> fetchRemoteConfigForAssets() async {
    final variant = dotenv.env['VARIANT'];
    if (variant != 'store') {
      final remoteConfig = FirebaseRemoteConfig.instance;
      final showAssetsTab = remoteConfig.getBool('show_assets_tab');
      return showAssetsTab;
    } else {
      return true;
    }
  }

  // fetchAllGroup(String groupId) async {
  //   groupListData.value =
  //       NetworkResource<GroupResponse>.loading(data: groupListData.value.data);
  //   var result = await groupProvider.fetchInfoGroupProvider(groupId);

  //   NetworkResource.handleResponse(
  //       result, GroupResponse.fromJson, groupListData,
  //       isShowError: true);
  // }
}
