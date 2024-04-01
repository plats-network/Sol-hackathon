import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

void debugMock(VoidCallback onDevelopment, {VoidCallback? onProduction}) {
  if (kDebugMode) {
    onDevelopment();
  } else {
    onProduction?.call();
  }
}

Widget debugMockWidget(Widget developmentWidget, {Widget? productionWidget}) {
  if (kDebugMode) {
    return developmentWidget;
  } else if (productionWidget != null) {
    return productionWidget;
  } else {
    return Container();
  }
}

Future<void> devDebugMock(VoidCallback onDevelopment,
    {VoidCallback? onProduction}) async {
  final variant = dotenv.env['VARIANT'];
  if (variant == 'development' && kDebugMode) {
    onDevelopment();
  } else if (variant == 'production') {
    onProduction?.call();
  }
}

Widget devDebugMockWidget(Widget developmentWidget,
    {Widget? productionWidget}) {
  final variant = dotenv.env['VARIANT'];
  if (variant == 'development' && kDebugMode) {
    return developmentWidget;
  } else if (variant == 'production' && productionWidget != null) {
    return productionWidget;
  } else {
    return Container();
  }
}

Response mockResponse(Map data) =>
    Response(body: data, bodyString: jsonEncode(data), statusCode: 200);
