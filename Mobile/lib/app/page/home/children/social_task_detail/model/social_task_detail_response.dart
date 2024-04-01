// class SocialTaskDetailResponse {
//   SocialTaskDetailResponse({
//     this.success,
//     this.message,
//     this.data,
//   });

//   SocialTaskDetailResponse.fromJson(dynamic json) {
//     success = json['success'];
//     message = json['message'];
//     data = json['data'] != null ? Data.fromJson(json['data']) : null;
//   }
//   bool? success;
//   dynamic message;
//   Data? data;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['success'] = success;
//     map['message'] = message;
//     if (data != null) {
//       map['data'] = data?.toJson();
//     }
//     return map;
//   }
// }

// class Data {
//   Data({
//     this.id,
//     this.name,
//     this.isDone,
//     this.description,
//     this.type,
//     this.taskStart,
//     this.coverUrl,
//     this.postBy,
//     this.socials,
//     this.galleries,
//     this.rewards,
//   });

//   Data.fromJson(dynamic json) {
//     id = json['id'];
//     name = json['name'];
//     isDone = json['is_done'];
//     description = json['description'];
//     type = json['type'];
//     taskStart = json['task_start'];
//     coverUrl = json['cover_url'];
//     postBy = json['post_by'];
//     if (json['socials'] != null) {
//       socials = [];
//       json['socials'].forEach((v) {
//         socials?.add(Socials.fromJson(v));
//       });
//     }
//     if (json['galleries'] != null) {
//       galleries = [];
//       json['galleries'].forEach((v) {
//         galleries?.add(Galleries.fromJson(v));
//       });
//     }
//     rewards =
//         json['rewards'] != null ? Rewards.fromJson(json['rewards']) : null;
//   }
//   String? id;
//   String? name;
//   bool? isDone;
//   String? description;
//   String? type;
//   bool? taskStart;
//   String? coverUrl;
//   String? postBy;
//   List<Socials>? socials;
//   List<Galleries>? galleries;
//   Rewards? rewards;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['name'] = name;
//     map['is_done'] = isDone;
//     map['description'] = description;
//     map['type'] = type;
//     map['task_start'] = taskStart;
//     map['cover_url'] = coverUrl;
//     map['post_by'] = postBy;
//     if (socials != null) {
//       map['socials'] = socials?.map((v) => v.toJson()).toList();
//     }
//     if (galleries != null) {
//       map['galleries'] = galleries?.map((v) => v.toJson()).toList();
//     }
//     if (rewards != null) {
//       map['rewards'] = rewards?.toJson();
//     }
//     return map;
//   }
// }

// /// name : "1 Mystery box"
// /// type : 0
// /// description : "Desc my box"
// /// image : "https://d37c8ertxcodlq.cloudfront.net/icon/hidden_box.png"
// /// created_at : "2022-11-07T04:28:45.000000Z"
// /// updated_at : "2022-11-07T04:29:01.000000Z"
// /// region : 0
// /// start_at : "2022-11-07"
// /// end_at : "2023-11-02"

// class Rewards {
//   Rewards({
//     this.name,
//     this.type,
//     this.description,
//     this.image,
//     this.createdAt,
//     this.updatedAt,
//     this.region,
//     this.startAt,
//     this.endAt,
//   });

//   Rewards.fromJson(dynamic json) {
//     name = json['name'];
//     type = json['type'];
//     description = json['description'];
//     image = json['image'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     region = json['region'];
//     startAt = json['start_at'];
//     endAt = json['end_at'];
//   }
//   String? name;
//   num? type;
//   String? description;
//   String? image;
//   String? createdAt;
//   String? updatedAt;
//   num? region;
//   String? startAt;
//   String? endAt;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['name'] = name;
//     map['type'] = type;
//     map['description'] = description;
//     map['image'] = image;
//     map['created_at'] = createdAt;
//     map['updated_at'] = updatedAt;
//     map['region'] = region;
//     map['start_at'] = startAt;
//     map['end_at'] = endAt;
//     return map;
//   }
// }

// /// url : "https://d37c8ertxcodlq.cloudfront.net/tasks/cover/20221202/6vMVmUREx7jRoq5dcdJ19wL1oB5bwB1NlDoGC9Mo.jpg"

// class Galleries {
//   Galleries({
//     this.url,
//   });

//   Galleries.fromJson(dynamic json) {
//     url = json['url'];
//   }
//   String? url;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['url'] = url;
//     return map;
//   }
// }

// /// id : "97e1ba07-d4c8-4148-aee7-2d8323a5d6e7"
// /// task_id : "97e1ba07-c49a-47ed-ad64-b6f12573f144"
// /// name : "Follow Near Vietnam Hub"
// /// description : "Connect your Twitter account to verify Twitter actions in 1click.\r\nWe will not post without your permission."
// /// type : "follow"
// /// url : "https://twitter.com/NearVietnamHub"
// /// url_intent : "https://twitter.com/intent/follow?screen_name=NearVietnamHub"
// /// tbn_label : "Follow"
// /// start : false
// /// prize : {"name":"PSP","amount":15}
// /// action : {"status":true,"label":"complete"}
// /// icon : "https://d37c8ertxcodlq.cloudfront.net/icon/tweeter.png"

// class Socials {
//   Socials({
//     this.id,
//     this.taskId,
//     this.name,
//     this.description,
//     this.type,
//     this.url,
//     this.urlIntent,
//     this.tbnLabel,
//     this.start,
//     this.prize,
//     this.action,
//     this.icon,
//   });

//   Socials.fromJson(dynamic json) {
//     id = json['id'];
//     taskId = json['task_id'];
//     name = json['name'];
//     description = json['description'];
//     type = json['type'];
//     url = json['url'];
//     urlIntent = json['url_intent'];
//     tbnLabel = json['tbn_label'];
//     start = json['start'];
//     prize = json['prize'] != null ? Prize.fromJson(json['prize']) : null;
//     action = json['action'] != null ? Action.fromJson(json['action']) : null;
//     icon = json['icon'];
//   }
//   String? id;
//   String? taskId;
//   String? name;
//   String? description;
//   String? type;
//   String? url;
//   String? urlIntent;
//   String? tbnLabel;
//   bool? start;
//   Prize? prize;
//   Action? action;
//   String? icon;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['id'] = id;
//     map['task_id'] = taskId;
//     map['name'] = name;
//     map['description'] = description;
//     map['type'] = type;
//     map['url'] = url;
//     map['url_intent'] = urlIntent;
//     map['tbn_label'] = tbnLabel;
//     map['start'] = start;
//     if (prize != null) {
//       map['prize'] = prize?.toJson();
//     }
//     if (action != null) {
//       map['action'] = action?.toJson();
//     }
//     map['icon'] = icon;
//     return map;
//   }
// }

// /// status : true
// /// label : "complete"

// class Action {
//   Action({
//     this.status,
//     this.label,
//   });

//   Action.fromJson(dynamic json) {
//     status = json['status'];
//     label = json['label'];
//   }
//   bool? status;
//   String? label;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['status'] = status;
//     map['label'] = label;
//     return map;
//   }
// }

// /// name : "PSP"
// /// amount : 15

// class Prize {
//   Prize({
//     this.name,
//     this.amount,
//   });

//   Prize.fromJson(dynamic json) {
//     name = json['name'];
//     amount = json['amount'];
//   }
//   String? name;
//   num? amount;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['name'] = name;
//     map['amount'] = amount;
//     return map;
//   }
// }

class SocialTaskDetailResponse {
  SocialTaskDetailResponse({
    this.success,
    this.message,
    this.data,
  });

  SocialTaskDetailResponse.fromJson(dynamic json) {
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
    this.address,
    this.lat,
    this.lng,
    this.codeSession,
    this.codeBooth,
    this.session,
    this.booth,
    this.shares,
    this.twitter,
    this.discord,
    this.linkQuiz,
    this.flagTicket,
    // this.taskCheckIn,
    // this.taskSocial,
    // this.rewards,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
    bannerUrl = json['banner_url'];
    postBy = json['post_by'];
    type = json['type'];
    startAt = json['start_at'];
    endAt = json['end_at'];
    linkQuiz = json['link_quiz'];
    flagTicket = json['flag_ticket'];
    codeSession = json['code_session'];
    codeBooth = json['code_booth'];
    taskStart = json['task_start'];
    like = json['like'] != null ? Like.fromJson(json['like']) : null;
    twitter =
        json['twitter'] != null ? Twitter.fromJson(json['twitter']) : null;
    discord =
        json['discord'] != null ? Discord.fromJson(json['discord']) : null;
    pin = json['pin'] != null ? Pin.fromJson(json['pin']) : null;
    session =
        json['session'] != null ? Session.fromJson(json['session']) : null;
    booth = json['booth'] != null ? Booth.fromJson(json['booth']) : null;
    shares = json['shares'] != null ? Shares.fromJson(json['shares']) : null;
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
  String? address;
  num? lat;
  num? lng;
  String? bannerUrl;
  String? postBy;
  String? type;
  String? startAt;
  String? endAt;
  bool? taskStart;
  bool? flagTicket;
  String? codeSession;
  String? codeBooth;
  String? linkQuiz;
  Like? like;
  Pin? pin;
  Session? session;
  Booth? booth;
  Twitter? twitter;
  Discord? discord;
  Shares? shares;
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
    map['address'] = address;
    map['lat'] = lat;
    map['lng'] = lng;
    map['banner_url'] = bannerUrl;
    map['post_by'] = postBy;
    map['type'] = type;
    map['start_at'] = startAt;
    map['end_at'] = endAt;
    map['link_quiz'] = linkQuiz;
    map['flag_ticket'] = flagTicket;
    map['code_session'] = codeSession;
    map['code_booth'] = codeBooth;
    map['task_start'] = taskStart;
    if (like != null) {
      map['like'] = like?.toJson();
    }
    if (twitter != null) {
      map['twitter'] = twitter?.toJson();
    }
    if (discord != null) {
      map['discord'] = discord?.toJson();
    }
    if (pin != null) {
      map['pin'] = pin?.toJson();
    }
    if (session != null) {
      map['session'] = session?.toJson();
    }
    if (booth != null) {
      map['booth'] = booth?.toJson();
    }
    if (shares != null) {
      map['shares'] = shares?.toJson();
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

class Session {
  Session({
    this.id,
    this.name,
    this.sessionSuccess,
    this.jobs,
  });

  Session.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    sessionSuccess = json['session_success'];
    if (json['jobs'] != null) {
      jobs = [];
      json['jobs'].forEach((v) {
        jobs?.add(EventJobs.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? sessionSuccess;
  List<EventJobs>? jobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['session_success'] = sessionSuccess;
    if (jobs != null) {
      map['jobs'] = jobs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Booth {
  Booth({
    this.id,
    this.name,
    this.boothSuccess,
    this.boothCode,
    this.jobs,
  });

  Booth.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    boothSuccess = json['booth_success'];
    boothCode = json['booth_code'];
    if (json['jobs'] != null) {
      jobs = [];
      json['jobs'].forEach((v) {
        jobs?.add(EventJobs.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? boothSuccess;
  num? boothCode;
  List<EventJobs>? jobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['booth_success'] = boothSuccess;
    map['booth_code'] = boothCode;
    if (jobs != null) {
      map['jobs'] = jobs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Twitter {
  Twitter({
    this.id,
    this.url,
    this.textTweet,
    this.isComment,
    this.isLike,
    this.isRetweet,
    this.isTweet,
  });

  Twitter.fromJson(dynamic json) {
    id = json['id'];
    url = json['url'];
    textTweet = json['text_tweet'];
    isComment = json['is_comment'];
    isLike = json['is_like'];
    isRetweet = json['is_retweet'];
    isTweet = json['is_tweet'];
  }
  String? id;
  String? url;
  String? textTweet;
  bool? isComment;
  bool? isLike;
  bool? isRetweet;
  bool? isTweet;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['url'] = url;
    map['text_tweet'] = textTweet;
    map['is_comment'] = isComment;
    map['is_like'] = isLike;
    map['is_retweet'] = isRetweet;
    map['is_tweet'] = isTweet;
    return map;
  }
}

class Discord {
  Discord({
    this.id,
    this.isJoin,
  });

  Discord.fromJson(dynamic json) {
    id = json['id'];
    isJoin = json['is_join'];
  }
  String? id;
  bool? isJoin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['is_join'] = isJoin;
    return map;
  }
}

class Shares {
  Shares({
    this.facebook,
    this.twitter,
    this.telegram,
    this.discord,
    this.email,
    this.linkedin,
    this.whatsapp,
  });

  Shares.fromJson(dynamic json) {
    facebook = json['facebook'];
    twitter = json['twitter'];
    telegram = json['telegram'];
    discord = json['discord'];
    email = json['email'];
    linkedin = json['linkedin'];
    whatsapp = json['whatsapp'];
  }
  String? facebook;
  String? twitter;
  String? telegram;
  String? discord;
  String? email;
  String? linkedin;
  String? whatsapp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facebook'] = facebook;
    map['twitter'] = twitter;
    map['telegram'] = telegram;
    map['discord'] = discord;
    map['email'] = email;
    map['linkedin'] = linkedin;
    map['whatsapp'] = whatsapp;
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
    // map['lat'] = lat;
    // map['lng'] = lng;
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
    this.sessionSuccess,
    this.boothSuccess,
    this.sessionCode,
    this.boothCode,
    this.type,
    this.typeNumber,
    this.jobs,
  });

  TaskEvents.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    sessionSuccess = json['session_success'];
    boothSuccess = json['booth_success'];
    sessionCode = json['session_code'];
    boothCode = json['booth_code'];
    type = json['type'];
    typeNumber = json['type_number'];
    if (json['jobs'] != null) {
      jobs = [];
      json['jobs'].forEach((v) {
        jobs?.add(EventJobs.fromJson(v));
      });
    }
  }
  String? id;
  String? name;
  String? sessionSuccess;
  String? boothSuccess;
  String? sessionCode;
  String? boothCode;
  String? type;
  num? typeNumber;
  List<EventJobs>? jobs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['session_success'] = sessionSuccess;
    map['booth_success'] = boothSuccess;
    map['session_code'] = sessionCode;
    map['booth_code'] = boothCode;
    map['type_number'] = typeNumber;
    map['type'] = type;
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
    this.code,
    this.description,
    this.statusDone,
  });

  EventJobs.fromJson(dynamic json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    statusDone = json['status_done'];
    name = json['name'];
  }
  String? id;
  String? name;
  String? code;
  String? description;
  bool? statusDone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['code'] = code;
    map['description'] = description;
    map['status_done'] = statusDone;
    return map;
  }
}
