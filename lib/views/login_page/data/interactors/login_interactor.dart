


import 'package:framework/requests/backend_response.dart';
import '../models/user_credentials.dart';

abstract class LoginFormInteractor {

  Future<BackendResponse> loginUserCredentials(UserCredentials userCredentials);
}