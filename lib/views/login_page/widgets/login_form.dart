import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_components/form_components/form_controller_utility.dart';
import 'package:form_components/form_components/input_spacer.dart';
import 'package:form_components/form_components/linked_text_input.dart';
import 'package:form_components/form_components/password_input.dart';
import 'package:form_components/form_components/validations.dart';
import 'package:form_components/form_components/validations.dart';
import 'package:uni_credit/models/unicredit_validations.dart';
import 'package:uni_credit/views/login_page/bloc/login_form_bloc.dart';
import 'package:uni_credit/views/login_page/bloc/login_form_states.dart';


class LoginForm extends StatelessWidget {
  final FormValidatorUtility formUtility;
  final Function()? onForgetPasswordClick;
  final Widget? appending;

  const LoginForm({Key? key,
    this.appending,
    this.onForgetPasswordClick,
    required this.formUtility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {

        formUtility.fieldsEnabled = state is! LoginLoading;
        return Column(
          children: [
            LinkedTextInput(
                formUtility: formUtility,
                name: 'user_id',
                displayName: 'Matrícula',
                validator: UniCreditValidations.idEstudante()),
            InputSpacer(),
            PasswordInput(
                formUtility: formUtility,
                label: 'Senha do Sistema',
                inputStyle: LinkedTextInputStyle(
                  inputAction: TextInputAction.done,
                  whenSubmitted: (_) {
                    //onConfirm();
                  },


                ),
                validation: Validations.override(
                    Validations.password(checkRegex: false, minLength: 3), '')),
            appending ?? Container()
          ],
        );
      },
    );
  }
}

