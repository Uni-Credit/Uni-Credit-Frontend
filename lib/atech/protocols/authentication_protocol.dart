import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/atech/models/session.dart';
import 'package:framework/atech/protocols/device_protocol.dart';
import 'package:framework/atech/requests/backend_response.dart';
import 'package:framework/models/extensions/for_response.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';

import '../../requests/caller/arguments/free_form_argument_caller.dart';
import '../../requests/request_process.dart';
import '../models/patient/patient_contact.dart';
import '../requests/login_request.dart';

class AuthenticationProtocol {
  // Call with context to navigate to dashboard-page,
  // Call with formController to have an error message in the email field
  static attemptLogin(
      {required FreeFormArgumentCaller arguments,
      required RequestStatusActionMapper<BackendResponse>? actionMapper,
      required FormValidationController? formControllerForErrorDisplay,
      BuildContext? contextForSuccessNavigation}) async {
    BackendResponse response =
        await LoginRequests.attemptLogin(argument: arguments);

    debugPrint(response.status.toString());
    if (response.positiveStatus) {
      // case of success
      debugPrint("success status");
      debugPrint(response.data.runtimeType.toString());
      debugPrint(response.data.toString());
      actionMapper?.mapAction(status: RequestStatus.success, data: response);

      Session.info = response.data;

      bool useDefaultAction = contextForSuccessNavigation != null &&
          (actionMapper == null ||
              !actionMapper.hasActionOf(status: RequestStatus.success));
      if (useDefaultAction) {
        contextForSuccessNavigation.router.pushNamed('/dashboard-page');
      }

      return;
    }

    debugPrint("failed status");

    debugPrint(response.data.toString());
    String message = response.getErrorReport(
        ifNoneFound: 'Erro desconhecido no login! Contate um administrador!',
        expectedEntries: ['error', "message"]);

    formControllerForErrorDisplay
        ?.mapResponseErrors({PatientContact.emailKey: message});

    actionMapper?.mapAction(status: RequestStatus.error, data: response);
  }
}
