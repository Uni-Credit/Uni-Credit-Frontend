import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/atech/requests/backend_response.dart';
import 'package:framework/requests/caller/arguments/list_argument_caller.dart';
import 'package:framework/requests/caller/request_caller.dart';

import 'arguments/argument_caller.dart';

class ResponseRequestCaller<G extends ArgumentCaller>
    extends RequestCaller<G, BackendResponse> {
  ResponseRequestCaller(super.request, {super.defaultArgument});

  @override
  runRequest(argument) async {
    debugPrint('overriden run request');
    try {
      return await super.runRequest(argument);
    } on DioError catch (e) {
      debugPrint('received a dio error');
      if (e.response != null) {
        return BackendResponse(e.response!);
      }
      rethrow;
    }
  }
}
