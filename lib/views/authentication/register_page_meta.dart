


/*

import 'package:authentication/views/register_page/register_actions_controller.dart';
import 'package:authentication/views/register_page/register_page_meta.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:request_states/requests/state_response.dart';
import 'package:request_states/caller/arguments/free_form_argument_caller.dart';

class UniCreditRegisterMeta extends RegisterPageMeta {
  const UniCreditRegisterMeta();
  @override
  afterRegister(BuildContext context) {
  }

  @override
  RegisterResources getResources() {
    return UniCreditRegisterResources();
  }

}

class UniCreditRegisterResources extends RegisterResources {
  @override
  Future<bool> checkCpfExists(Map<String, dynamic> info) async {
    return false;
  }

  @override
  Future<bool> checkEmailExists(Map<String, dynamic> info) async {
    return false;
  }

  @override
  Future<StateResponse> getAddressInformation(String cep) async {
    return StateResponse.success();
  }

  @override
  Future<StateResponse> onRegister(FreeFormArgumentCaller argumentCaller) {
    // TODO: implement onRegister
    throw UnimplementedError();
  }

}*/