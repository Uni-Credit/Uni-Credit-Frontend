

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class BackendResponse {
  late int statusCode;
  late dynamic message;
  late dynamic data;
  BackendResponse(Response response) {
    debugPrint("backend response");
    debugPrint(response.data.toString());
    debugPrint(response.data.runtimeType.toString());

    response.data ??= {};

    if (response.data is String) {
      try {
        response.data = jsonDecode(response.data);
      } catch (err) {
        statusCode = 404;
        message = response.data;
        data = {};
        return;
      }
    }

    int codeIfFailed = response.statusCode ?? 404;
    try {
      statusCode = int.tryParse(
          (response.data?["status"] ?? response.data?["statusCode"])
              .toString()) ??
          codeIfFailed;
    } catch (err) {
      statusCode = codeIfFailed;
    }

    debugPrint("inicialized status as " + statusCode.toString());
    debugPrint(response.data.toString());

    if (response.data is Map) {
      message = response.data?["message"] ?? "";
    }

    debugPrint("inicialized message");

    if (response.data is Map) {
      data = response.data?["response"] ?? response.data;
    } else {
      data = response.data;
    }

    debugPrint("inicialized data");
  }

  bool get positiveStatus => statusCode < 299;

  String getErrorReport(
      {required String ifNoneFound, required List<String> expectedEntries}) {
    if (data is! Map) {
      return ifNoneFound;
    }

    for (String entryKey in expectedEntries) {
      if ((data as Map).containsKey(entryKey)) {
        return data[entryKey];
      }
    }

    return ifNoneFound;
  }
}

