import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../../requests/app_dio.dart';
import '../../requests/caller/arguments/free_form_argument_caller.dart';
import '../../requests/caller/response_request_caller.dart';
import 'backend_response.dart';

class RegisterRequests {
  static Dio dio = AppRequestDio();

  static Future<BackendResponse> _registerUser(args) async {
    //await Future.delayed(Duration(seconds: 2));

    debugPrint("register user");
    debugPrint("data: ");
    debugPrint(args.args.toString());
    String path = 'register';
    Response response = await dio.post(path, data: args.args);

    //response.data = jsonDecode(response.data);

    return BackendResponse(response);
  }

  static ResponseRequestCaller<FreeFormArgumentCaller> registerUser =
      ResponseRequestCaller(_registerUser);
}
