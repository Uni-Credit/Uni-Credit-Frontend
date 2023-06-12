import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/requests/app_dio.dart';

class AddressRequests {
  static Future<Response> getAddressInformation({required String cep}) async {
    Dio dio = AppRequestDio(url: "", usesNgrok: false, allowOrigin: false);

    String path = "https://cep.awesomeapi.com.br/json/$cep";
    debugPrint(path);

    Response response = await dio.get(
      path,
    );
    return response;
  }
}
