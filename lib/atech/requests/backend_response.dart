import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class BackendResponse {
  late int status;
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
        status = 404;
        message = response.data;
        data = {};
        return;
      }
    }

    try {
      status = int.tryParse(
              (response.data?["status"] ?? response.data?["statusCode"])
                  .toString()) ??
          404;
    } catch (err) {
      status = 404;
    }

    debugPrint("inicialized status");

    debugPrint(response.data.toString());
    debugPrint(response.data["response"].toString());
    debugPrint(response.data["message"].toString());

    message = response.data["response"] ?? response.data["message"];

    debugPrint("inicialized message");

    data = response.data;

    debugPrint("inicialized response");
  }

  bool get positiveStatus => status < 299;

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
