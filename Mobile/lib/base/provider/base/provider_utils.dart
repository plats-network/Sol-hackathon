import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

const MAX_BODY_BYTES_LENGTH = 20000;

void logProviderRequest(Request request) {
  compute(requestBodyBytesBuilder, request).then((bodyBytes) {
    print('''Send request:
Url: ${request.method.toUpperCase()} ${request.url}
Header: ${request.headers}
Body: $bodyBytes''');
  });
}

Future<String> requestBodyBytesBuilder(Request request) async {
  var bytes = await request.bodyBytes.toBytes();
  String bodyBytes = String.fromCharCodes(bytes);
  if (bodyBytes.length > MAX_BODY_BYTES_LENGTH) {
    bodyBytes = bodyBytes.substring(0, MAX_BODY_BYTES_LENGTH);
  }
  return bodyBytes;
}

void logProviderResponse(Response response) {
  compute(responseBodyBytesBuilder, response.request).then((bodyBytes) {
    log('''Receive response:
From request: ${response.request?.method.toUpperCase()} ${response.request?.url}
And body: $bodyBytes
Response: ${response.statusCode} ${response.bodyString}''');
  });
}

Future<String> responseBodyBytesBuilder(Request? request) async {
  var bytes = await request?.bodyBytes.toBytes();
  String bodyBytes = String.fromCharCodes(bytes ?? []);
  if (bodyBytes.length > MAX_BODY_BYTES_LENGTH) {
    bodyBytes = bodyBytes.substring(0, MAX_BODY_BYTES_LENGTH);
  }
  return bodyBytes;
}
