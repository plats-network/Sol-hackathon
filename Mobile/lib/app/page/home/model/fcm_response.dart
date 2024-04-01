/// notification : {"title":"Nhận đc bonus box","description":"Mô tả","icon":"https://i.imgur.com/UuCaWFA.png"}
/// data : {"action":"BOX","box_id":"1323-1312-3213-3123123"}

class FcmResponse {
  FcmResponse({
      this.notification, 
      this.data,});

  FcmResponse.fromJson(dynamic json) {
    notification = json['notification'] != null ? Notification.fromJson(json['notification']) : null;
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Notification? notification;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (notification != null) {
      map['notification'] = notification?.toJson();
    }
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// action : "BOX"
/// box_id : "1323-1312-3213-3123123"

class Data {
  Data({
      this.action, 
      this.boxId,});

  Data.fromJson(dynamic json) {
    action = json['action'];
    boxId = json['box_id'];
  }
  String? action;
  String? boxId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = action;
    map['box_id'] = boxId;
    return map;
  }

}

/// title : "Nhận đc bonus box"
/// description : "Mô tả"
/// icon : "https://i.imgur.com/UuCaWFA.png"

class Notification {
  Notification({
      this.title, 
      this.description, 
      this.icon,});

  Notification.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
  }
  String? title;
  String? description;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['icon'] = icon;
    return map;
  }

}