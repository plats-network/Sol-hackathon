class ListOngoingEventResponse {
  ListOngoingEventResponse({
    this.success,
    this.message,
    this.data,
  });

  ListOngoingEventResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(OngoingEventData.fromJson(v));
      });
    }
  }
  bool? success;
  dynamic message;
  List<OngoingEventData>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class OngoingEventData {
  OngoingEventData({
    this.id,
    this.name,
    this.userId,
    this.bannerUrl,
    this.eventId,
  });

  OngoingEventData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    userId = json['user_id'];
    bannerUrl = json['image_path'];
    eventId = json['event_id'];
  }
  String? id;
  String? name;
  String? userId;
  String? bannerUrl;
  String? eventId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['user_id'] = userId;
    map['image_path'] = bannerUrl;
    map['event_id'] = eventId;
    return map;
  }
}
