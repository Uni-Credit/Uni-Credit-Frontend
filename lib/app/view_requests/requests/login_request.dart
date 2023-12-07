import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:request_states/main/app_dio.dart';
import 'package:request_states/requests/backend_request.dart';
import 'package:request_states/requests/caller/arguments/free_form_argument_caller.dart';
import 'package:request_states/requests/caller/response_request_caller.dart';
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
