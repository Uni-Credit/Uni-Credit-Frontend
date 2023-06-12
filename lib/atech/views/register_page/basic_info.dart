import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/atech/enums/user_type.dart';
import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';

import '../../../shared_widgets/form_components/auto_complete_field.dart';
import '../../../shared_widgets/form_components/linked_text_input.dart';
import '../../../shared_widgets/form_components/password_input.dart';
import '../../../shared_widgets/form_components/validations.dart';

class BasicInfo extends StatelessWidget {
  final FormValidatorUtility formUtility;
  const BasicInfo({Key? key, required this.formUtility}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return formUtility.InputLine(
      direction: Axis.vertical,
      itemSpacing:
          const EdgeInsets.only(top: LinkedTextInput.defaultTopInputSpacing),
      children: [
        LinkedTextInput(
            formUtility: formUtility,
            name: "firstName", // nome de referência no map
            displayName: "Nome",
            autoFocus: true),
        LinkedTextInput(
          formUtility: formUtility,
          name: "surname", // nome de referência no map
          displayName: "Sobrenome",
        ),
        LinkedTextInput(
          formUtility: formUtility,
          name: "socialName", // nome de referência no map
          displayName: "Nome Social",
        ),
        LinkedTextInput(
          formUtility: formUtility,
          name: "email", // nome de referência no map
          displayName: "Email",
          validator: Validations.email,
        ),
        PasswordInput(
          formUtility: formUtility,
          usingInputForRegistration: true,
        ),
      ],
    );
  }
}
