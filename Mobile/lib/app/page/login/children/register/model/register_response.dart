/// success : false
/// message : "The email has already been taken."
/// data : null
/// errors : {"email":["The email field is required."],"password":["The password field is required."],"name":["The name field is required."]}
/// error_code : 1

class RegisterResponse {
  RegisterResponse({
    this.success,
    this.message,
    this.data,
    this.errors,
    this.errorCode,
  });

  RegisterResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    errorCode = json['error_code'];
  }
  bool? success;
  String? message;
  dynamic data;
  Errors? errors;
  num? errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data;
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    map['error_code'] = errorCode;
    return map;
  }
}

/// email : ["The email field is required."]
/// password : ["The password field is required."]
/// name : ["The name field is required."]

class Errors {
  Errors({
    this.email,
    this.password,
    this.name,
  });

  Errors.fromJson(dynamic json) {
    email = json['email'] != null ? json['email'].cast<String>() : [];
    password = json['password'] != null ? json['password'].cast<String>() : [];
    name = json['name'] != null ? json['name'].cast<String>() : [];
  }
  List<String>? email;
  List<String>? password;
  List<String>? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = email;
    map['password'] = password;
    map['name'] = name;
    return map;
  }
}
