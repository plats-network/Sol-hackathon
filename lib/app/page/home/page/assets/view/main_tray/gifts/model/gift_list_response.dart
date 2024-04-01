/// success : true
/// message : null
/// data : [{"id":"9793ae30-07a6-428f-a306-bd346e63a519","name":"NFTs 951","amount":1,"icon":"https://d37c8ertxcodlq.cloudfront.net/icon/card_mobile.png","url_image":"https://d37c8ertxcodlq.cloudfront.net/icon/achicklet.png","description":"NFTs desc 198","expired":"18/10/2022","is_expired":true,"from_time":"16:56","from_date":"24/10/2022","to_time":"16:56","to_date":"18/10/2022","address":"Address 89","is_open":false,"open_label":"box","type":1,"type_label":"nft"},{"id":"9793ae2f-c178-4788-8a21-590ee4ea2b52","name":"Token name313","amount":200,"icon":"https://d37c8ertxcodlq.cloudfront.net/icon/card_mobile.png","url_image":"https://d37c8ertxcodlq.cloudfront.net/icon/oc.jpeg","description":"Token desc141","expired":"24/10/2022","is_expired":true,"from_time":"16:56","from_date":"24/10/2022","to_time":"16:56","to_date":"24/10/2022","address":"Address 89","is_open":false,"open_label":"box","type":0,"type_label":"token"},{"id":"9793ae2f-8d3b-4ab4-ae88-40816a8f6c3a","name":"Token name101","amount":188,"icon":"https://d37c8ertxcodlq.cloudfront.net/icon/card_mobile.png","url_image":"https://d37c8ertxcodlq.cloudfront.net/icon/cong_caffe.png","description":"Token desc907","expired":"29/10/2022","is_expired":false,"from_time":"16:56","from_date":"24/10/2022","to_time":"16:56","to_date":"29/10/2022","address":"Address 89","is_open":false,"open_label":"box","type":0,"type_label":"token"},{"id":"9793ae2d-4ff6-4f1b-b600-3f7aaf291aa0","name":"Token name651","amount":102,"icon":"https://d37c8ertxcodlq.cloudfront.net/icon/card_mobile.png","url_image":"https://d37c8ertxcodlq.cloudfront.net/icon/achicklet.png","description":"Token desc514","expired":"03/11/2022","is_expired":false,"from_time":"16:56","from_date":"24/10/2022","to_time":"16:56","to_date":"03/11/2022","address":"Address 89","is_open":false,"open_label":"box","type":0,"type_label":"token"},{"id":"9793ae2a-4d51-4536-89bb-e9a36fd19c0a","name":"Data test - Giảm 50% hoá đơn cho mọi dịch vụ tại salon","amount":null,"icon":"https://d37c8ertxcodlq.cloudfront.net/icon/30shine.png","url_image":"https://d37c8ertxcodlq.cloudfront.net/icon/30shine.png","description":"Vouchers desc 735","expired":"26/10/2022","is_expired":false,"from_time":"16:56","from_date":"24/10/2022","to_time":"16:56","to_date":"26/10/2022","address":"Address 47","is_open":false,"open_label":"box","type":2,"type_label":"voucher"},{"id":"9793ae28-0147-4841-ad89-15134f231af2","name":"Data test - Giảm 50% hoá đơn cho mọi dịch vụ tại salon","amount":null,"icon":"https://d37c8ertxcodlq.cloudfront.net/icon/30shine.png","url_image":"https://d37c8ertxcodlq.cloudfront.net/icon/achicklet.png","description":"Vouchers desc 989","expired":"27/10/2022","is_expired":false,"from_time":"16:56","from_date":"24/10/2022","to_time":"16:56","to_date":"27/10/2022","address":"Address 47","is_open":false,"open_label":"box","type":2,"type_label":"voucher"},{"id":"9793ae26-aca3-4b72-8177-b983c5f741ca","name":"Data test - Giảm 50% hoá đơn cho mọi dịch vụ tại salon","amount":null,"icon":"https://d37c8ertxcodlq.cloudfront.net/icon/30shine.png","url_image":"https://d37c8ertxcodlq.cloudfront.net/icon/oc.jpeg","description":"Vouchers desc 715","expired":"20/10/2022","is_expired":true,"from_time":"16:56","from_date":"24/10/2022","to_time":"16:56","to_date":"20/10/2022","address":"Address 47","is_open":false,"open_label":"box","type":2,"type_label":"voucher"},{"id":"9793ae26-90a4-4b7e-8197-2e1230bba4bd","name":"NFTs 84","amount":1,"icon":"https://d37c8ertxcodlq.cloudfront.net/icon/card_mobile.png","url_image":"https://d37c8ertxcodlq.cloudfront.net/icon/oc.jpeg","description":"NFTs desc 10","expired":"29/10/2022","is_expired":false,"from_time":"16:56","from_date":"24/10/2022","to_time":"16:56","to_date":"29/10/2022","address":"Address 89","is_open":false,"open_label":"box","type":1,"type_label":"nft"},{"id":"9793ae24-12c6-42a1-ae38-dedda9063869","name":"Token name98","amount":165,"icon":"https://d37c8ertxcodlq.cloudfront.net/icon/card_mobile.png","url_image":"https://d37c8ertxcodlq.cloudfront.net/icon/30shine.png","description":"Token desc276","expired":"31/10/2022","is_expired":false,"from_time":"16:56","from_date":"24/10/2022","to_time":"16:56","to_date":"31/10/2022","address":"Address 89","is_open":false,"open_label":"box","type":0,"type_label":"token"}]
/// meta : {"current_page":9,"last_page":9,"per_page":10,"total":9}

class GiftListResponse {
  GiftListResponse({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  GiftListResponse.fromJson(dynamic json) {
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

/// current_page : 9
/// last_page : 9
/// per_page : 10
/// total : 9

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

/// id : "9793ae30-07a6-428f-a306-bd346e63a519"
/// name : "NFTs 951"
/// amount : 1
/// icon : "https://d37c8ertxcodlq.cloudfront.net/icon/card_mobile.png"
/// url_image : "https://d37c8ertxcodlq.cloudfront.net/icon/achicklet.png"
/// description : "NFTs desc 198"
/// expired : "18/10/2022"
/// is_expired : true
/// from_time : "16:56"
/// from_date : "24/10/2022"
/// to_time : "16:56"
/// to_date : "18/10/2022"
/// address : "Address 89"
/// is_open : false
/// open_label : "box"
/// type : 1
/// type_label : "nft"

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
    this.isOpen,
    this.openLabel,
    this.type,
    this.typeLabel,
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
    isOpen = json['is_open'];
    openLabel = json['open_label'];
    type = json['type'];
    typeLabel = json['type_label'];
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
  bool? isOpen;
  String? openLabel;
  num? type;
  String? typeLabel;

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
    map['is_open'] = isOpen;
    map['open_label'] = openLabel;
    map['type'] = type;
    map['type_label'] = typeLabel;
    return map;
  }
}
