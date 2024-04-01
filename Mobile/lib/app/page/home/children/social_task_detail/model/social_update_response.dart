/// data : {"id":"96be321e-296b-469e-bc2e-3f977c8bdf3a","role":1,"name":"Toyota Motor Corporation","email":"toyota.motor@plats.network","email_verified_at":"2022-10-08T09:39:17.000000Z","gender":null,"birth":null,"avatar_path":"https://lumiere-a.akamaihd.net/v1/images/nt_avatarmcfarlanecomic-con_223_01_2deace02.jpeg","confirmation_code":null,"created_at":"2022-07-10T06:58:07.000000Z","updated_at":"2022-11-11T09:05:53.000000Z","deleted_at":null,"twitter":"dovv1987","facebook":"dovv1987","discord":"dovv1987","telegram":"dovv1987"}

class SocialUpdateResponse {
  SocialUpdateResponse({
    this.data,
  });

  SocialUpdateResponse.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// id : "96be321e-296b-469e-bc2e-3f977c8bdf3a"
/// role : 1
/// name : "Toyota Motor Corporation"
/// email : "toyota.motor@plats.network"
/// email_verified_at : "2022-10-08T09:39:17.000000Z"
/// gender : null
/// birth : null
/// avatar_path : "https://lumiere-a.akamaihd.net/v1/images/nt_avatarmcfarlanecomic-con_223_01_2deace02.jpeg"
/// confirmation_code : null
/// created_at : "2022-07-10T06:58:07.000000Z"
/// updated_at : "2022-11-11T09:05:53.000000Z"
/// deleted_at : null
/// twitter : "dovv1987"
/// facebook : "dovv1987"
/// discord : "dovv1987"
/// telegram : "dovv1987"

class Data {
  Data({
    this.id,
    this.role,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.gender,
    this.birth,
    this.avatarPath,
    this.confirmationCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.twitter,
    this.facebook,
    this.discord,
    this.telegram,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    role = json['role'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    gender = json['gender'];
    birth = json['birth'];
    avatarPath = json['avatar_path'];
    confirmationCode = json['confirmation_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    twitter = json['twitter'];
    facebook = json['facebook'];
    discord = json['discord'];
    telegram = json['telegram'];
  }
  String? id;
  num? role;
  String? name;
  String? email;
  String? emailVerifiedAt;
  dynamic gender;
  dynamic birth;
  String? avatarPath;
  dynamic confirmationCode;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  String? twitter;
  String? facebook;
  String? discord;
  String? telegram;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['role'] = role;
    map['name'] = name;
    map['email'] = email;
    map['email_verified_at'] = emailVerifiedAt;
    map['gender'] = gender;
    map['birth'] = birth;
    map['avatar_path'] = avatarPath;
    map['confirmation_code'] = confirmationCode;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    map['twitter'] = twitter;
    map['facebook'] = facebook;
    map['discord'] = discord;
    map['telegram'] = telegram;
    return map;
  }
}
