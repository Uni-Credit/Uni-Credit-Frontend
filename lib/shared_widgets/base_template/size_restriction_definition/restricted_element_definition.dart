import 'package:framework/shared_widgets/base_template/size_restriction_definition/template_restricted_element.dart';
import 'package:flutter/cupertino.dart';

class RestrictedElementDefinition {
  final double realWidth;
  final double? restrictedWidth;
  final double preferredHeight;

  RestrictedElementDefinition(
      {required this.realWidth,
      required this.restrictedWidth,
      required this.preferredHeight});

  PreferredSizeWidget getElement(
      {content,
      background,
      parentBody,
      double? width,
      double? restrictedHeight}) {
    return TemplateRestrictedElement(
        realWidth: realWidth,
        restrictedWidth: width ?? restrictedWidth!,
        content: content,
        parentBody: parentBody,
        background: background,
        preferredHeight: preferredHeight,
        restrictedHeight: restrictedHeight);
  }
}
