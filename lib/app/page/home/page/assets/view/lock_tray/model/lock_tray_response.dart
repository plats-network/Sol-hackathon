class LockTrayResponse {
  LockTrayResponse({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  LockTrayResponse.fromJson(dynamic json) {
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

class Data {
  Data({
    this.id,
    // this.name,
    // this.icon,
    // this.isStatus,
    // this.timeStamp,
    // this.timeOrigin,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    // name = json['name'];
    // icon = json['icon'];
    // isStatus = json['is_status'];
    // timeStamp = json['time_stamp'];
    // timeOrigin = json['time_origin'];
  }
  String? id;
  // String? name;
  // String? icon;
  // bool? isStatus;
  // String? timeStamp;
  // String? timeOrigin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    // map['name'] = name;
    // map['icon'] = icon;
    // map['is_status'] = isStatus;
    // map['time_stamp'] = timeStamp;
    // map['time_origin'] = timeOrigin;
    return map;
  }
}
