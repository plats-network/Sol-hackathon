/// success : false
/// message : "Date not yet!"
/// data : {"message":"Send to Main Tray done!..."}
/// error_code : 1

class UpdateLockTrayResponse {
  UpdateLockTrayResponse({
    this.success,
    this.message,
    this.data,
    this.errorCode,
  });

  UpdateLockTrayResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errorCode = json['error_code'];
  }
  bool? success;
  String? message;
  Data? data;
  num? errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['error_code'] = errorCode;
    return map;
  }
}

/// message : "Send to Main Tray done!..."

class Data {
  Data({
    this.message,
  });

  Data.fromJson(dynamic json) {
    message = json['message'];
  }
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }
}
