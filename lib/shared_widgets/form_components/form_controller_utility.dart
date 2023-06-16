import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_credit/shared_widgets/form_components/validation_form_controller.dart';

import '../responsive/media_queries.dart';
import '../listing/flexible_listing.dart';

class FormValidatorUtility {
  int flexMultiplier = 1;

  int defaultFlex = -1;

  FormValidationController formController;

  AutovalidateMode? defaultValidateMode;

  bool storeNames;
  bool fieldsEnabled = true;

  List<String> names = [];

  FormValidatorUtility(this.formController,
      {this.storeNames = false,
      this.defaultValidateMode,
      this.defaultFlex = -1});

  EdgeInsetsGeometry? inputLinePadding;
  EdgeInsetsGeometry? inputLineItemPadding;
  EdgeInsetsGeometry? inputPadding;

  int defaultSpacer = 0;

  Axis lineDirection = Axis.horizontal;
  double? defaultInputWidth;
  MainAxisSize? defaultMainAxisSize;

  String? Function(String? value, String? functionResponse)? wrapperFunction;

  String? Function(String? v)? defaultValidator;

  bool adaptMobileColumn = false;
  //String? inputGroup;

  Widget InputLine(
      {required List<Widget> children,
      int? spacer,
      Axis? direction,
      EdgeInsetsGeometry? itemSpacing,
      bool ignoreLastSpacer = true,
      bool visible = true,
      MainAxisSize? mainAxisSize,
      usesLineSpacing = true,
      usesItemSpacing = true,
      DeviceOption<Axis>? deviceAxis}) {
    if (!visible) {
      return Container();
    }

    mainAxisSize ??= defaultMainAxisSize;
    direction ??= lineDirection;
    spacer ??= (flexMultiplier == 0 ? 0 : defaultSpacer);
    List<Widget> childrenList = [];

    deviceAxis ??= DeviceOption(
        defaultResult: direction,
        mobile: adaptMobileColumn ? Axis.vertical : direction);

    EdgeInsetsGeometry? itemPadding = itemSpacing ??
        (inputLineItemPadding != null
            ? inputLineItemPadding!.add(EdgeInsets.zero)
            : null);

    if (deviceAxis.getValue() != direction && itemPadding != null) {
      itemPadding = itemPadding.flipped;
    }

    if (usesItemSpacing &&
        (spacer != 0 ||
            itemPadding != null ||
            (direction == Axis.vertical && inputLinePadding != null))) {
      for (Widget child in children) {
        childrenList.add(child);

        if (child == children.last && ignoreLastSpacer) {
          continue;
        }

        if (child is Visibility) {
          if (!child.visible) {
            continue;
          }
        }

        EdgeInsetsGeometry? padding = itemPadding ?? inputLinePadding;

        if (padding != null &&
            (spacer == 0 || mainAxisSize == MainAxisSize.min)) {
          childrenList.add(Padding(padding: padding));
          continue;
        }

        childrenList.add(Spacer(
          flex: spacer,
        ));
      }
    } else {
      childrenList = children;
    }

    return Container(
        margin: usesLineSpacing
            ? (inputLinePadding ?? EdgeInsets.zero)
            : EdgeInsets.zero,
        child: FlexibleListing(
          crossAxisAlignment: CrossAxisAlignment.start,
          deviceAxis: deviceAxis,
          mainAxisSize: mainAxisSize,
          children: childrenList,
        )
        /* Flex(
          crossAxisAlignment: CrossAxisAlignment.start,
          direction: direction,
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          /*children: [
           linkedInput("Test",
               flex: -1)
         ],*/
          children: childrenList
      ),*/
        );
  }

  Widget linkedInput(
    String name, {
    flex,
    overrideMultiplier = false,
    obscure = false,
    String? displayName,
    InputDecoration? decoration,
    usesDefaultPadding = true,
    validator,
    List<TextInputFormatter>? formatters,
    AutovalidateMode? autoValidateMode,
    bool active = true,
    bool enabled = true,
    bool hasEnabler = false,
    bool invertEnabler = false,
    int? maxLength,
    String? initialValue,
    TextInputType? keyboardType,
    int? minLines,
    int? maxLines,
    FocusNode? focusNode,
    TextEditingController? controller,
    double? inputWidth,
    bool? displaysError,
    Function(String)? onFieldSubmitted,
  }) {
    /*if(inputs.containsKey(name)) {
      return inputs[name]!;
    }*/

    flex ??= defaultFlex;

    if (!active) {
      return Container();
    }

    if (storeNames) {
      names.add(name);
    }

    displayName ??= "${name[0].toUpperCase()}${name.substring(1)}";

    decoration = linkedDecoration(decoration,
        displayName: displayName,
        name: name,
        usesDefaultPadding: usesDefaultPadding);

    autoValidateMode ??= defaultValidateMode;

    if (controller != null) {
      formController.setController(name, controller, validator,
          validateMode: autoValidateMode);
    }

    String? Function(String? v)? validatorFunction;
    if (validator != null) {
      validator = formController.getLinkedValidator(
          getValidator(validator, displaysError), name);

      if (wrapperFunction != null) {
        validatorFunction = (String? v) {
          return wrapperFunction!(v, validator(v));
        };
      } else {
        validatorFunction = validator;
      }

      if (wrapperFunction != null) {
        validatorFunction = (String? v) {
          return wrapperFunction!(v, validator(v));
        };
      } else {
        validatorFunction = validator;
      }
    }

    if (hasEnabler) {
      dynamic enabledValue = formController.readField("has_$name");
      enabled = enabledValue == ""
          ? enabled
          : (invertEnabler ? !enabledValue : enabledValue);
    }

    Widget input = TextFormField(
      controller: controller ??
          formController.getLinkedController(validator, name,
              validateMode: autoValidateMode, initialValue: initialValue),
      autovalidateMode: autoValidateMode,
      validator: validatorFunction,
      decoration: decoration,
      obscureText: obscure,
      obscuringCharacter: "*",
      enabled: fieldsEnabled && enabled,
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType,
      focusNode: focusNode,
      inputFormatters: formatters,
      onFieldSubmitted: onFieldSubmitted,
    );

    inputWidth ??= defaultInputWidth;

    if (inputWidth != null) {
      input = SizedBox(
        width: inputWidth,
        child: input,
      );
    }

    input = linkedFlex(
        flex: flex, overrideMultiplier: overrideMultiplier, child: input);

    return input;
  }

  getValidator(validator, displaysError) {
    bool errorDisplayDisabled =
        validator != null && displaysError != null && displaysError == false;

    return errorDisplayDisabled
        ? (String? v) {
            String? errorResponse = validator(v);

            if (errorResponse != null) {
              return "";
            }

            return null;
          }
        : validator;
  }

  InputDecoration? linkedDecoration(InputDecoration? decoration,
      {String? displayName,
      required String name,
      bool usesDefaultPadding = true}) {
    if (decoration == null) {
      decoration = InputDecoration(
        label: LabelText(content: displayName ?? name),
        border: const OutlineInputBorder(),
      );
    } else {
      Widget? label = LabelText(
        content: displayName ?? name,
      );

      if (decoration.label != null) {
        label = decoration.label;
      }

      if (decoration.labelText != null) {
        label = null;
      }

      decoration = decoration.copyWith(
        label: label,
        hintText: (displayName ?? name),
        border: const OutlineInputBorder(),
      );
    }

    if (usesDefaultPadding && inputPadding != null) {
      decoration = decoration.copyWith(contentPadding: inputPadding);
    }

    if (!fieldsEnabled) {
      decoration =
          decoration.copyWith(filled: true, fillColor: const Color(0x8BDEDEDE));
    }

    return decoration;
  }

  Widget linkedFlex(
      {flex, overrideMultiplier = false, child, bool visible = true}) {
    if (!overrideMultiplier) {
      flex *= flexMultiplier;
    }

    if (flex <= 0) {
      return child;
    }
    return Visibility(
      visible: visible,
      child: Flexible(flex: flex, child: child),
    );
  }
}

class LinkedFlex extends StatelessWidget {
  final int? flex;
  final FormValidatorUtility formUtility;
  final bool overrideMultiplier;
  final Widget child;
  final bool visible;
  const LinkedFlex(
      {this.flex,
      required this.child,
      this.overrideMultiplier = false,
      required this.formUtility,
      this.visible = true,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return Container();
    }

    int flexValue = flex ?? formUtility.defaultFlex;
    if (!overrideMultiplier) {
      flexValue *= formUtility.flexMultiplier;
    }

    if (flexValue <= 0) {
      return child;
    }
    return Flexible(flex: flexValue, child: child);
  }
}

class LabelText extends StatelessWidget {
  final String content;
  static const double labelLeftPadding = 12;

  const LabelText({Key? key, required this.content}) : super(key: key);

  static Color getTextColors() {
    return Colors.blueAccent;
  }

  static double fontSize(context) {
    double fontSize = MediaQuery.of(context).size.width * 0.015;

    fontSize = min(fontSize, 16);
    fontSize = max(fontSize, 12);

    return fontSize;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle labelStyle =
        TextStyle(fontSize: fontSize(context), color: getTextColors());

    return Text(
      content,
      style: labelStyle,
    );
  }
}
