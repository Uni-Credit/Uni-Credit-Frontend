



import 'package:dio/dio.dart';
import 'package:framework/models/enums/http_method.dart';
import 'package:framework/requests/app_dio.dart';
import 'package:framework/requests/backend_request.dart';
import 'package:framework/requests/backend_response.dart';
import 'package:framework/requests/caller/response_request_caller.dart';
import 'package:uni_credit/views/login_page/data/interactors/login_interactor.dart';
import 'package:uni_credit/views/login_page/data/models/user_credentials.dart';

class APILoginFormInteractor extends LoginFormInteractor {
  @override
  Future<BackendResponse> loginUserCredentials(UserCredentials userCredentials)
  async {

    await Future.delayed(Duration(seconds: 1));

    return await ResponseRequestCaller(
          BackendRequest.call(dio: AppRequestDio(
            url: "http://localhost:3000",
          ), onPath: "/auth/login",
            withMethod: HttpMethod.post,
            extractArgData: (UserCredentials arg){
              return arg.toJson();
            })
    ).call(argument: userCredentials);


  }

}