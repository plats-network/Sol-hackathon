/// success : true
/// message : null
/// data : [{"id":"97862b57-2621-4460-99f2-5ed3050e5e8f","name":"Token name10","amount":104,"icon":"https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_ogp_001.png","url_image":"https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg","description":"Token desc10","expired":"19/10/2022","is_expired":true,"from_time":"23:44","from_date":"17/10/2022","to_time":"23:44","to_date":"19/10/2022","address":"Address 9"},{"id":"97862b6e-d1e5-4dd2-a30b-9591ff4cc6c2","name":"Token name10","amount":140,"icon":"https://upload.wikimedia.org/wikipedia/vi/thumb/c/c9/Highlands_Coffee_logo.svg/1200px-Highlands_Coffee_logo.svg.png","url_image":"https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg","description":"Token desc10","expired":"19/10/2022","is_expired":true,"from_time":"23:45","from_date":"17/10/2022","to_time":"23:45","to_date":"19/10/2022","address":"Address 6"},{"id":"97862b48-704f-4a2b-b06a-75850711e414","name":"Token name10","amount":154,"icon":"https://upload.wikimedia.org/wikipedia/vi/thumb/c/c9/Highlands_Coffee_logo.svg/1200px-Highlands_Coffee_logo.svg.png","url_image":"https://www.highlandscoffee.com.vn/vnt_upload/weblink/1200px-Highlands_Coffee_logo.svg.png","description":"Token desc10","expired":"22/10/2022","is_expired":false,"from_time":"23:44","from_date":"17/10/2022","to_time":"23:44","to_date":"22/10/2022","address":"Address 6"},{"id":"97862b3a-98fc-4324-b357-27e5d01a6ef9","name":"Token name10","amount":200,"icon":"https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_ogp_001.png","url_image":"https://30shine.com/static/media/log-30shine-white.9945e644.jpg","description":"Token desc10","expired":"17/10/2022","is_expired":true,"from_time":"23:44","from_date":"17/10/2022","to_time":"23:44","to_date":"17/10/2022","address":"Address 8"},{"id":"97862b21-eeda-4c96-a8d7-35c758737ab9","name":"Token name10","amount":183,"icon":"https://upload.wikimedia.org/wikipedia/vi/thumb/c/c9/Highlands_Coffee_logo.svg/1200px-Highlands_Coffee_logo.svg.png","url_image":"https://30shine.com/static/media/log-30shine-white.9945e644.jpg","description":"Token desc10","expired":"14/10/2022","is_expired":true,"from_time":"23:44","from_date":"17/10/2022","to_time":"23:44","to_date":"14/10/2022","address":"Address 7"},{"id":"97862b0a-4d67-49d5-9381-9a50f1c5c599","name":"Token name10","amount":199,"icon":"https://upload.wikimedia.org/wikipedia/vi/thumb/c/c9/Highlands_Coffee_logo.svg/1200px-Highlands_Coffee_logo.svg.png","url_image":"https://30shine.com/static/media/log-30shine-white.9945e644.jpg","description":"Token desc10","expired":"13/10/2022","is_expired":true,"from_time":"23:43","from_date":"17/10/2022","to_time":"23:43","to_date":"13/10/2022","address":"Address 0"},{"id":"97862b00-5cb8-4004-b61c-7b59669668e2","name":"Token name10","amount":129,"icon":"https://upload.wikimedia.org/wikipedia/vi/thumb/c/c9/Highlands_Coffee_logo.svg/1200px-Highlands_Coffee_logo.svg.png","url_image":"https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg","description":"Token desc10","expired":"10/10/2022","is_expired":true,"from_time":"23:43","from_date":"17/10/2022","to_time":"23:43","to_date":"10/10/2022","address":"Address 7"},{"id":"97862afa-8a2c-4a31-9b8b-377e3777be7e","name":"Token name10","amount":116,"icon":"https://upload.wikimedia.org/wikipedia/vi/thumb/c/c9/Highlands_Coffee_logo.svg/1200px-Highlands_Coffee_logo.svg.png","url_image":"https://30shine.com/static/media/log-30shine-white.9945e644.jpg","description":"Token desc10","expired":"09/10/2022","is_expired":true,"from_time":"23:43","from_date":"17/10/2022","to_time":"23:43","to_date":"09/10/2022","address":"Address 7"},{"id":"97862af4-a2cc-419b-869a-2a93a0f481d2","name":"Token name10","amount":118,"icon":"https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_ogp_001.png","url_image":"https://tocotocotea.com/wp-content/uploads/2021/04/Logo-ngang-01.png","description":"Token desc10","expired":"18/10/2022","is_expired":true,"from_time":"23:43","from_date":"17/10/2022","to_time":"23:43","to_date":"18/10/2022","address":"Address 9"},{"id":"97862af1-a791-4046-8af6-bc7ba7ce6209","name":"Token name10","amount":180,"icon":"https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_ogp_001.png","url_image":"https://tocotocotea.com/wp-content/uploads/2021/04/Logo-ngang-01.png","description":"Token desc10","expired":"08/10/2022","is_expired":true,"from_time":"23:43","from_date":"17/10/2022","to_time":"23:43","to_date":"08/10/2022","address":"Address 8"}]
/// meta : {"current_page":1,"last_page":1,"per_page":10,"total":1}

class TokenListResponse {
  TokenListResponse({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  TokenListResponse.fromJson(dynamic json) {
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

/// current_page : 1
/// last_page : 1
/// per_page : 10
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

/// id : "97862b57-2621-4460-99f2-5ed3050e5e8f"
/// name : "Token name10"
/// amount : 104
/// icon : "https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_ogp_001.png"
/// url_image : "https://global.toyota/pages/global_toyota/mobility/toyota-brand/emblem_001.jpg"
/// description : "Token desc10"
/// expired : "19/10/2022"
/// is_expired : true
/// from_time : "23:44"
/// from_date : "17/10/2022"
/// to_time : "23:44"
/// to_date : "19/10/2022"
/// address : "Address 9"

class Data {
  Data({
    this.id,
    this.name,
    this.amount,
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
    amount = json['amount'];
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
  num? amount;
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
    map['amount'] = amount;
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
