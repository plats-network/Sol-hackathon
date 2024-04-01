/// success : true
/// message : null
/// data : {"id":"97d01324-24a9-42a3-ac80-dbf5e7fed4d1","name":"Open the box now!","icon":"https://d37c8ertxcodlq.cloudfront.net/icon/hidden_box.png","expired_date":"23/11/2022","expired_time":"17:28","expired_timestamp":"1669199301","is_expired":true,"is_use":false,"is_use_label":"Not use","is_open":false,"unbox_label":"Unbox"}

class BoxDetailResponse {
  BoxDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  BoxDetailResponse.fromJson(dynamic json) {
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

/// id : "97d01324-24a9-42a3-ac80-dbf5e7fed4d1"
/// name : "Open the box now!"
/// icon : "https://d37c8ertxcodlq.cloudfront.net/icon/hidden_box.png"
/// expired_date : "23/11/2022"
/// expired_time : "17:28"
/// expired_timestamp : "1669199301"
/// is_expired : true
/// is_use : false
/// is_use_label : "Not use"
/// is_open : false
/// unbox_label : "Unbox"

class Data {
  Data({
    this.id,
    this.name,
    this.icon,
    this.expiredDate,
    this.expiredTime,
    this.expiredTimestamp,
    this.isExpired,
    this.isUse,
    this.isUseLabel,
    this.isOpen,
    this.unboxLabel,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    expiredDate = json['expired_date'];
    expiredTime = json['expired_time'];
    expiredTimestamp = json['expired_timestamp'];
    isExpired = json['is_expired'];
    isUse = json['is_use'];
    isUseLabel = json['is_use_label'];
    isOpen = json['is_open'];
    unboxLabel = json['unbox_label'];
  }
  String? id;
  String? name;
  String? icon;
  String? expiredDate;
  String? expiredTime;
  String? expiredTimestamp;
  bool? isExpired;
  bool? isUse;
  String? isUseLabel;
  bool? isOpen;
  String? unboxLabel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    map['expired_date'] = expiredDate;
    map['expired_time'] = expiredTime;
    map['expired_timestamp'] = expiredTimestamp;
    map['is_expired'] = isExpired;
    map['is_use'] = isUse;
    map['is_use_label'] = isUseLabel;
    map['is_open'] = isOpen;
    map['unbox_label'] = unboxLabel;
    return map;
  }
}
