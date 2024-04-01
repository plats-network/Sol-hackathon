/// success : true
/// message : "Create successful token."
/// errors : {"token":["The token field is required."]}
/// error_code : 1
/// data : {"user_id":"9769d241-3a27-4bd4-aeef-895eb8485bf5","token":"APA91bFoi3lMMre9G3XzR1LrF4ZT82_15MsMdEICogXSLB8-MrdkRuRQFwNI5u8Dh0cI90ABD3BOKnxkEla8cGdisbDHl5cVIkZah5QUhSAxzx4Roa7b4xy9tvx9iNSYw-eXBYYd8k1XKf8Q_Qq1X9-x-U-Y79vdPq","device_name":"iOS","agent_info":"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36","login_count":1,"ip_address":"172.68.253.68","updated_at":"2022-10-08T09:53:48.000000Z","created_at":"2022-10-08T09:53:48.000000Z"}

class CreateFcmDeviceTokenResponse {
  CreateFcmDeviceTokenResponse({
      this.success, 
      this.message, 
      this.errors, 
      this.errorCode, 
      this.data,});

  CreateFcmDeviceTokenResponse.fromJson(dynamic json) {
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

/// user_id : "9769d241-3a27-4bd4-aeef-895eb8485bf5"
/// token : "APA91bFoi3lMMre9G3XzR1LrF4ZT82_15MsMdEICogXSLB8-MrdkRuRQFwNI5u8Dh0cI90ABD3BOKnxkEla8cGdisbDHl5cVIkZah5QUhSAxzx4Roa7b4xy9tvx9iNSYw-eXBYYd8k1XKf8Q_Qq1X9-x-U-Y79vdPq"
/// device_name : "iOS"
/// agent_info : "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36"
/// login_count : 1
/// ip_address : "172.68.253.68"
/// updated_at : "2022-10-08T09:53:48.000000Z"
/// created_at : "2022-10-08T09:53:48.000000Z"

class Data {
  Data({
      this.userId, 
      this.token, 
      this.deviceName, 
      this.agentInfo, 
      this.loginCount, 
      this.ipAddress, 
      this.updatedAt, 
      this.createdAt,});

  Data.fromJson(dynamic json) {
    userId = json['user_id'];
    token = json['token'];
    deviceName = json['device_name'];
    agentInfo = json['agent_info'];
    loginCount = json['login_count'];
    ipAddress = json['ip_address'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }
  String? userId;
  String? token;
  String? deviceName;
  String? agentInfo;
  num? loginCount;
  String? ipAddress;
  String? updatedAt;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    map['token'] = token;
    map['device_name'] = deviceName;
    map['agent_info'] = agentInfo;
    map['login_count'] = loginCount;
    map['ip_address'] = ipAddress;
    map['updated_at'] = updatedAt;
    map['created_at'] = createdAt;
    return map;
  }

}

/// token : ["The token field is required."]

class Errors {
  Errors({
      this.token,});

  Errors.fromJson(dynamic json) {
    token = json['token'] != null ? json['token'].cast<String>() : [];
  }
  List<String>? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['token'] = token;
    return map;
  }

}