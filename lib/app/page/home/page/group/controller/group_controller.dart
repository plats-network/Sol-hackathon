import 'package:get/get.dart';
import 'package:plat_app/app/page/home/page/group/model/group_model.dart';
import 'package:plat_app/app/page/home/page/group/model/join_group_model.dart'
    as join;
import 'package:plat_app/app/page/home/page/group/provider/group_provider.dart';
import 'package:plat_app/base/resources/network/network_resource.dart';

class GroupController extends GetxController {
  late GroupProvider groupProvider = Get.find();
  final groupListData = Rx(NetworkResource<GroupResponse>.init());
  final myGroupListData = Rx(NetworkResource<GroupResponse>.init());
  final submitJoinGroup = Rx(NetworkResource<join.JoinGroupResponse>.init());
  final groups = RxList<Data>([]);
  final myGroups = RxList<Data>([]);
  final currentPage = 0.obs;
  final totalPage = 1.obs;
  final currentMyGroupPage = 0.obs;
  final totalMyGroupPage = 1.obs;
  final isGroupInit = false.obs;

  fetchGroupPage(int page) async {
    groupListData.value =
        NetworkResource<GroupResponse>.loading(data: groupListData.value.data);
    final result = await groupProvider.fetchGroupProvider(page);
    NetworkResource.handleResponse(
        result, GroupResponse.fromJson, groupListData);
  }

  Future<void> fetchAllGroup() async {
    groupListData.value =
        NetworkResource<GroupResponse>.loading(data: groupListData.value.data);
    var result = await groupProvider.fetchAllGroupProvider();

    NetworkResource.handleResponse(
        result, GroupResponse.fromJson, groupListData,
        isShowError: true);
  }
  void fetchGroupById(String group_id) async {
    groupListData.value =
        NetworkResource<GroupResponse>.loading(data: groupListData.value.data);
    var result = await groupProvider.fetchInfoGroupProvider(group_id);

    NetworkResource.handleResponse(
        result, GroupResponse.fromJson, groupListData,
        isShowError: true);
  }

  fetchMyGroup(int page) async {
    myGroupListData.value = NetworkResource<GroupResponse>.loading(
        data: myGroupListData.value.data);
    final result = await groupProvider.fetchMyGroupProvider(page);
    NetworkResource.handleResponse(
        result, GroupResponse.fromJson, myGroupListData);
  }

  Future<void> fetchAllMyGroup() async {
    myGroupListData.value = NetworkResource<GroupResponse>.loading(
        data: myGroupListData.value.data);
    var result = await groupProvider.fetchAllMyGroupProvider();

    NetworkResource.handleResponse(
        result, GroupResponse.fromJson, myGroupListData,
        isShowError: true);
  }

  Future<void> fetchJoinGroup(String groupId) async {
    submitJoinGroup.value = NetworkResource.loading();

    final result = await groupProvider.fetchJoinGroupProvider(groupId);
    NetworkResource.handleResponse(
      result,
      join.JoinGroupResponse.fromJson,
      submitJoinGroup,
    );
  }

  Future<RxList<Data>> loadMoreGroups(int page) async {
    await fetchGroupPage(page);
    if (isGroupListSuccess() && groupListData.value.data != null) {
      groups.addAll(groupListData.value.data!.data!);
      currentPage.value = page;
      totalPage.value = groupListData.value.data!.meta!.lastPage! as int;
      update();
    }
    return groups;
  }

  void loadMoreMyGroups(int page) async {
    await fetchMyGroup(page);
    if (isMyGroupListSuccess() && myGroupListData.value.data != null) {
      myGroups.addAll(myGroupListData.value.data!.data!);
      currentMyGroupPage.value = page;
      totalMyGroupPage.value =
          myGroupListData.value.data!.meta!.lastPage! as int;

      update();
    }
  }

  bool isGroupListError() {
    return groupListData.value.isError();
  }

  bool isGroupListSuccess() {
    return groupListData.value.isSuccess();
  }

  bool isGroupListLoading() {
    return groupListData.value.isLoading();
  }

  bool isMyGroupListError() {
    return myGroupListData.value.isError();
  }

  bool isMyGroupListSuccess() {
    return myGroupListData.value.isSuccess();
  }

  bool isMyGroupListLoading() {
    return myGroupListData.value.isLoading();
  }
}
