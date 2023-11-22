import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:framework/models/enums/http_method.dart';
import 'package:framework/requests/app_dio.dart';
import 'package:framework/requests/backend_request.dart';
import 'package:framework/requests/caller/arguments/free_form_argument_caller.dart';
import 'package:framework/requests/caller/response_request_caller.dart';
import '../request_paths.dart';


class LoginRequests {
  static Dio dio = AppRequestDio();

  static ResponseRequestCaller<FreeFormArgumentCaller> attemptLogin =
      ResponseRequestCaller(
        BackendRequest.call(dio: dio, onPath: RequestPaths.loginPath,
            withMethod: HttpMethod.post,
        extractArgData: (args) => args.args,
        andThenDo: (Response response){
          response.data = jsonDecode(response.data);
        }
        )
  );


}
