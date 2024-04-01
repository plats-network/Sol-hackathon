/// success : true
/// message : null
/// error_code : 1
/// data : {"title":"Test","description":"sss","icon":null,"content":null,"is_read":true,"created_at":"2022-10-08 11:11:13","data":{"action":"NEW_TASK","task_id":"123"}}

class NotificationDetailResponse {
  NotificationDetailResponse({
    this.success,
    this.message,
    this.errorCode,
    this.data,
  });

  NotificationDetailResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    errorCode = json['error_code'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? success;
  dynamic message;
  num? errorCode;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['error_code'] = errorCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// title : "Test"
/// description : "sss"
/// icon : null
/// content : null
/// is_read : true
/// created_at : "2022-10-08 11:11:13"
/// data : {"action":"NEW_TASK","task_id":"123"}

class Data {
  Data({
    this.title,
    this.description,
    this.icon,
    this.content,
    this.isRead,
    this.createdAt,
    this.data,
  });

  Data.fromJson(dynamic json) {
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    content = json['content'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
    data = json['data'] != null ? TaskData.fromJson(json['data']) : null;
  }

  String? title;
  String? description;
  dynamic icon;
  dynamic content;
  bool? isRead;
  String? createdAt;
  TaskData? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['icon'] = icon;
    map['content'] = content;
    map['is_read'] = isRead;
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
