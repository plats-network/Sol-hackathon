/// success : true
/// message : null
/// data : {"id":"97773e5f-fafa-4025-b9f1-074ba5f4dfe8","name":"Name voucher 66653","qr_code":"NWI9Z8","phone":"To do: "}

class VoucherDetailQrResponse {
  VoucherDetailQrResponse({
    this.success,
    this.message,
    this.data,
  });

  VoucherDetailQrResponse.fromJson(dynamic json) {
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

/// id : "97773e5f-fafa-4025-b9f1-074ba5f4dfe8"
/// name : "Name voucher 66653"
/// qr_code : "NWI9Z8"
/// phone : "To do: "

class Data {
  Data({
    this.id,
    this.name,
    this.qrCode,
    this.phone,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    qrCode = json['qr_code'];
    phone = json['phone'];
  }
  String? id;
  String? name;
  String? qrCode;
  String? phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['qr_code'] = qrCode;
    map['phone'] = phone;
    return map;
  }
}
