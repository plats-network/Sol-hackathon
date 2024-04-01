
class IndexResponse {
  IndexResponse({
    this.success,
    this.message,
    this.data,
  });

  IndexResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(Data.fromJson(v));
      });
    }
  }
  bool? success;
  dynamic message;
  List<Data>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Data {
  Data(
      {this.id,
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
      this.address,
      this.lat,
      this.lng,
      this.codeSession,
      this.codeBooth
      // this.taskCheckIn,
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
    startAt = json['start_at'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    endAt = json['end_at'];
    codeSession = json['code_session'];
    codeBooth = json['code_booth'];
    like = json['like'] != null ? Like.fromJson(json['like']) : null;
    pin = json['pin'] != null ? Pin.fromJson(json['pin']) : null;
    if (json['groups'] != null) {
      groups = [];
      json['groups'].forEach((v) {
        groups?.add(Groups.fromJson(v));
      });
    }
    if (json['task_checkin'] != null) {
      taskCheckIn = [];
      json['task_checkin'].forEach((v) {
        taskCheckIn?.add(TaskCheckIn.fromJson(v));
      });
    }
    if (json['task_events'] != null) {
      taskEvent = [];
      json['task_events'].forEach((v) {
        taskEvent?.add(TaskEvents.fromJson(v));
      });
    }
    if (json['task_socials'] != null) {
      taskSocial = [];
      json['task_socials'].forEach((v) {
        taskSocial?.add(TaskSocials.fromJson(v));
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
  bool? taskStart;
  Like? like;
  Pin? pin;
  String? address;
  num? lat;
  num? lng;
  String? codeSession;
  String? codeBooth;
  List<Groups>? groups;
  List<TaskCheckIn>? taskCheckIn;
  List<TaskSocials>? taskSocial;
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
    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;
    map['code_session'] = codeSession;
    map['code_booth'] = codeBooth;
    map['task_start'] = taskStart;
    if (like != null) {
      map['like'] = like?.toJson();
    }
    if (pin != null) {
      map['pin'] = pin?.toJson();
    }
    if (taskCheckIn != null) {
      map['task_checkin'] = taskCheckIn?.map((v) => v.toJson()).toList();
    }
    if (taskEvent != null) {
      map['task_events'] = taskEvent?.map((v) => v.toJson()).toList();
    }
    if (groups != null) {
      map['groups'] = groups?.map((v) => v.toJson()).toList();
    }
    if (taskSocial != null) {
      map['task_socials'] = taskSocial?.map((v) => v.toJson()).toList();
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

class TaskCheckIn {
  TaskCheckIn({
    this.id,
    this.name,
    this.description,
    this.amount,
    this.jobNum,
    this.jobs,
    this.jobType,
    this.jobStatus,
  });

  TaskCheckIn.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    amount = json['amount'];
    jobNum = json['job_num'];
    jobType = json['job_type'];
    jobStatus = json['job_status'];
    if (json['jobs'] != null) {
      jobs = [];
      json['jobs'].forEach((v) {
        jobs?.add(Jobs.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? description;
  String? jobType;
  bool? jobStatus;
  num? amount;
  num? jobNum;
  List<Jobs>? jobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['amount'] = amount;
    map['job_status'] = jobStatus;
    map['job_type'] = jobType;
    map['job_num'] = jobNum;
    if (jobs != null) {
      map['jobs'] = jobs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Jobs {
  Jobs({
    this.id,
    this.name,
    this.address,
    this.lat,
    this.lng,
  });

  Jobs.fromJson(dynamic json) {
    id = json['id'];
    address = json['address'];
    lat = json['lat'];
    name = json['name'];
    lng = json['lng'];
  }
  String? id;
  String? name;
  String? address;
  num? lat;
  num? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}

class TaskSocials {
  TaskSocials({
    this.id,
    this.rewardId,
    this.name,
    this.description,
    this.amount,
    this.url,
    this.platform,
    this.type,
    this.lock,
    this.status,
    this.jobType,
    this.jobStatus,
  });

  TaskSocials.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    amount = json['amount'];
    rewardId = json['reward_id'];
    url = json['url'];
    platform = json['platform'];
    type = json['type'];
    lock = json['lock'];
    status = json['status'];
    jobStatus = json['job_status'];
    jobType = json['job_type'];
  }
  String? id;
  String? rewardId;
  String? name;
  String? description;
  String? url;
  num? platform;
  num? amount;
  num? type;
  bool? lock;
  bool? status;
  String? jobType;
  bool? jobStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['amount'] = amount;
    map['lock'] = lock;
    map['reward_id'] = rewardId;
    map['platform'] = platform;
    map['type'] = type;
    map['status'] = status;
    map['url'] = url;
    map['job_status'] = jobStatus;
    map['job_type'] = jobType;
    return map;
  }
}

class TaskEvents {
  TaskEvents({
    this.id,
    this.name,
    this.description,
    this.bannerUrl,
    this.maxJob,
    this.type,
    this.jobs,
  });

  TaskEvents.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    bannerUrl = json['banner_url'];
    type = json['type'];
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
  String? bannerUrl;
  String? type;
  num? maxJob;
  List<EventJobs>? jobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['banner_url'] = bannerUrl;
    map['type'] = type;
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
