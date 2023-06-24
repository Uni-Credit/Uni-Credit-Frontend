import 'package:flutter/material.dart';
import 'package:uni_credit/shared_widgets/form_components/linked_text_input.dart';
import 'package:uni_credit/shared_widgets/form_components/validations.dart';

import '../../../../shared_widgets/form_components/form_controller_utility.dart';
import '../../../../shared_widgets/form_components/linked_input_icon.dart';
import '../../../../shared_widgets/form_components/password_input_manager.dart';
import 'input_spacer.dart';

class PasswordInput extends StatefulWidget {
  final FormValidatorUtility formUtility;
  final String? label;
  final LinkedTextInputStyle? inputStyle;
  final bool usingInputForRegistration;
  final String? Function(String? v)? validation;
  final TextInputAction? inputAction;
  const PasswordInput(
      {this.usingInputForRegistration = false,
      this.label,
      required this.formUtility,
        this.inputAction,
        this.inputStyle,
      Key? key,
      this.validation})
      : super(key: key);

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  TextEditingController confirmPassowrdController = TextEditingController();

  FocusNode focusNode = FocusNode();

  bool passwordHasFocus = false;
  bool passwordFirstFocus = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    confirmPassowrdController.addListener(() {});

    if (widget.usingInputForRegistration) {
      focusNode.addListener(() {
        if (!focusNode.hasFocus && passwordHasFocus) {
          passwordFirstFocus = false;
          widget.formUtility.formController.updateValidationState();
          widget.formUtility.formController.updatedValidation("password");
          _formKey.currentState!.validate();
        }
        setState(() {
          passwordHasFocus = focusNode.hasFocus;
        });
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int flexValue = 1;
    double iconPadding = 8;

    return PasswordInputManager(
      inputBuilder: (bool obscuredText, passwordIcon) {
        return widget.formUtility.InputLine(children: [
          PasswordInputWidget(
            formKey: widget.usingInputForRegistration ? _formKey : null,
            widget: widget,
            focusNode: focusNode,
            flexValue: flexValue,
            passwordIcon: passwordIcon,
            obscuredText: obscuredText,
            inputStyle: widget.inputStyle
          ),
          widget.usingInputForRegistration ? InputSpacer() : Container(),
          Visibility(
            visible: widget.usingInputForRegistration,
            child: PasswordInputManager(
                inputBuilder: (bool obscuredText, passwordIcon) {
              return widget.formUtility.linkedInput(
                "confirm_password",
                flex: flexValue,
                displayName: "Repetir senha",
                autoValidateMode: AutovalidateMode.onUserInteraction,
                obscure: obscuredText,
                validator: (String? v) {
                  return v ==
                          widget.formUtility.formController
                              .readField("password")
                      ? null
                      : "As senhas não conferem";
                },
                controller: confirmPassowrdController,
              );
            }),
          )
        ]);
      },
    );
  }
}

class PasswordInputWidget extends StatelessWidget {
  final LinkedTextInputStyle? inputStyle;
  const PasswordInputWidget({
    super.key,
    required this.formKey,
    required this.widget,
    required this.obscuredText,
    required this.focusNode,
    this.flexValue,
    required this.passwordIcon, this.inputStyle,
  });

  final IconButton passwordIcon;

  final bool obscuredText;
  final GlobalKey<FormState>? formKey;
  final PasswordInput widget;
  final FocusNode focusNode;
  final int? flexValue;
  static String passwordMessageDisplay() {
    return "Crie uma senha de 8 dígitos com letras e números";
  }

  @override
  Widget build(BuildContext context) {
    Widget inputWidget = LinkedTextInput(
      inputStyle: inputStyle,
      name:
      "password",
      flex: flexValue,
      suffixIcon: passwordIcon,
       focusNode: focusNode,
      autoValidateMode: formKey == null
          ? AutovalidateMode.onUserInteraction
          : AutovalidateMode.disabled,
      validator: Validations.override(
          widget.validation ??
              Validations.password(minLength: 8, showMinLength: true),
          widget.usingInputForRegistration ? passwordMessageDisplay() : ""),
      obscure: obscuredText, formUtility: widget.formUtility,
    );

    if (formKey == null) {
      return inputWidget;
    }

    return Form(
      key: formKey!,
      child: inputWidget,
    );
  }
}
