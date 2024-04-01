/// success : true
/// message : null
/// error_code : 1
/// data : [{"id":"97739934-8d82-41f7-999e-d3c7a60af0c2","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 11:11:13","data":{"action":"NEW_TASK","task_id":"123"}},{"id":"977398d0-b2fe-4cc6-af2f-2c459e4b9e6f","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 11:10:08","data":{"action":"NEW_TASK","task_id":"123"}},{"id":"977398ca-f79a-4ada-8d3d-3dd7e8ce4be3","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 11:10:04","data":{"action":"NEW_TASK","task_id":"123"}},{"id":"977398c1-1546-410f-ba49-35a3d12e610e","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 11:09:58","data":{"action":"NEW_TASK","task_id":"123"}},{"id":"97739801-29ef-422e-9694-9d22ed88666a","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 11:07:52","data":{"action":"NEW_TASK","task_id":"123"}},{"id":"977397f8-d970-4e1a-ac1d-3bf9ed513703","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 11:07:47","data":{"action":"NEW_TASK","task_id":"123"}},{"id":"977397e0-fdc9-4a81-8aa7-59e3911ebb07","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 11:07:31","data":{"action":"NEW_TASK","task_id":"123"}},{"id":"977395f8-f25c-425b-b977-de45725c79fa","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 11:02:11","data":{"action":"NEW_TASK","task_id":"123"}},{"id":"97738d57-2d47-44db-810a-d87804d708d2","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 10:38:03","data":{"action":"NEW_TASK","task_id":"123"}},{"id":"97738d43-75a8-4c97-9f4b-b7491e6f590a","title":"Test","description":"sss","time":"1 day ago","is_read":false,"is_read_label":"unread","icon":"https://i.imgur.com/UuCaWFA.png","created_at":"2022-10-08 10:37:50","data":{"action":"NEW_TASK","task_id":"123"}}]
/// meta : {"total_unread":10,"current_page":0,"last_page":1,"per_page":20,"total":1}

class ListNotificationsResponse {
  ListNotificationsResponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
    this.meta,
  });

  ListNotificationsResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    errorCode = json['error_code'];
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
  num? errorCode;
  List<Data>? data;
  Meta? meta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['error_code'] = errorCode;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    if (meta != null) {
      map['meta'] = meta?.toJson();
    }
    return map;
  }
}

/// total_unread : 10
/// current_page : 0
/// last_page : 1
/// per_page : 20
/// total : 1

class Meta {
  Meta({
    this.totalUnread,
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
  });

  Meta.fromJson(dynamic json) {
    totalUnread = json['total_unread'];
    currentPage = json['current_page'];
    lastPage = json['last_page'];
    perPage = json['per_page'];
    total = json['total'];
  }

  num? totalUnread;
  num? currentPage;
  num? lastPage;
  num? perPage;
  num? total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_unread'] = totalUnread;
    map['current_page'] = currentPage;
    map['last_page'] = lastPage;
    map['per_page'] = perPage;
    map['total'] = total;
    return map;
  }
}

/// id : "97739934-8d82-41f7-999e-d3c7a60af0c2"
/// title : "Test"
/// description : "sss"
/// time : "1 day ago"
/// is_read : false
/// is_read_label : "unread"
/// icon : "https://i.imgur.com/UuCaWFA.png"
/// created_at : "2022-10-08 11:11:13"
/// data : {"action":"NEW_TASK","task_id":"123"}

class Data {
  Data({
    this.id,
    this.title,
    this.description,
    this.time,
    this.isRead,
    this.isReadLabel,
    this.icon,
    this.createdAt,
    this.data,
  });

  Data.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    time = json['time'];
    isRead = json['is_read'];
    isReadLabel = json['is_read_label'];
    icon = json['icon'];
    createdAt = json['created_at'];
    data = json['data'] != null ? TaskData.fromJson(json['data']) : null;
  }

  String? id;
  String? title;
  String? description;
  String? time;
  bool? isRead;
  String? isReadLabel;
  String? icon;
  String? createdAt;
  TaskData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['time'] = time;
    map['is_read'] = isRead;
    map['is_read_label'] = isReadLabel;
    map['icon'] = icon;
    map['created_at'] = createdAt;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// action : "NEW_TASK"
/// task_id : "123"

class TaskData {
  TaskData({
    this.action,
    this.taskId,
  });

  TaskData.fromJson(dynamic json) {
    action = json['action'];
    taskId = json['task_id'];
  }

  String? action;
  String? taskId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['action'] = action;
    map['task_id'] = taskId;
    return map;
  }
}
