/// success : true
/// data : {"email":"hopthucuatin@gmail.com","code":"428761"}
/// message : "Please set a new password."
/// error_code : 1

class ForgotPasswordModel {
  ForgotPasswordModel({
    this.success,
    this.data,
    this.message,
    this.errorCode,
  });

  ForgotPasswordModel.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    errorCode = json['error_code'];
  }
  bool? success;
  Data? data;
  String? message;
  num? errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    map['error_code'] = errorCode;
    return map;
  }
}

/// email : "hopthucuatin@gmail.com"
/// code : "428761"

class Data {
  Data({
    this.email,
    this.code,
  });

  Data.fromJson(dynamic json) {
    email = json['email'];
    code = json['code'];
  }
  String? email;
  String? code;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['code'] = code;
    return map;
  }
}
