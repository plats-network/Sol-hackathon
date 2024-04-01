class TaskPoolListResponse {
  TaskPoolListResponse({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  TaskPoolListResponse.fromJson(dynamic json) {
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
    this.description,
    this.bannerUrl,
    this.postBy,
    this.taskStart,
    this.like,
    this.pin,
    this.endAt,
    this.type,
    this.taskCheckIn,
    this.address,
    // this.rewards,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    description = json['description'];
    type = json['type'];
    bannerUrl = json['banner_url'];
    postBy = json['post_by'];
    taskStart = json['task_start'];
    endAt = json['end_at'];
    like = json['like'] != null ? Like.fromJson(json['like']) : null;
    pin = json['pin'] != null ? Pin.fromJson(json['pin']) : null;
    if (json['task_checkin'] != null) {
      taskCheckIn = [];
      json['task_checkin'].forEach((v) {
        taskCheckIn?.add(TaskCheckIn.fromJson(v));
      });
    }
    // rewards =
    //     json['rewards'] != null ? Rewards.fromJson(json['rewards']) : null;
  }
  String? id;
  String? name;
  String? address;
  String? description;
  String? type;
  String? bannerUrl;
  String? postBy;
  String? endAt;
  bool? taskStart;
  Like? like;
  Pin? pin;
  List<TaskCheckIn>? taskCheckIn;
  // Rewards? rewards;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['description'] = description;
    map['type'] = type;
    map['banner_url'] = bannerUrl;
    map['post_by'] = postBy;
    map['task_start'] = taskStart;
    map['end_at'] = endAt;
    if (like != null) {
      map['like'] = like?.toJson();
    }
    if (pin != null) {
      map['pin'] = pin?.toJson();
    }
    if (taskCheckIn != null) {
      map['task_checkin'] = taskCheckIn?.map((v) => v.toJson()).toList();
    }
    // if (rewards != null) {
    //   map['rewards'] = rewards?.toJson();
    // }
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

class TaskCheckIn {
  TaskCheckIn({
    this.id,
    this.name,
    this.description,
    this.amount,
    this.jobNum,
    this.jobs,
  });

  TaskCheckIn.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    amount = json['amount'];
    jobNum = json['job_num'];
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
  num? amount;
  num? jobNum;
  List<Jobs>? jobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['amount'] = amount;
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
