import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/atech/models/language_read.dart';
import 'package:framework/atech/views/login/layouts/login_view_layout.dart';
import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';
import 'package:framework/shared_widgets/form_components/linked_text_input.dart';
import 'package:framework/shared_widgets/form_components/password_input.dart';
import 'package:framework/shared_widgets/form_components/validations.dart';
import 'package:framework/shared_widgets/widgets/highlighted_text.dart';

class LoginForm extends LoginViewBodyLayout {
  final FormValidatorUtility formUtility;
  final Function()? onForgetPasswordClick;
  final Widget? appending;

  const LoginForm(
      {Key? key,
      this.appending,
      this.onForgetPasswordClick,
      required this.formUtility})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        EmailInput(formUtility: formUtility),
        Container(
          height: 40,
        ),
        PasswordInput(
            formUtility: formUtility,
            label: LR.of(context).insertAction + " " + LR.of(context).password,
            validation: Validations.override(
                Validations.password(checkRegex: false, minLength: 3), '')),
        HighlightedText(
            onPressed: onForgetPasswordClick ?? () {},
            display: LR.of(context).forgotPassword),
        appending ?? Container()
      ],
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required this.formUtility,
  });

  final FormValidatorUtility formUtility;

  @override
  Widget build(BuildContext context) {
    return LinkedTextInput(
        formUtility: formUtility,
        name: 'email',
        displayName: LR.of(context).insertAction + ' email',
        validator: Validations.override(
            Validations.email, LR.of(context).invalidEmail));
  }
}
