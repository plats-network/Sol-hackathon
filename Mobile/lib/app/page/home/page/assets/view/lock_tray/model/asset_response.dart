class AssetResponse {
  AssetResponse({
    this.success,
    this.message,
    this.data,
  });

  AssetResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  dynamic message;
  List<Data>? data;

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

class Data {
  Data({
    this.id,
    this.name,
    this.image,
    this.description,
    this.symbol,
    this.amount,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    symbol = json['symbol'];
    amount = json['amount'];
  }
  String? id;
  String? name;
  String? image;
  String? description;
  String? symbol;
  num? amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['description'] = description;
    map['symbol'] = symbol;
    map['amount'] = amount;
    return map;
  }
}
