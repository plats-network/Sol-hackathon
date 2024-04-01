/// success : false
/// message : "The token field is required."
/// data : null
/// errors : null
/// error_code : 1

class FcmNotiResponse {
  FcmNotiResponse({
      this.success, 
      this.message, 
      this.data, 
      this.errors, 
      this.errorCode,});

  FcmNotiResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    errors = json['errors'];
    errorCode = json['error_code'];
  }
  bool? success;
  String? message;
  dynamic data;
  dynamic errors;
  num? errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data;
    map['errors'] = errors;
    map['error_code'] = errorCode;
    return map;
  }

}