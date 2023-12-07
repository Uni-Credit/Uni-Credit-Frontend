



import 'package:request_states/main/app_dio.dart';
import 'package:request_states/requests/backend_request.dart';
import 'package:request_states/requests/caller/response_request_caller.dart';
import 'package:request_states/requests/state_response.dart';
import 'package:uni_credit/views/login_page/data/interactors/login_interactor.dart';
import 'package:uni_credit/views/login_page/data/models/user_credentials.dart';

class APILoginFormInteractor extends LoginFormInteractor {
  @override
  Future<StateResponse> loginUserCredentials(UserCredentials userCredentials)
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