class ResultScanQRCodeResponse {
  ResultScanQRCodeResponse({
    this.success,
    this.message,
    this.data,
  });

  ResultScanQRCodeResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  dynamic message;
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

class Data {
  Data({
    this.id,
    this.name,
    this.description,
    this.bannerUrl,
    this.postBy,
    this.taskStart,
    this.like,
    this.pin,
    this.type,
    this.startAt,
    this.endAt,
    this.taskEvent,
    this.codeSession,
    this.codeBooth,
    this.flagSession,
    this.flagBooth,
    // this.taskSocial,
    // this.rewards,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    bannerUrl = json['banner_url'];
    postBy = json['post_by'];
    type = json['type'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    taskStart = json['task_start'];
    codeSession = json['code_session'];
    codeBooth = json['code_booth'];
    flagSession = json['flag_session'];
    flagBooth = json['flag_booth'];
    like = json['like'] != null ? Like.fromJson(json['like']) : null;
    pin = json['pin'] != null ? Pin.fromJson(json['pin']) : null;
    if (json['task_events'] != null) {
      taskEvent = [];
      json['task_events'].forEach((v) {
        taskEvent?.add(TaskEvents.fromJson(v));
      });
    }

    // rewards =
    //     json['rewards'] != null ? Rewards.fromJson(json['rewards']) : null;
  }
  String? id;
  String? name;
  String? description;
  String? bannerUrl;
  String? postBy;
  String? type;
  String? startAt;
  String? endAt;
  String? codeSession;
  String? codeBooth;
  bool? taskStart;
  bool? flagSession;
  bool? flagBooth;
  Like? like;
  Pin? pin;
  List<TaskEvents>? taskEvent;
  // Rewards? rewards;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['banner_url'] = bannerUrl;
    map['post_by'] = postBy;
    map['type'] = type;
    map['start_at'] = startAt;
    map['end_at'] = endAt;
    map['code_session'] = codeSession;
    map['code_booth'] = codeBooth;
    map['flag_session'] = flagSession;
    map['flag_booth'] = flagBooth;
    map['task_start'] = taskStart;
    if (like != null) {
      map['like'] = like?.toJson();
    }
    if (pin != null) {
      map['pin'] = pin?.toJson();
    }
    if (taskEvent != null) {
      map['task_events'] = taskEvent?.map((v) => v.toJson()).toList();
    }
    // if (rewards != null) {
    //   map['rewards'] = rewards?.toJson();
    // }
    return map;
  }
}

class Groups {
  Groups({
    this.id,
    this.name,
  });

  Groups.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

class Like {
  Like({
    this.isLike,
    this.typeLike,
  });
  Like.fromJson(dynamic json) {
    isLike = json['is_like'];
    typeLike = json['type_like'];
  }
  bool? isLike;
  String? typeLike;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_like'] = isLike;
    map['type_like'] = typeLike;
    return map;
  }
}

class Pin {
  Pin({
    this.isPin,
    this.typePin,
  });
  Pin.fromJson(dynamic json) {
    isPin = json['is_pin'];
    typePin = json['type_pin'];
  }
  bool? isPin;
  String? typePin;
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_pin'] = isPin;
    map['type_pin'] = typePin;
    return map;
  }
}

class Rewards {
  Rewards({
    this.name,
    this.type,
    this.description,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.region,
    this.startAt,
    this.endAt,
  });

  Rewards.fromJson(dynamic json) {
    name = json['name'];
    type = json['type'];
    description = json['description'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    region = json['region'];
    startAt = json['start_at'];
    endAt = json['end_at'];
  }
  String? name;
  num? type;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;
  num? region;
  String? startAt;
  String? endAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['type'] = type;
    map['description'] = description;
    map['image'] = image;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['region'] = region;
    map['start_at'] = startAt;
    map['end_at'] = endAt;
    return map;
  }
}

class TaskEvents {
  TaskEvents({
    this.id,
    this.name,
    this.description,
    this.type,
    this.bannerUrl,
    this.maxJob,
    this.jobs,
  });

  TaskEvents.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    description = json['description'];
    bannerUrl = json['banner_url'];
    maxJob = json['max_job'];
    if (json['jobs'] != null) {
      jobs = [];
      json['jobs'].forEach((v) {
        jobs?.add(EventJobs.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? description;
  String? type;
  String? bannerUrl;
  num? maxJob;
  List<EventJobs>? jobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    map['description'] = description;
    map['banner_url'] = bannerUrl;
    map['max_job'] = maxJob;
    if (jobs != null) {
      map['jobs'] = jobs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class EventJobs {
  EventJobs({
    this.id,
    this.name,
    this.description,
    this.statusDone,
  });

  EventJobs.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'];
    statusDone = json['status_done'];
    name = json['name'];
  }
  String? id;
  String? name;
  String? description;
  bool? statusDone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['status_done'] = statusDone;
    return map;
  }
}
