class TicketResponse {
  TicketResponse({
    this.success,
    this.message,
    this.data,
  });

  TicketResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(TicketData.fromJson(v));
      });
    }
  }
  bool? success;
  dynamic message;
  List<TicketData>? data;

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

class TicketData {
  TicketData({
    this.id,
    this.type,
    this.userId,
    this.eventId,
    this.eventName,
    this.startAt,
    this.endAt,
    this.bannerUrl,
    this.address,
    this.qrContent,
    this.typeName,
    this.userName,
  });

  TicketData.fromJson(dynamic json) {
    id = json['id'];
    type = json['type'];
    userId = json['user_id'];
    eventId = json['event_id'];
    eventName = json['event_name'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    bannerUrl = json['img'];
    address = json['address'];
    qrContent = json['qr_content'];
    typeName = json['type_name'];
    userName = json['user_name'];
  }
  String? id;
  num? type;
  String? userId;
  String? eventId;
  String? eventName;
  String? startAt;
  String? endAt;
  String? bannerUrl;
  String? address;
  String? qrContent;
  String? typeName;
  String? userName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['type'] = type;
    map['user_id'] = userId;
    map['event_id'] = eventId;
    map['event_name'] = eventName;
    map['start_at'] = startAt;
    map['end_at'] = endAt;
    map['img'] = bannerUrl;
    map['address'] = address;
    map['qr_content'] = qrContent;
    map['type_name'] = typeName;
    map['user_name'] = userName;
    return map;
  }
}
