class GroupResponse {
  GroupResponse({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  GroupResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
  }
  bool? success;
  dynamic message;
  List<Data>? data;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }
}

class Meta {
  Meta({
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  Meta.fromJson(dynamic json) {
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }
  num? currentPage;
  num? lastPage;
  num? perPage;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    map['per_page'] = perPage;
    map['total'] = total;
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.name,
    this.desc_vn,
    this.desc_en,
    this.headline,
    this.site_url,
    this.cover_url,
    this.avatar_url,
    this.username,
    this.country,
    this.twitter_url,
    this.telegram_url,
    this.facebook_url,
    this.youtube_url,
    this.discord_url,
    this.instagram_url,
    this.is_join,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    desc_vn = json['desc_vn'];
    desc_en = json['desc_en'];
    headline = json['headline'];
    site_url = json['site_url'];
    cover_url = json['cover_url'];
    avatar_url = json['avatar_url'];
    username = json['username'];
    country = json['country'];
    twitter_url = json['twitter_url'];
    telegram_url = json['telegram_url'];
    facebook_url = json['facebook_url'];
    youtube_url = json['youtube_url'];
    discord_url = json['discord_url'];
    instagram_url = json['instagram_url'];
    is_join = json['is_join'];
  }
  String? id;
  String? name;
  String? desc_vn;
  String? desc_en;
  String? headline;
  String? site_url;
  String? cover_url;
  String? avatar_url;
  String? username;
  String? country;
  String? twitter_url;
  String? telegram_url;
  String? facebook_url;
  String? youtube_url;
  String? discord_url;
  String? instagram_url;
  bool? is_join;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['desc_vn'] = desc_vn;
    map['desc_en'] = desc_en;
    map['headline'] = headline;
    map['site_url'] = site_url;
    map['cover_url'] = cover_url;
    map['avatar_url'] = avatar_url;
    map['username'] = username;
    map['country'] = country;
    map['twitter_url'] = twitter_url;
    map['telegram_url'] = telegram_url;
    map['facebook_url'] = facebook_url;
    map['youtube_url'] = youtube_url;
    map['discord_url'] = discord_url;
    map['instagram_url'] = instagram_url;
    map['is_join'] = is_join;
    return map;
  }
}
