

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/shared_widgets/form_components/input_spacer.dart';

import '../../../shared_widgets/form_components/form_controller_utility.dart';
import '../../../shared_widgets/form_components/linked_text_input.dart';
import '../../../shared_widgets/form_components/password_input.dart';
import '../../../shared_widgets/form_components/validations.dart';


class LoginForm extends StatelessWidget {
  final FormValidatorUtility formUtility;
  final Function()? onForgetPasswordClick;
  final Widget? appending;
  final Function() onConfirm;

  const LoginForm(
      {Key? key,
        this.appending,
        required this.onConfirm,
        this.onForgetPasswordClick,
        required this.formUtility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinkedTextInput(
            formUtility: formUtility,
            name: 'student_id',
            displayName: 'Matrícula',
            validator: Validations.idDeEstudante),
        InputSpacer(),
        PasswordInput(
            formUtility: formUtility,
            label: 'Senha do Sistema',
            inputStyle: LinkedTextInputStyle(
              inputAction: TextInputAction.done,
              whenSubmitted: (_){
                onConfirm();
              },

              
            ),
            validation: Validations.override(
                Validations.password(checkRegex: false, minLength: 3), '')),
        appending ?? Container()
      ],
    );
  }
}

