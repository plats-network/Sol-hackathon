/// success : true
/// message : "Có task đang chạy!"
/// data : {"is_improgress":true}

class StartTaskResponse {
  StartTaskResponse({
      this.success, 
      this.message, 
      this.data,});

  StartTaskResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? success;
  String? message;
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

/// is_improgress : true

class Data {
  Data({
      this.isImprogress,});

  Data.fromJson(dynamic json) {
    isImprogress = json['is_improgress'];
  }
  bool? isImprogress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_improgress'] = isImprogress;
    return map;
  }

}