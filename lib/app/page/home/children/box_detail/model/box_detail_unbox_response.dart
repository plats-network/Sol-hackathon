/// success : true
/// message : null
/// data : {"id":"97862563-6f2c-4a68-a601-7bee58d1d6f4","name":"Bonus","icon":"https://i.imgur.com/UuCaWFA.png","amount":1,"type":1,"type_label":"nft"}

class BoxDetailUnboxResponse {
  BoxDetailUnboxResponse({
    this.success,
    this.message,
    this.data,
  });

  BoxDetailUnboxResponse.fromJson(dynamic json) {
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

/// id : "97862563-6f2c-4a68-a601-7bee58d1d6f4"
/// name : "Bonus"
/// icon : "https://i.imgur.com/UuCaWFA.png"
/// amount : 1
/// type : 1
/// type_label : "nft"

class Data {
  Data({
    this.id,
    this.name,
    this.icon,
    this.amount,
    this.type,
    this.typeLabel,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    amount = json['amount'];
    type = json['type'];
    typeLabel = json['type_label'];
  }
  String? id;
  String? name;
  String? icon;
  num? amount;
  num? type;
  String? typeLabel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['icon'] = icon;
    map['amount'] = amount;
    map['type'] = type;
    map['type_label'] = typeLabel;
    return map;
  }
}


