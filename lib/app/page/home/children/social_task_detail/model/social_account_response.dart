/// success : true
/// message : "Social info"
/// data : {"id":"9769d241-3a27-4bd4-aeef-895eb8485bf5","facebook":"571432663","twitter":"571432663","discord":"571432663","telegram":"571432663"}

class SocialAccountResponse {
  SocialAccountResponse({
    this.success,
    this.message,
    this.data,
  });

  SocialAccountResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
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

/// id : "9769d241-3a27-4bd4-aeef-895eb8485bf5"
/// facebook : "571432663"
/// twitter : "571432663"
/// discord : "571432663"
/// telegram : "571432663"

class Data {
  Data({
    this.id,
    this.facebook,
    this.twitter,
    this.discord,
    this.telegram,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    discord = json['discord'];
    telegram = json['telegram'];
  }
  String? id;
  String? facebook;
  String? twitter;
  String? discord;
  String? telegram;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['facebook'] = facebook;
    map['twitter'] = twitter;
    map['discord'] = discord;
    map['telegram'] = telegram;
    return map;
  }
}
