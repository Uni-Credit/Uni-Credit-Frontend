import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';

class FormCheckBox extends StatefulWidget {
  final FormValidationController formController;
  final String name;
  final String? label;
  final bool defaultValue;
  Function(bool)? onChanged;
  FormCheckBox(
      {Key? key,
      required this.name,
      this.defaultValue = true,
      this.label,
      required this.formController,
      this.onChanged})
      : super(key: key);

  @override
  State<FormCheckBox> createState() => _FormCheckBoxState();
}

class _FormCheckBoxState extends State<FormCheckBox> {
  bool checkValue = true;

  initState() {
    checkValue = !widget.formController
        .readField(widget.name, defaultValue: widget.defaultValue);
    setCheckValue();
  }

  setCheckValue() {
    widget.formController.setData(widget.name, checkValue);
  }

  changeValue(isSelected) {
    if (isSelected != null) {
      bool changed = checkValue != isSelected;

      setState(() {
        checkValue = isSelected;
        setCheckValue();
      });

      if (widget.onChanged != null && changed) {
        widget.onChanged!(isSelected);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        changeValue(!checkValue);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Row(
          children: [
            Checkbox(value: checkValue, onChanged: changeValue),
            widget.label != null ? Text(widget.label!) : Container()
          ],
        ),
      ),
    );
  }
}
