import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:framework/requests/caller/arguments/free_form_argument_caller.dart';
import 'package:framework/requests/request_process.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';
import 'package:framework/shared_widgets/form_components/input_spacer.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';
import 'package:framework/shared_widgets/graphical_item/app_logo.dart';
import 'package:framework/shared_widgets/item_sizes.dart';
import 'package:uni_credit/routes/router.gr.dart';
import 'package:uni_credit/views/login_page/bloc/login_form_bloc.dart';
import 'package:uni_credit/views/login_page/bloc/login_form_events.dart';
import 'package:uni_credit/views/login_page/bloc/login_form_states.dart';
import 'package:uni_credit/views/login_page/widgets/login_action_buttons.dart';
import 'package:uni_credit/views/login_page/widgets/login_confirm_button.dart';
import 'package:uni_credit/views/login_page/widgets/login_form.dart';
import '../../app/view_requests/protocols/authentication_protocol.dart';

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

    formValidationController.onDataChange(() {
      context.read<LoginFormBloc>().add(LoginFormInteracted(
          formData: formValidationController.readFields(),
          valid: formValidationController.getValidationState()
      ));
    });
    formValidationController.onValidationChange((valid) {
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    FormValidatorUtility formUtility = FormValidatorUtility(
        formValidationController,
        defaultValidateMode: AutovalidateMode.onUserInteraction);

    return Container(
      width: 400,
      child: BlocListener<LoginFormBloc, LoginFormState>(
        listener: (context, state) async {

          LoginFormBloc formBloc = context.read<LoginFormBloc>();
          if (state is LoginSuccess) {

            await Future.delayed(Duration(milliseconds: 200));
            formBloc.add(EndLogin(confirmedUserCredentials: state.userData));
            return;
          }

          if(state is LoginFailure ) {
            // Logic for handling login failure
            final error = state.error;
            formValidationController.mapResponseErrors(
                {"user_id": error});
          }

          if(state is LoginBackendFailure ) {
            // Logic for handling login failure
            final error = state.error;
            formValidationController.mapResponseErrors(
                {"user_id": error});
          }

          if(state is LoginEnded) {

            context.router.push(Dashboard());
          }
        },
        child: Column(

          children: [
            // InputSpacer(),
            AppLogo(),
            InputSpacer(),
            LoginForm(formUtility: formUtility,
            ),
            InputSpacer(),
            UnicreditLoginActionButtons(formUtility: formUtility),
          ],
        ),
      ),
    );
  }
}
