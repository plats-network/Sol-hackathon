class NftListResponse {
  NftListResponse({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  NftListResponse.fromJson(dynamic json) {
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
    this.name,
    this.icon,
    this.urlImage,
    this.description,
    this.expired,
    this.isExpired,
    this.fromTime,
    this.fromDate,
    this.toTime,
    this.toDate,
    this.address,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    urlImage = json['url_image'];
    description = json['description'];
    expired = json['expired'];
    isExpired = json['is_expired'];
    fromTime = json['from_time'];
    fromDate = json['from_date'];
    toTime = json['to_time'];
    toDate = json['to_date'];
    address = json['address'];
  }
  String? id;
  String? name;
  String? icon;
  String? urlImage;
  String? description;
  String? expired;
  bool? isExpired;
  String? fromTime;
  String? fromDate;
  String? toTime;
  String? toDate;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    map['url_image'] = urlImage;
    map['description'] = description;
    map['expired'] = expired;
    map['is_expired'] = isExpired;
    map['from_time'] = fromTime;
    map['from_date'] = fromDate;
    map['to_time'] = toTime;
    map['to_date'] = toDate;
    map['address'] = address;
    return map;
  }
}
