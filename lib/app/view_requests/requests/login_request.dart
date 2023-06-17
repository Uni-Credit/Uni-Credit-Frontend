import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../requests/app_dio.dart';
import '../../../requests/backend_request.dart';
import '../../../requests/caller/arguments/free_form_argument_caller.dart';
import '../../../requests/caller/response_request_caller.dart';
import '../request_paths.dart';


class LoginRequests {
  static Dio dio = AppRequestDio();

  static ResponseRequestCaller<FreeFormArgumentCaller> attemptLogin =
      ResponseRequestCaller(
        BackendRequest.call(dio: dio, onPath: RequestPaths.loginPath, withMethod: 'POST',
        extractArgData: (args) => args.args,
        andThenDo: (Response response){
          response.data = jsonDecode(response.data);
        }
        )
  );


}
