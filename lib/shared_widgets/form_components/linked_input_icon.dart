import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';

class LinkedInputIcon extends StatefulWidget {
  final dynamic icon;
  final FormValidationController formController;
  final String name;
  final bool mirror;
  final bool usePadding;
  final dynamic errorIcon;

  final Function()? onTap;

  const LinkedInputIcon({
    required this.icon,
    this.errorIcon,
    required this.formController,
    required this.name,
    Key? key,
    this.usePadding = true,
    this.mirror = false,
    this.onTap,
  }) : super(key: key);

  @override
  State<LinkedInputIcon> createState() => _LinkedInputIconState();
}

class _LinkedInputIconState extends State<LinkedInputIcon> {
  bool isValidated = true;

  @override
  void initState() {
    super.initState();
    widget.formController.onValidationChange((isValid) {
      if (!mounted) return;
      debugPrint(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");

      setState(() {
        isValidated = isValid;
      });
      debugPrint(isValidated.toString());
    }, targetData: widget.name);
  }

  dynamic getIcon(defaultIcon) {
    if (!isValidated && widget.errorIcon != null) {
      return widget.errorIcon;
    }

    return defaultIcon;
  }

  // #TODO RECEIVE svg!
  getIconWidget() {
    dynamic usedIcon = getIcon(widget.icon);

    debugPrint("widget is " + usedIcon.runtimeType.toString());

    if (usedIcon is IconButton) {
      debugPrint("setting icon button");

      dynamic icon = widget.icon.icon;
      if (widget.icon.icon is Icon) {
        Color? color;
        if (isValidated) {
          color = (usedIcon.icon as Icon).color;
        }

        icon = Icon(
          (widget.icon.icon.icon),
          size: widget.icon.icon.size,
          color: color,
          semanticLabel: widget.icon.icon.semanticLabel,
        );
      }

      return IconButton(
          onPressed: widget.icon.onPressed,
          focusNode: FocusNode(
            skipTraversal: true,
          ),
          icon: icon);
    }

    if (usedIcon is! IconData) {
      debugPrint("returning as is");
      return GestureDetector(
          onTap: widget.onTap ?? () {}, child: (usedIcon as Widget));
    }

    debugPrint("returning icon");
    Color? color = isValidated ? widget.icon.color : Colors.red;

    return Icon(
      usedIcon,
      size: widget.icon.size,
      color: color,
      semanticLabel: widget.icon.semanticLabel,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = getIconWidget();

    if (widget.mirror) {
      iconWidget = Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: iconWidget,
      );
    }

    if (widget.usePadding) {
      iconWidget = Padding(
        padding: const EdgeInsets.only(right: 8),
        child: iconWidget,
      );
    }

    return iconWidget;
  }
}
