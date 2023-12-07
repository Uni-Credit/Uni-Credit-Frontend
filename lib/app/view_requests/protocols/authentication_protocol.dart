import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:form_components/form_components/validation_form_controller.dart';
import 'package:request_states/process/request_process.dart';
import 'package:request_states/requests/caller/arguments/free_form_argument_caller.dart';
import 'package:request_states/requests/state_response.dart';

import '../requests/login_request.dart';


class AuthenticationProtocol {
  // Call with context to navigate to dashboard-page,
  // Call with formController to have an error message in the email field
  static attemptLogin(
      {required FreeFormArgumentCaller arguments,
        required RequestStatusActionMapper<StateResponse>? actionMapper,
        required FormValidationController? formControllerForErrorDisplay,
        required String emailKey,
        BuildContext? contextForSuccessNavigation}) async {
    StateResponse<Map<String, dynamic>> response =
    await LoginRequests.attemptLogin(argument: arguments);

    debugPrint(response.statusCode.toString());
    if (response.positiveStatus) {
      // case of success
      _saveLoginIntoSession(response, actionMapper);



      bool useDefaultAction = contextForSuccessNavigation != null &&
          (actionMapper == null ||
              !actionMapper.hasActionOf(status: RequestStatus.success));
      if (useDefaultAction) {
        contextForSuccessNavigation.router.pushNamed('/dashboard-page');
      }

      actionMapper?.mapAction(status: RequestStatus.success, data: response);
      return;
    }

    _displayLoginError(response, formControllerForErrorDisplay,
     emailKey
    );
    actionMapper?.mapAction(status: RequestStatus.error, data: response);
  }

  static void _displayLoginError(StateResponse<Map<String, dynamic>> response,

      FormValidationController? formControllerForErrorDisplay,
      String emailKey) {
    debugPrint("failed status");
    debugPrint(response.data.toString());
    String message = response.getErrorReport(
        ifNoneFound: 'Erro desconhecido no login! Contate um administrador!',
        expectedEntries: ['error', "message"]);

    formControllerForErrorDisplay
        ?.mapResponseErrors({emailKey: message});
  }

  static void _saveLoginIntoSession(StateResponse response, RequestStatusActionMapper<StateResponse>? actionMapper) {
    debugPrint("success status");
    debugPrint(response.data.runtimeType.toString());
    debugPrint(response.data.toString());

    //Session.setInfo(response.data);
  }
}
