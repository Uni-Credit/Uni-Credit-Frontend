import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'form_controller_utility.dart';

class LinkedTextInput extends StatefulWidget {
  final FormValidatorUtility formUtility;
  final String name;
  final Widget? suffixIcon;

  int? flex;
  bool overrideMultiplier;
  bool obscure;
  String? displayName;
  InputDecoration? decoration;
  bool usesDefaultPadding;
  String? Function(String?)? validator;
  List<TextInputFormatter>? formatters;

  AutovalidateMode? autoValidateMode;
  bool active;
  bool enabled;
  bool hasEnabler;
  bool invertEnabler;
  int? maxLength;
  String? initialValue;
  TextInputType? keyboardType;
  int? minLines;
  int? maxLines;
  FocusNode? focusNode;
  TextEditingController? controller;
  double? inputWidth;
  bool? displaysError;
  bool usesDefaultValidator;

  Function(String)? onFieldSubmitted;

  static const double defaultTopInputSpacing = 24;

  LinkedTextInput({
    Key? key,
    required this.formUtility,
    required this.name,
    this.flex,
    this.overrideMultiplier = false,
    this.obscure = false,
    this.displayName,
    this.decoration,
    this.suffixIcon,
    this.validator,
    this.formatters,
    this.autoValidateMode,
    this.usesDefaultPadding = true,
    this.active = true,
    this.enabled = true,
    this.hasEnabler = false,
    this.invertEnabler = false,
    this.maxLength,
    this.initialValue,
    this.keyboardType,
    this.minLines,
    this.maxLines,
    this.focusNode,
    this.controller,
    this.inputWidth,
    this.displaysError,
    this.onFieldSubmitted,
    this.usesDefaultValidator = true,
    this.autoFocus = false,
  }) : super(key: key);

  final bool autoFocus;

  @override
  State<LinkedTextInput> createState() => _LinkedTextInputState();
}

class _LinkedTextInputState extends State<LinkedTextInput> {
  @override
  void initState() {
    super.initState();

    if (widget.hasEnabler) {
      setHasListener();
    }
/*
    widget.formUtility.formController.onDataChange(() {
      setState(() {

      });
    }, targetData: widget.name);*/
  }

  setHasListener() {
    widget.formUtility.formController
        .onDataChange(receiveHasInput, targetData: "has_${widget.name}");
    receiveHasInput();
  }

  @override
  dispose() {
    super.dispose();

    widget.formUtility.formController.targetDataListeners["has_${widget.name}"]
        ?.remove(receiveHasInput);
  }

  receiveHasInput() {
    dynamic valueIsEnabled =
        widget.formUtility.formController.readField("has_${widget.name}");

    setState(() {
      widget.enabled = valueIsEnabled == ""
          ? widget.enabled
          : (widget.invertEnabler ? !valueIsEnabled : valueIsEnabled);
    });
  }

  @override
  Widget build(BuildContext context) {
    /*if(inputs.containsKey(name)) {
      return inputs[name]!;
    }*/

    widget.flex ??= widget.formUtility.defaultFlex;

    if (!widget.active) {
      return Container();
    }

    if (widget.formUtility.storeNames) {
      widget.formUtility.names.add(widget.name);
    }

    widget.displayName ??=
        "${widget.name[0].toUpperCase()}${widget.name.substring(1)}";

    widget.decoration = widget.formUtility.linkedDecoration(
      widget.decoration,
      displayName: widget.displayName,
      name: widget.name,
      usesDefaultPadding: widget.usesDefaultPadding,
    );

    if (widget.suffixIcon != null) {
      widget.decoration =
          widget.decoration!.copyWith(suffixIcon: widget.suffixIcon);
    }

    widget.autoValidateMode ??= widget.formUtility.defaultValidateMode;
    if (widget.controller != null) {
      widget.formUtility.formController.setController(
          widget.name, widget.controller, widget.validator,
          validateMode: widget.autoValidateMode);
    }
    String? Function(String? v)? validatorFunction;

    if (widget.validator == null && widget.usesDefaultValidator) {
      widget.validator = widget.formUtility.defaultValidator;
    }

    if (widget.validator != null) {
      widget.validator = widget.formUtility.formController.getLinkedValidator(
          widget.formUtility
              .getValidator(widget.validator, widget.displaysError),
          widget.name);

      if (widget.formUtility.wrapperFunction != null) {
        validatorFunction = (String? v) {
          return widget.formUtility.wrapperFunction!(v, widget.validator!(v));
        };
      } else {
        validatorFunction = widget.validator!;
      }
    }

    Widget input = TextFormField(
      controller: widget.controller ??
          widget.formUtility.formController.getLinkedController(
              validatorFunction, widget.name,
              initialValue: widget.initialValue),
      autovalidateMode: widget.autoValidateMode,
      validator: validatorFunction,
      decoration: widget.decoration,
      obscureText: widget.obscure,
      enabled: widget.formUtility.fieldsEnabled && widget.enabled,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      maxLines: widget.maxLines ?? 1,
      keyboardType: widget.keyboardType,
      focusNode: widget.focusNode,
      inputFormatters: widget.formatters,

//      readOnly: true,

      onFieldSubmitted: widget.onFieldSubmitted,
    );

    widget.inputWidth ??= widget.formUtility.defaultInputWidth;

    if (widget.inputWidth != null) {
      input = SizedBox(
        width: widget.inputWidth,
        child: input,
      );
    }

    input = LinkedFlex(
        flex: widget.flex,
        overrideMultiplier: widget.overrideMultiplier,
        formUtility: widget.formUtility,
        child: input);

    return input;
  }
}
