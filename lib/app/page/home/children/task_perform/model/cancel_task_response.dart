/// data : {"message":"DONE!"}
/// message : ""
/// exception : "Symfony\\Component\\HttpKernel\\Exception\\NotFoundHttpException"
/// file : "/var/www/actions-plats/vendor/laravel/framework/src/Illuminate/Routing/AbstractRouteCollection.php"
/// line : 44
/// trace : [{"file":"/var/www/actions-plats/vendor/laravel/framework/src/Illuminate/Routing/RouteCollection.php","line":162,"function":"handleMatchedRoute","class":"Illuminate\\Routing\\AbstractRouteCollection","type":"->"}]

class CancelTaskResponse {
  CancelTaskResponse({
    this.data,
    this.message,
    this.exception,
    this.file,
    this.line,
    this.trace,
  });

  CancelTaskResponse.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
    exception = json['exception'];
    file = json['file'];
    line = json['line'];
    if (json['trace'] != null) {
      trace = [];
      json['trace'].forEach((v) {
        trace?.add(Trace.fromJson(v));
      });
    }
  }

  Data? data;
  String? message;
  String? exception;
  String? file;
  num? line;
  List<Trace>? trace;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['message'] = message;
    map['exception'] = exception;
    map['file'] = file;
    map['line'] = line;
    if (trace != null) {
      map['trace'] = trace?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// file : "/var/www/actions-plats/vendor/laravel/framework/src/Illuminate/Routing/RouteCollection.php"
/// line : 162
/// function : "handleMatchedRoute"
/// class : "Illuminate\\Routing\\AbstractRouteCollection"
/// type : "->"

class Trace {
  Trace({
    this.file,
    this.line,
    this.function,
    this.type,
  });

  Trace.fromJson(dynamic json) {
    file = json['file'];
    line = json['line'];
    function = json['function'];
    type = json['type'];
  }

  String? file;
  num? line;
  String? function;
  String? type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['file'] = file;
    map['line'] = line;
    map['function'] = function;
    map['type'] = type;
    return map;
  }
}

/// message : "DONE!"

class Data {
  Data({
    this.message,
  });

  Data.fromJson(dynamic json) {
    message = json['message'];
  }

  String? message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    return map;
  }
}
