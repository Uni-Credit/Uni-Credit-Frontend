import 'package:flutter/material.dart';
import 'package:framework/atech/defaults/default_appbar.dart';
import 'package:framework/atech/enums/user_type.dart';
import 'package:framework/atech/requests/register_requests.dart';
import 'package:framework/atech/views/register_page/widgets/register_form.dart';
import 'package:framework/models/extensions/for_widget.dart';
import 'package:framework/requests/caller/arguments/free_form_argument_caller.dart';
import 'package:framework/requests/request_process.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/form_components/dropdown_field.dart';

import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';
import 'package:framework/shared_widgets/form_components/validations.dart';
import 'package:framework/shared_widgets/popups/response_popup.dart';

import '../../../shared_widgets/form_components/linked_text_input.dart';
import '../../../shared_widgets/form_components/template_dropdown.dart';

class RegisterPage extends StatefulWidget {
  final UserType? userType;
  static UserType? defaultUserType;

  const RegisterPage({Key? key, this.userType = UserType.defaultValue})
      : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FormValidationController formController = FormValidationController();

  UserType? userType;

  @override
  void initState() {
    super.initState();

    userType = widget.userType;

    if (userType == UserType.defaultValue) {
      userType = RegisterPage.defaultUserType;
    }

    formController.onValidationChange((isValid) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      backgroundColor: Colors.white,
      //appbarConfig: AppbarConfiguration(content: DefaultAppbar(display: 'Registrar'),),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: const Text(
              'Cadastrar Dados',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 30,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Visibility(
            visible: widget.userType == null,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: DropdownField(
                  onChanged: (value) {
                    setState(() {
                      userType = value;
                    });
                  },
                  items: [
                    (UserType.familiar),
                    (UserType.institutionAdministrator),
                    (UserType.healthProfessional),
                  ]
                      .map((e) => DropdownItem(
                          value: e, displayValue: e.string(context)))
                      .toList()),
            ),
          ),
          RegisterForm(
            formController: formController,
            userType: userType,
          ),
          CardButtonV1(
            title: CardTextContent(content: "Enviar"),
            onPress: () {
              debugPrint("enviado");

              Map<String, dynamic> data = formController.readFields();
              data["role"] = userType!.toKey();

              ResponsePopup(
                requestProcess: RequestProcess(
                    RegisterRequests.registerUser(
                        argument: FreeFormArgumentCaller(args: data)),
                    StatusResolver.requestStatusResolver),
              ).showDialogWithWidget(context);
            },
            pressEnabled: formController.getValidationState(),
            cardIntention: CardIntention.action,
          ),

          /*CardButtonV1(
            style: ElevatedButton.styleFrom(
              primary: const Color(0xFF4F0410),
              onPrimary: Colors.white,
              minimumSize: const Size(130, 40),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Voltar',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}

class CadastroModel {
  late TextEditingController textController1;
  late TextEditingController textController2;
  late TextEditingController textController3;

  void dispose() {
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
  }

  void save(BuildContext context) {
    // Lógica de salvamento dos dados
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Dados Salvos'),
        content: const Text('Os dados foram salvos com sucesso.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  String? textController1Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? textController2Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  String? textController3Validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }
}

CadastroModel createModel(
    BuildContext context, CadastroModel Function() model) {
  return model();
}
