


import 'package:dio/dio.dart';
import 'package:framework/requests/backend_response.dart';
import 'package:uni_credit/views/login_page/data/interactors/login_interactor.dart';

import '../models/user_credentials.dart';
class MockLoginInteractor extends LoginFormInteractor {
  @override
  Future<BackendResponse> loginUserCredentials(UserCredentials userCredentials) async {


    bool isSuccess = userCredentials.userId == 'aaa@gmail.com';

    return BackendResponse(Response(
      data: {
        "message": isSuccess ? null : "Email ou Senha Errados"
      },
      requestOptions: RequestOptions(), 
      statusCode: isSuccess ? 200 : 400,
    ));

  }
}