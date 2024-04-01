import 'package:get/get.dart';
import 'package:plat_app/base/provider/base/action_provider.dart';

class GroupProvider extends ActionProvider {
  Future<Response<dynamic>> fetchGroupProvider(int page) =>
      get('/groups?page=$page');
  Future<Response<dynamic>> fetchAllGroupProvider() => get('/groups');
  Future<Response<dynamic>> fetchInfoGroupProvider(String groupId) => get('/groups/$groupId');
  Future<Response<dynamic>> fetchMyGroupProvider(int page) =>
      get('/my-groups?page=$page');
  Future<Response<dynamic>> fetchAllMyGroupProvider() => get('/my-groups');
  Future<Response<dynamic>> fetchJoinGroupProvider(String groupId) =>
      post('/join-group', {"group_id": groupId});
}
