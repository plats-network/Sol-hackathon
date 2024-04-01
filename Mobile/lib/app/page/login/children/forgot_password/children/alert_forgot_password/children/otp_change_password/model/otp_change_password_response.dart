/// success : false
/// message : "The password field is required."
/// data : {"id":"97104c45-45d5-49db-a061-c0aa9e9c77b2","role":1,"name":"Hello Test","email":"phunv@vaixgroup.com","email_verified_at":null,"created_at":"2022-08-20T09:29:08.000000Z","updated_at":"2022-10-02T14:08:11.000000Z","deleted_at":null}
/// errors : {"password":["The password field is required."]}
/// error_code : 1

class ChangePasswordResponse {
  ChangePasswordResponse({
      this.success, 
      this.message, 
      this.data, 
      this.errors, 
      this.errorCode,});

  ChangePasswordResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    errorCode = json['error_code'];
  }
  bool? success;
  String? message;
  Data? data;
  Errors? errors;
  num? errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    map['error_code'] = errorCode;
    return map;
  }

}

/// password : ["The password field is required."]

class Errors {
  Errors({
      this.password,});

  Errors.fromJson(dynamic json) {
    password = json['password'] != null ? json['password'].cast<String>() : [];
  }
  List<String>? password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['password'] = password;
    return map;
  }

}

/// id : "97104c45-45d5-49db-a061-c0aa9e9c77b2"
/// role : 1
/// name : "Hello Test"
/// email : "phunv@vaixgroup.com"
/// email_verified_at : null
/// created_at : "2022-08-20T09:29:08.000000Z"
/// updated_at : "2022-10-02T14:08:11.000000Z"
/// deleted_at : null

class Data {
  Data({
      this.id, 
      this.role, 
      this.name, 
      this.email, 
      this.emailVerifiedAt, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  String? id;
  num? role;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role'] = role;
    map['name'] = name;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}