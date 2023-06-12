import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:framework/atech/models/session.dart';
import 'package:framework/atech/requests/backend_response.dart';
import 'package:framework/models/extensions/for_response.dart';
import 'package:framework/requests/app_dio.dart';
import 'package:framework/requests/caller/arguments/argument_caller.dart';
import 'package:framework/requests/caller/arguments/free_form_argument_caller.dart';
import 'package:framework/requests/caller/arguments/list_argument_caller.dart';
import 'package:framework/requests/caller/request_caller.dart';

import '../../requests/caller/response_request_caller.dart';

class LoginRequests {
  static Dio dio = AppRequestDio();

  static Future<BackendResponse> _attemptLogin(
      FreeFormArgumentCaller args) async {
    String path = 'login';

    Response response = await dio.post(path, data: args.args);

    try {
      response.data = jsonDecode(response.data);
      Session.info = response.data;
    } catch (err) {
      return BackendResponse(response);
    }

    return BackendResponse(response);
  }

  static ResponseRequestCaller<FreeFormArgumentCaller> attemptLogin =
      ResponseRequestCaller(
    _attemptLogin,
  );

  static Future<BackendResponse> _confirmForgetPassword(args) async {
    //await Future.delayed(Duration(seconds: 2));

    String path = 'forget-password';
    Response response = await dio.post(path);

    //response.data = jsonDecode(response.data);

    return BackendResponse(response);
  }

  static ResponseRequestCaller<FreeFormArgumentCaller> confirmForgetPassword =
      ResponseRequestCaller(_confirmForgetPassword);
}
