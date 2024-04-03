/// success : false
/// message : "Your account has been activated."
/// data : null
/// error_code : 7

class ResendOtpVerificationResponse {
  ResendOtpVerificationResponse({
    this.success,
    this.message,
    this.data,
    this.errorCode,
  });

  ResendOtpVerificationResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'];
    errorCode = json['error_code'];
  }
  bool? success;
  String? message;
  dynamic data;
  num? errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['data'] = data;
    map['error_code'] = errorCode;
    return map;
  }
}