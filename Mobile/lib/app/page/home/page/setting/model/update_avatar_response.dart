/// success : true
/// data : "https://d37c8ertxcodlq.cloudfront.net/uploads/profiles/20221024/1666600210.IIrobhiyiZ2Rbwcs4EyVbtnB8OqM9w860Qm71Shy.jpg"
/// message : "Update successful"

class UpdateAvatarResponse {
  UpdateAvatarResponse({
      this.success, 
      this.data, 
      this.message,});

  UpdateAvatarResponse.fromJson(dynamic json) {
    success = json['success'];
    data = json['data'];
    message = json['message'];
  }
  bool? success;
  String? data;
  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['data'] = data;
    map['message'] = message;
    return map;
  }

}