


import 'package:authentication/views/forgot_password_page/forgot_password_meta.dart';
import 'package:authentication/views/forgot_password_page/forgot_password_resource.dart';
import 'package:framework/requests/backend_response.dart';


class UniCreditForgotPasswordPageMeta extends ForgotPasswordPageMeta {
  const UniCreditForgotPasswordPageMeta();
  @override
  ForgotPasswordResources resources() {
     return UniCreditForgotPasswordResources();
  }

}

class UniCreditForgotPasswordResources extends ForgotPasswordResources {
  @override
  Future<BackendResponse> onForgotPassword(Map<String, dynamic> inputField) {
    // TODO: implement onForgotPassword
    throw UnimplementedError();
  }

}