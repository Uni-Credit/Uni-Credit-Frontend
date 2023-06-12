import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:framework/atech/models/device.dart';
import 'package:framework/atech/models/patient.dart';
import 'package:framework/atech/models/patient_data.dart';
import 'package:framework/atech/models/patient_metrics.dart';
import 'package:framework/models/enums/http_method.dart';
import 'package:framework/models/extensions/for_dio.dart';
import 'package:framework/models/extensions/for_response.dart';
import 'package:framework/requests/app_dio.dart';
import 'package:framework/requests/caller/arguments/list_argument_caller.dart';
import 'package:framework/requests/caller/request_caller.dart';

import '../../requests/caller/response_request_caller.dart';
import '../enums/enum_helpers.dart';
import 'backend_response.dart';

class DeviceRequests {
  static Dio appDio = AppRequestDio();

  static Future<BackendResponse> _loadDevicesVisibleToUser(
      ListArgumentCaller listArgumentCaller) async {
    String loadDevicesPath = 'devices';

    //Response response = await appDio.callRequest(path: loadDevicesPath, method: HttpMethod.get);
    Response response = await appDio.get(loadDevicesPath);

    debugPrint("response status device : " + response.statusCode.toString());
    DeviceRequestsConverter.convertDeviceList(response: response);

    return BackendResponse(response);
  }

  static ResponseRequestCaller<ListArgumentCaller> loadDevicesVisibleToUser =
      ResponseRequestCaller(_loadDevicesVisibleToUser,
          defaultArgument: ListArgumentCaller());
}

class DeviceRequestsConverter {
  static convertDeviceList({required Response response}) {
    if (!response.positiveStatus) {
      debugPrint("convert impossible");
      return;
    }

    response.data = jsonDecode(response.data);

    debugPrint("reading response data: ");
    List<Device> devices = [];
    for (Map<String, dynamic> item in response.data) {
      devices.add(Device.fromMap(item));
    }

    response.data = devices;

    debugPrint("response set to list");
  }
}
