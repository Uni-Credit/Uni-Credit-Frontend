import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../constants.dart';

_parseAndDecode(String response) {
  return jsonDecode(response);
}

parseJson(String text) {
  return compute(_parseAndDecode, text);
}

/*
class AppRequestDio with DioMixin implements Dio{

  AppRequestDio() {
    options = Dio().options.copyWith();

    options.baseUrl = baseUrl;

    options.responseType = ResponseType.json;
    interceptors.addAll(KiwiContainer().resolve<List<Interceptor>>());
    options.headers['Content-Type'] = "application/json; charset=UTF-8";
    (transformer as DefaultTransformer).jsonDecodeCallback = parseJson;
  }
}*/

Dio AppRequestDio({url, contentType, allowOrigin = true, usesNgrok = true}) {
  Dio dio = Dio();
  dio.options.baseUrl = (url ??
      Constants.baseUrl); /*
  dio.options.responseType = ResponseType.json;*/
  dio.options.headers['Content-Type'] =
      contentType ?? "application/json; charset=UTF-8";
  if (allowOrigin) {
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
  }

  if (usesNgrok) {
    dio.options.headers['ngrok-skip-browser-warning'] = "*****";
  }

  (dio.transformer as DefaultTransformer).jsonDecodeCallback = (String text) {
    return text;
  };

  return dio;
}

Future<Response> callRequest(Future<Response> request) async {
  try {
    Response response = await request;
    debugPrint(response.data.toString());
    debugPrint(response.statusCode.toString());

    if (response.data != "" && response.data != null) {
      response.data = (jsonDecode(response.data));
    }
    return response;
  } catch (err) {
    if (err is DioError) {
      debugPrint("err dio: " + err.toString());

      if (err.response != null) {
        debugPrint("err response isnt null");
        debugPrint(err.response!.data.toString());
        debugPrint(err.response!.statusCode.toString());

        err.response!.data = (jsonDecode(err.response!.data));

        return err.response!;
      }

      debugPrint("ERR RESPONSE WAS NULL!!!");
      debugPrint(err.toString());
      return Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: ""),
      );
    }

    rethrow;
  }
}
