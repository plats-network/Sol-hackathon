import 'package:plat_app/app/page/home/children/social_task_detail/model/social_task_detail_response.dart';

/// success : true
/// message : null
/// data : {"id":"97d9e0d4-4003-4355-a417-7ea9ea530726","user_id":"96be321e-296b-469e-bc2e-3f977c8bdf3a","location_id":"97be6c94-270d-4d26-a5e8-5369d7199a02","started_at":"2022-11-28 14:25:57","ended_at":"2022-11-28T09:14:26.347159Z","checkin_image":"https://d37c8ertxcodlq.cloudfront.net/","activity_log":null,"reward":{"name":"My box","type":0,"description":"Desc my box","image":"https://d37c8ertxcodlq.cloudfront.net/icon/hidden_box.png","created_at":"2022-11-07T04:28:45.000000Z","updated_at":"2022-11-07T04:29:01.000000Z","region":0,"start_at":"2022-11-07","end_at":"2023-11-02"}}

class CheckinLocationInTaskResponse {
  CheckinLocationInTaskResponse({
    this.success,
    this.message,
    this.data,
  });

  CheckinLocationInTaskResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  dynamic message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// id : "97d9e0d4-4003-4355-a417-7ea9ea530726"
/// user_id : "96be321e-296b-469e-bc2e-3f977c8bdf3a"
/// location_id : "97be6c94-270d-4d26-a5e8-5369d7199a02"
/// started_at : "2022-11-28 14:25:57"
/// ended_at : "2022-11-28T09:14:26.347159Z"
/// checkin_image : "https://d37c8ertxcodlq.cloudfront.net/"
/// activity_log : null
/// reward : {"name":"My box","type":0,"description":"Desc my box","image":"https://d37c8ertxcodlq.cloudfront.net/icon/hidden_box.png","created_at":"2022-11-07T04:28:45.000000Z","updated_at":"2022-11-07T04:29:01.000000Z","region":0,"start_at":"2022-11-07","end_at":"2023-11-02"}

class Data {
  Data({
    this.id,
    this.userId,
    this.locationId,
    this.startedAt,
    this.endedAt,
    this.checkinImage,
    this.activityLog,
    this.reward,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    userId = json['user_id'];
    locationId = json['location_id'];
    startedAt = json['started_at'];
    endedAt = json['ended_at'];
    checkinImage = json['checkin_image'];
    activityLog = json['activity_log'];
    reward = json['reward'] != null ? Rewards.fromJson(json['reward']) : null;
  }

  String? id;
  String? userId;
  String? locationId;
  String? startedAt;
  String? endedAt;
  String? checkinImage;
  dynamic activityLog;
  Rewards? reward;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['user_id'] = userId;
    map['location_id'] = locationId;
    map['started_at'] = startedAt;
    map['ended_at'] = endedAt;
    map['checkin_image'] = checkinImage;
    map['activity_log'] = activityLog;
    if (reward != null) {
      map['reward'] = reward?.toJson();
    }
    return map;
  }
}
