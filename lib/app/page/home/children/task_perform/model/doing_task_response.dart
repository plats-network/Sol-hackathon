/// success : true
/// message : null
/// data : {"id":"97cdf70e-1aa8-4886-9928-2e6734ea3888","time_left":1669110489,"duration":30,"duration_units":"minute","time_start":1669108689,"time_end":1669110489,"time_start_orginal":"2022-11-22 16:18:09","time_end_orginal":"2022-11-22 16:48:09","wallet_address":null,"time_expried":false,"near":{"radius":145,"units":"m"},"task":{"id":"1145481a-d16a-421e-8392-01776f73b134","name":"Highland Coffee","cover_url":"https://d37c8ertxcodlq.cloudfront.net/tasks/highlands-coffee/highlands-coffee-03.png"},"guide":{"url_image":"https://dy4io4rb1ui3a.cloudfront.net/default-imgs/guide_default.png"},"task_locations":{"id":"97af62cc-13ab-4b40-b332-394e309b44d9","name":"Highland Coffee Lê Văn Lương","address":"Starcity Apartment, 81 Đ. Lê Văn Lương, Nhân Chính, Thanh Xuân, Hà Nội, Việt Nam","long":"105.80648","lat":"21.00613","sort":9,"close_time":"22:00","open_time":"08:00","phone_number":"0983180522"}}

class DoingTaskResponse {
  DoingTaskResponse({
    this.success,
    this.message,
    this.data,
    this.errorCode,
  });

  DoingTaskResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    errorCode = json['error_code'];
  }

  bool? success;
  dynamic message;
  Data? data;
  int? errorCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['error_code'] = errorCode;
    return map;
  }
}

/// id : "97cdf70e-1aa8-4886-9928-2e6734ea3888"
/// time_left : 1669110489
/// duration : 30
/// duration_units : "minute"
/// time_start : 1669108689
/// time_end : 1669110489
/// time_start_orginal : "2022-11-22 16:18:09"
/// time_end_orginal : "2022-11-22 16:48:09"
/// wallet_address : null
/// time_expried : false
/// near : {"radius":145,"units":"m"}
/// task : {"id":"1145481a-d16a-421e-8392-01776f73b134","name":"Highland Coffee","cover_url":"https://d37c8ertxcodlq.cloudfront.net/tasks/highlands-coffee/highlands-coffee-03.png"}
/// guide : {"url_image":"https://dy4io4rb1ui3a.cloudfront.net/default-imgs/guide_default.png"}
/// task_locations : {"id":"97af62cc-13ab-4b40-b332-394e309b44d9","name":"Highland Coffee Lê Văn Lương","address":"Starcity Apartment, 81 Đ. Lê Văn Lương, Nhân Chính, Thanh Xuân, Hà Nội, Việt Nam","long":"105.80648","lat":"21.00613","sort":9,"close_time":"22:00","open_time":"08:00","phone_number":"0983180522"}

class Data {
  Data({
    this.id,
    this.timeLeft,
    this.duration,
    this.durationUnits,
    this.timeStart,
    this.timeEnd,
    this.timeStartOrginal,
    this.timeEndOrginal,
    this.walletAddress,
    this.timeExpried,
    this.near,
    this.task,
    this.guide,
    this.taskLocations,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    timeLeft = json['time_left'];
    duration = json['duration'];
    durationUnits = json['duration_units'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    timeStartOrginal = json['time_start_orginal'];
    timeEndOrginal = json['time_end_orginal'];
    walletAddress = json['wallet_address'];
    timeExpried = json['time_expried'];
    near = json['near'] != null ? Near.fromJson(json['near']) : null;
    task = json['task'] != null ? Task.fromJson(json['task']) : null;
    guide = json['guide'] != null ? Guide.fromJson(json['guide']) : null;
    taskLocations = json['task_locations'] != null
        ? TaskLocations.fromJson(json['task_locations'])
        : null;
  }

  String? id;
  num? timeLeft;
  num? duration;
  String? durationUnits;
  num? timeStart;
  num? timeEnd;
  String? timeStartOrginal;
  String? timeEndOrginal;
  dynamic walletAddress;
  bool? timeExpried;
  Near? near;
  Task? task;
  Guide? guide;
  TaskLocations? taskLocations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['time_left'] = timeLeft;
    map['duration'] = duration;
    map['duration_units'] = durationUnits;
    map['time_start'] = timeStart;
    map['time_end'] = timeEnd;
    map['time_start_orginal'] = timeStartOrginal;
    map['time_end_orginal'] = timeEndOrginal;
    map['wallet_address'] = walletAddress;
    map['time_expried'] = timeExpried;
    if (near != null) {
      map['near'] = near?.toJson();
    }
    if (task != null) {
      map['task'] = task?.toJson();
    }
    if (guide != null) {
      map['guide'] = guide?.toJson();
    }
    if (taskLocations != null) {
      map['task_locations'] = taskLocations?.toJson();
    }
    return map;
  }
}

/// id : "97af62cc-13ab-4b40-b332-394e309b44d9"
/// name : "Highland Coffee Lê Văn Lương"
/// address : "Starcity Apartment, 81 Đ. Lê Văn Lương, Nhân Chính, Thanh Xuân, Hà Nội, Việt Nam"
/// long : "105.80648"
/// lat : "21.00613"
/// sort : 9
/// close_time : "22:00"
/// open_time : "08:00"
/// phone_number : "0983180522"

class TaskLocations {
  TaskLocations({
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

  TaskLocations.fromJson(dynamic json) {
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
  String? closeTime;
  String? openTime;
  String? phoneNumber;

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

/// url_image : "https://dy4io4rb1ui3a.cloudfront.net/default-imgs/guide_default.png"

class Guide {
  Guide({
    this.urlImage,
  });

  Guide.fromJson(dynamic json) {
    urlImage = json['url_image'];
  }

  String? urlImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url_image'] = urlImage;
    return map;
  }
}

/// id : "1145481a-d16a-421e-8392-01776f73b134"
/// name : "Highland Coffee"
/// cover_url : "https://d37c8ertxcodlq.cloudfront.net/tasks/highlands-coffee/highlands-coffee-03.png"

class Task {
  Task({
    this.id,
    this.name,
    this.coverUrl,
  });

  Task.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    coverUrl = json['cover_url'];
  }

  String? id;
  String? name;
  String? coverUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['cover_url'] = coverUrl;
    return map;
  }
}

/// radius : 145
/// units : "m"

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
