class EventResponse {
  EventResponse({
    this.success,
    this.message,
    this.data,
  });

  EventResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(EventData.fromJson(v));
      });
    }
  }
  bool? success;
  dynamic message;
  List<EventData>? data;

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

class EventData {
  EventData({
    this.id,
    this.name,
    this.date,
    this.bannerUrl,
    this.address,
  });

  EventData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    bannerUrl = json['banner_url'];
    address = json['address'];
  }
  String? id;
  String? name;
  String? date;
  String? bannerUrl;
  String? address;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['date'] = date;
    map['banner_url'] = bannerUrl;
    map['address'] = address;
    return map;
  }
}
