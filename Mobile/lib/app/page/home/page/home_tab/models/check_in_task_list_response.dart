class CheckInTaskListResponse {
  CheckInTaskListResponse({
    this.success,
    this.message,
    this.data,
    this.meta,
  });

  CheckInTaskListResponse.fromJson(dynamic json) {
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
    this.duration,
    this.order,
    this.validAmount,
    this.validRadius,
    this.distance,
    this.depositStatus,
    this.type,
    this.createdAt,
    this.coverUrl,
    this.creatorId,
    this.creatorName,
    this.improgressFlag,
    this.taskDone,
    this.taskImprogress,
    this.taskDoneNumber,
    this.near,
    this.locations,
    this.galleries,
    this.rewards,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    duration = json['duration'];
    order = json['order'];
    validAmount = json['valid_amount'];
    validRadius = json['valid_radius'];
    distance = json['distance'];
    depositStatus = json['deposit_status'];
    type = json['type'];
    createdAt = json['created_at'];
    coverUrl = json['cover_url'];
    creatorId = json['creator_id'];
    creatorName = json['creator_name'];
    improgressFlag = json['improgress_flag'];
    taskDone = json['task_done'];
    taskImprogress = json['task_improgress'];
    taskDoneNumber = json['task_done_number'];
    near = json['near'] != null ? Near.fromJson(json['near']) : null;
    if (json['locations'] != null) {
      locations = [];
      json['locations'].forEach((v) {
        locations?.add(Locations.fromJson(v));
      });
    }
    if (json['galleries'] != null) {
      galleries = [];
      json['galleries'].forEach((v) {
        galleries?.add(Galleries.fromJson(v));
      });
    }
    rewards =
        json['rewards'] != null ? Rewards.fromJson(json['rewards']) : null;
  }
  String? id;
  String? name;
  String? description;
  num? duration;
  num? order;
  num? validAmount;
  num? validRadius;
  String? distance;
  num? depositStatus;
  num? type;
  String? createdAt;
  String? coverUrl;
  String? creatorId;
  String? creatorName;
  bool? improgressFlag;
  bool? taskDone;
  dynamic taskImprogress;
  num? taskDoneNumber;
  Near? near;
  List<Locations>? locations;
  List<Galleries>? galleries;
  Rewards? rewards;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    map['duration'] = duration;
    map['order'] = order;
    map['valid_amount'] = validAmount;
    map['valid_radius'] = validRadius;
    map['distance'] = distance;
    map['deposit_status'] = depositStatus;
    map['type'] = type;
    map['created_at'] = createdAt;
    map['cover_url'] = coverUrl;
    map['creator_id'] = creatorId;
    map['creator_name'] = creatorName;
    map['improgress_flag'] = improgressFlag;
    map['task_done'] = taskDone;
    map['task_improgress'] = taskImprogress;
    map['task_done_number'] = taskDoneNumber;
    if (near != null) {
      map['near'] = near?.toJson();
    }
    if (locations != null) {
      map['locations'] = locations?.map((v) => v.toJson()).toList();
    }
    if (galleries != null) {
      map['galleries'] = galleries?.map((v) => v.toJson()).toList();
    }
    if (rewards != null) {
      map['rewards'] = rewards?.toJson();
    }
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

class Galleries {
  Galleries({
    this.url,
  });

  Galleries.fromJson(dynamic json) {
    url = json['url'];
  }
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = url;
    return map;
  }
}

class Locations {
  Locations({
    this.id,
    this.name,
    this.address,
    this.long,
    this.lat,
    this.sort,
    this.closeTime,
    this.openTime,
    this.phoneNumber,
  });

  Locations.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    long = json['long'];
    lat = json['lat'];
    sort = json['sort'];
    closeTime = json['close_time'];
    openTime = json['open_time'];
    phoneNumber = json['phone_number'];
  }
  String? id;
  String? name;
  String? address;
  String? long;
  String? lat;
  num? sort;
  dynamic closeTime;
  dynamic openTime;
  dynamic phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['address'] = address;
    map['long'] = long;
    map['lat'] = lat;
    map['sort'] = sort;
    map['close_time'] = closeTime;
    map['open_time'] = openTime;
    map['phone_number'] = phoneNumber;
    return map;
  }
}

class Near {
  Near({
    this.radius,
    this.units,
  });

  Near.fromJson(dynamic json) {
    radius = json['radius'];
    units = json['units'];
  }
  num? radius;
  String? units;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['radius'] = radius;
    map['units'] = units;
    return map;
  }
}
