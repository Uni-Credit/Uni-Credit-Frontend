




/*
login_page_meta.dart';
login_resources.dart';
login_structure.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:framework/models/enums/visual_aid.dart';
import 'package:framework/requests/backend_response.dart';
import 'package:framework/requests/caller/arguments/free_form_argument_caller.dart';

import '../login_page/widgets/login_action_buttons.dart';

class UniCreditLoginPageMeta extends LoginPageMeta {
  const UniCreditLoginPageMeta();

  @override
  Future afterLogin(BuildContext context) async {

  }

  @override
  LoginResources resource() {
    return UniCreditLoginResources();
  }

  @override
  LoginStructure structure() {
    return LoginStructure(
      visualId: VisualAid.logo,
      actionButton:   (onLogin,
          formUtility, ) =>
          UnicreditLoginActionButtons(onLogin: onLogin, formUtility: formUtility)
    );
  }
}

class UniCreditLoginResources extends LoginResources {
  @override
  Future<BackendResponse> onLogin(FreeFormArgumentCaller argumentCaller) async {
    return BackendResponse.success();
  }

}*/