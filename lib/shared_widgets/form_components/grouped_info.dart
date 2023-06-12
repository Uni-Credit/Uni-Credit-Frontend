import 'package:flutter/cupertino.dart';

import '../../../shared_widgets/form_components/validation_form_controller.dart';

class GroupedInfo extends StatefulWidget {
  List? list;

  bool isList;
  FormValidationController parentValidatorController;
  FormValidationController validatorController;
  String groupLabel;
  Widget child;
  bool Function() currentFieldsValidation;

  GroupedInfo(
      {this.list,
      required this.parentValidatorController,
      required this.validatorController,
      required this.child,
      required this.groupLabel,
      required this.currentFieldsValidation,
      this.isList = true,
      Key? key})
      : super(key: key);

  @override
  State<GroupedInfo> createState() => _GroupedInfoState();
}

class _GroupedInfoState extends State<GroupedInfo> {
  bool firstUpdate = true;

  @override
  Widget build(BuildContext context) {
    if (firstUpdate) {
      firstUpdate = false;

      widget.validatorController.dataListeners.add(() {
        bool validationState =
            widget.validatorController.getLastValidationState();

        if (validationState) {
          dynamic mapList = widget.list == null
              ? []
              : widget.list!
                  .map((e) => e)
                  .cast<Map<String, dynamic>>()
                  .toList();

          if (widget.currentFieldsValidation()) {
            dynamic item = widget.validatorController.readFields();
            if (widget.isList) {
              mapList.add(item);
            } else {
              mapList = item;
            }
          }

          widget.parentValidatorController
              .setData(widget.groupLabel, mapList, isValid: validationState);
          return;
        }

        if (widget.list != null) {
          widget.parentValidatorController.setData(
              widget.groupLabel, widget.list!.isNotEmpty ? widget.list : null,
              isValid: widget.list!.isNotEmpty);
        }
      });
    }

    return widget.child;
  }
}
