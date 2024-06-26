import 'package:dio/dio.dart';
import 'package:uni_credit/models/enums/http_method.dart';

extension DioExtension on Dio {
  callRequest({
    required String path,
    required HttpMethod method,
  }) {
    return fetch(RequestOptions(path: path, method: method.string()));
  }
}
