




import 'package:authentication/views/register_page/register_actions_controller.dart';
import 'package:authentication/views/register_page/register_page_meta.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:framework/requests/backend_response.dart';
import 'package:framework/requests/caller/arguments/free_form_argument_caller.dart';

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
  Future<BackendResponse> getAddressInformation(String cep) async {
    return BackendResponse.success();
  }

  @override
  Future<BackendResponse> onRegister(FreeFormArgumentCaller argumentCaller) {
    // TODO: implement onRegister
    throw UnimplementedError();
  }

}