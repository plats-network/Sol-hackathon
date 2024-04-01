/// success : false
/// message : "The name field is required."
/// errors : {"name":["The name field is required."]}
/// error_code : 1
/// data : {"id":"97104c45-45d5-49db-a061-c0aa9e9c77b2","role":1,"name":"Updated","email":"phunv@vaixgroup.com","email_verified_at":null,"confirmation_code":null,"created_at":"2022-08-20T02:29:08.000000Z","updated_at":"2022-10-03T13:33:48.000000Z","deleted_at":null}

class UpdateProfileResponse {
  UpdateProfileResponse({
      this.success, 
      this.message, 
      this.errors, 
      this.errorCode, 
      this.data,});

  UpdateProfileResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    errors = json['errors'] != null ? Errors.fromJson(json['errors']) : null;
    errorCode = json['error_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
  Errors? errors;
  num? errorCode;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (errors != null) {
      map['errors'] = errors?.toJson();
    }
    map['error_code'] = errorCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// id : "97104c45-45d5-49db-a061-c0aa9e9c77b2"
/// role : 1
/// name : "Updated"
/// email : "phunv@vaixgroup.com"
/// email_verified_at : null
/// confirmation_code : null
/// created_at : "2022-08-20T02:29:08.000000Z"
/// updated_at : "2022-10-03T13:33:48.000000Z"
/// deleted_at : null

class Data {
  Data({
      this.id, 
      this.role, 
      this.name, 
      this.email, 
      this.emailVerifiedAt, 
      this.confirmationCode, 
      this.createdAt, 
      this.updatedAt, 
      this.deletedAt,});

  Data.fromJson(dynamic json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    confirmationCode = json['confirmation_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }
  String? id;
  num? role;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  dynamic confirmationCode;
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
    map['confirmation_code'] = confirmationCode;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }

}

/// name : ["The name field is required."]

class Errors {
  Errors({
      this.name,});

  Errors.fromJson(dynamic json) {
    name = json['name'] != null ? json['name'].cast<String>() : [];
  }
  List<String>? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    return map;
  }

}