class OngoingEventResponse {
  OngoingEventResponse({
    this.success,
    this.message,
    this.data,
  });

  OngoingEventResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? EventData.fromJson(json['data']) : null;
  }
  bool? success;
  dynamic message;
  EventData? data;

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

class EventData {
  EventData({
    this.id,
    this.name,
    this.bannerUrl,
    this.desc,
    this.listSessions,
    this.listBooths,
    this.listBoothsGame,
  });

  EventData.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    bannerUrl = json['image'];
    desc = json['desc'];

    if (json['sessions'] != null) {
      listSessions = [];
      json['sessions'].forEach((v) {
        listSessions?.add(Sessions.fromJson(v));
      });
    }
    if (json['booths'] != null) {
      listBooths = [];
      json['booths'].forEach((v) {
        listBooths?.add(Booths.fromJson(v));
      });
    }
    if (json['session_game'] != null) {
      listSessionsGame = [];
      json['session_game'].forEach((v) {
        listSessionsGame?.add(SessionGame.fromJson(v));
      });
    }
    if (json['booth_game'] != null) {
      listBoothsGame = [];
      json['booth_game'].forEach((v) {
        listBoothsGame?.add(BoothGame.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? bannerUrl;
  String? desc;
  List<Sessions>? listSessions;
  List<Booths>? listBooths;
  List<SessionGame>? listSessionsGame;
  List<BoothGame>? listBoothsGame;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['image'] = bannerUrl;
    map['desc'] = desc;
    if (listSessions != null) {
      map['sessions'] = listSessions?.map((v) => v.toJson()).toList();
    }
    if (listBooths != null) {
      map['booths'] = listBooths?.map((v) => v.toJson()).toList();
    }
    if (listSessionsGame != null) {
      map['booth_game'] = listSessionsGame?.map((v) => v.toJson()).toList();
    }
    if (listBoothsGame != null) {
      map['booth_game'] = listBoothsGame?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Sessions {
  Sessions({
    this.id,
    this.name,
    this.flag,
    this.desc,
  });

  Sessions.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    flag = json['flag'];
    desc = json['desc'];
  }
  String? id;
  String? name;
  bool? flag;
  String? desc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['flag'] = flag;
    map['desc'] = desc;
    return map;
  }
}

class Booths {
  Booths({
    this.id,
    this.name,
    this.flag,
    this.desc,
  });

  Booths.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    flag = json['flag'];
    desc = json['desc'];
  }
  String? id;
  String? name;
  bool? flag;
  String? desc;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['flag'] = flag;
    map['desc'] = desc;
    return map;
  }
}

class SessionGame {
  SessionGame({
    this.id,
    this.name,
    this.prizeAt,
    this.note,
    this.codes,
  });

  SessionGame.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    prizeAt = json['prize_at'];
    note = json['note'];
    codes = json['codes'];
  }
  String? id;
  String? name;
  String? prizeAt;
  String? note;
  List<dynamic>? codes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['prize_at'] = prizeAt;
    map['note'] = note;
    map['codes'] = codes;
    return map;
  }
}
class BoothGame {
  BoothGame({
    this.id,
    this.name,
    this.prizeAt,
    this.note,
    this.codes,
  });

  BoothGame.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    prizeAt = json['prize_at'];
    note = json['note'];
    codes = json['codes'];
  }
  String? id;
  String? name;
  String? prizeAt;
  String? note;
  List<dynamic>? codes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['prize_at'] = prizeAt;
    map['note'] = note;
    map['codes'] = codes;
    return map;
  }
}
