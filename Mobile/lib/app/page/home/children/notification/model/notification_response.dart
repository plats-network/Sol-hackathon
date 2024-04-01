/// success : true
/// message : null
/// data : [{"id":"976b53e1-4e35-4608-9f09-688a6ee41f3b","title":"Tao noti type 1","description":"mo ta noti","time":"2 hours ago","is_read":false,"is_read_label":"unread","type":1,"type_label":"Unbox"},{"id":"976b53d2-6575-4625-bfa6-194d5ae4f5a6","title":"Tao noti type 1","description":"mo ta noti","time":"2 hours ago","is_read":false,"is_read_label":"unread","type":1,"type_label":"Unbox"},{"id":"976b1fad-037c-431c-a9f0-5a73329fbbdd","title":"Tao noti","description":"mo ta noti","time":"4 hours ago","is_read":true,"is_read_label":"read","type":0,"type_label":"New Tasks"}]
/// meta : {"current_page":0,"last_page":1,"per_page":20,"total":1}

class NotificationResponse {
  NotificationResponse({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  NotificationResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  bool? success;
  dynamic message;
  List<Data>? data;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }
}

/// current_page : 0
/// last_page : 1
/// per_page : 20
/// total : 1

class Meta {
  Meta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  Meta.fromJson(dynamic json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }
  num? currentPage;
  num? lastPage;
  num? perPage;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    map['per_page'] = perPage;
    map['total'] = total;
    return map;
  }
}

/// id : "976b53e1-4e35-4608-9f09-688a6ee41f3b"
/// title : "Tao noti type 1"
/// description : "mo ta noti"
/// time : "2 hours ago"
/// is_read : false
/// is_read_label : "unread"
/// type : 1
/// type_label : "Unbox"
/// icon : "https://cdn.iconscout.com/icon/free/png-256/flutter-2038877-1720090.png"

class Data {
  Data({
    this.id,
    this.title,
    this.description,
    this.time,
    this.isRead,
    this.isReadLabel,
    this.type,
    this.typeLabel,
    this.icon,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    time = json['time'];
    isRead = json['is_read'];
    isReadLabel = json['is_read_label'];
    type = json['type'];
    typeLabel = json['type_label'];
    icon = json['icon'];
  }
  String? id;
  String? title;
  String? description;
  String? time;
  bool? isRead;
  String? isReadLabel;
  num? type;
  String? typeLabel;
  String? icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['time'] = time;
    map['is_read'] = isRead;
    map['is_read_label'] = isReadLabel;
    map['type'] = type;
    map['type_label'] = typeLabel;
    map['icon'] = icon;
    return map;
  }
}
