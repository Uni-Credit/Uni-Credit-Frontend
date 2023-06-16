import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/shared_widgets/form_components/template_dropdown.dart';
import 'package:uni_credit/shared_widgets/form_components/validation_form_controller.dart';

class DropdownBuilderArgs {
  DropdownItem selectedItem;
  DropdownBuilderArgs({required this.selectedItem});
}

class DropdownStyleArgs {
  DropdownStyleArgs({
    this.offset,
  });
  final Offset? offset;
}

class DropdownItem {
  final dynamic value;
  late String? display;

  DropdownItem({required this.value, String? displayValue}) {
    display = displayValue ?? value;
  }
}

class DropdownField extends StatefulWidget {
  final List<DropdownItem> items;
  final Function(DropdownBuilderArgs)? displayBuilder;
  final FormValidationController? formController;
  final String? name;
  final Function(dynamic)? onChanged;
  final DropdownStyleArgs? styleArgs;

  final ValueNotifier<DropdownItem?>? itemSelected;

  const DropdownField(
      {required this.items,
      this.displayBuilder,
      this.itemSelected,
      Key? key,
      this.name,
      this.styleArgs,
      this.onChanged,
      this.formController})
      : super(key: key);

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  DropdownItem selectedItem = DropdownItem(value: null);

  @override
  void initState() {
    selectedItem = widget.items[0];

    if (widget.itemSelected != null) {
      widget.itemSelected!.value = selectedItem;
      widget.itemSelected!.addListener(() {
        if (widget.itemSelected!.value != null &&
            widget.itemSelected!.value != selectedItem) {
          //setState(() {
          selectedItem = widget.itemSelected!.value!;
          //});
        }
      });
    }

    super.initState();
    // selectedItem = widget.items[0];

    setFromFormController();
  }

  void setFromFormController() {
    if (widget.formController == null) {
      return;
    }
    widget.formController!.insureRequirement(widget.name!);

    dynamic value =
        widget.formController!.readField(widget.name!, defaultValue: null);

    if (value != null) {
      selectedItem = getItem(value: value)!;
      return;
    }
    if (selectedItem.value != null) {
      widget.formController
          ?.setData(widget.name!, selectedItem.value, updateValidation: false);
    }
  }

  DropdownItem? getItem({required value}) {
    for (DropdownItem item in widget.items) {
      if (item.value == value) {
        return item;
      }
    }

    return null;
  }

  onChanged(dynamic v) {
    if (v != null) {
      selectedItem = getItem(value: v)!;
      widget.itemSelected?.value = selectedItem;
    }

    if (widget.onChanged != null) {
      widget.onChanged!(v);
    }

    if (widget.formController != null) {
      widget.formController!.setData(widget.name!, v);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem> dropdownItems = [];

    for (DropdownItem item in widget.items) {
      dropdownItems.add(DropdownMenuItem(
          alignment: AlignmentDirectional.centerStart,
          value: item.value,
          child: Text(item.display ?? '')));
    }

    return DropdownButton2(
      items: dropdownItems,
      style: TextStyle(color: Colors.black45, fontSize: 18),

      buttonStyleData: ButtonStyleData(
        width: double.infinity,
      ),

      //   hint: widget.displayBuilder(selectedItem),
      customButton: widget.displayBuilder == null
          ? TemplateDropdown(
              args: DropdownBuilderArgs(selectedItem: selectedItem),
            )
          : widget
              .displayBuilder!(DropdownBuilderArgs(selectedItem: selectedItem)),
      dropdownStyleData: DropdownStyleData(
        offset: widget.styleArgs?.offset ?? Offset.zero,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      underline: Container(),
      iconStyleData: IconStyleData(
        icon: Container(),
        iconSize: 0,
      ),

      onChanged: onChanged,
    );
  }
}
