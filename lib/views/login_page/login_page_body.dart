

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/routes/router.gr.dart';
import 'package:uni_credit/shared_widgets/widgets/title.dart';
import 'package:uni_credit/views/login_page/widgets/app_logo.dart';
import 'package:uni_credit/views/login_page/widgets/login_confirm_button.dart';
import 'package:uni_credit/views/login_page/widgets/login_form.dart';

import '../../app/view_requests/protocols/authentication_protocol.dart';
import '../../requests/caller/arguments/free_form_argument_caller.dart';
import '../../requests/request_process.dart';
import '../../shared_widgets/form_components/form_controller_utility.dart';
import '../../shared_widgets/form_components/input_spacer.dart';
import '../../shared_widgets/form_components/validation_form_controller.dart';
class LoginPageBody extends StatefulWidget {
  const LoginPageBody({super.key});

  @override
  State<LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<LoginPageBody> {
  final FormValidationController formValidationController =
  FormValidationController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    formValidationController.onValidationChange((valid) {
      setState(() {});
    });
  }

  onLogin() async {
    context.router.push(Dashboard());
    return;
    AuthenticationProtocol.attemptLogin(
        arguments:
        FreeFormArgumentCaller(args: formValidationController.readFields()),
        formControllerForErrorDisplay: formValidationController,
        contextForSuccessNavigation: context,
        actionMapper: RequestStatusActionMapper(mapper: {
          RequestStatus.error: (response) {
            setState(() {});
          },
        }), emailKey: 'email');
  }

  @override
  Widget build(BuildContext context) {

    FormValidatorUtility formUtility = FormValidatorUtility(
        formValidationController,
        defaultValidateMode: AutovalidateMode.onUserInteraction);

    return Container(
      width: 400,
      child: Column(

        children: [
          AppLogo(),
          InputSpacer(multiply: 2.0),
          LoginForm(formUtility: formUtility,
          onConfirm: onLogin,
          ),
          InputSpacer(multiply: 2,),
          LoginConfirmButton(formUtility: formUtility, onLogin: onLogin),

        ],
      ),
    );
  }
}
