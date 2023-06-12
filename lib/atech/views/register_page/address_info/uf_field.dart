import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../shared_widgets/form_components/form_controller_utility.dart';
import '../../../../shared_widgets/form_components/linked_text_input.dart';
import '../../../../shared_widgets/form_components/validations.dart';

class UFField extends StatelessWidget {
  final FormValidatorUtility formUtility;
  final String name;
  final double? dropdownWidth;
  const UFField(
      {required this.formUtility,
      this.dropdownWidth,
      Key? key,
      this.name = "uf"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //return Text("");
    return LinkedTextInput(
      displayName: "UF",
      name: name,
      //suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
      flex: 0,
      formatters: [FilteringTextInputFormatter.deny(RegExp("[0-9]"))],
      validator: Validations.override(Validations.requiredField, ""),
      formUtility: formUtility,
    );
    /*return AutoCompleteField(
        updateOnInput: true,
        inputConfiguration: FormInputConfiguration(
            formController: formUtility.formController, fieldName: name),
        dropdownWidth: dropdownWidth ?? MediaQuery.of(context).size.width * 0.1,
        optionsBuilder: () async {
          return await getUFs();
        },
        inputBuilder: (AutoCompleteBuilderArgs builderArgs) {
          return LinkedTextInput(
            displayName: "UF",
            name: name,
            suffixIcon: const Icon(Icons.arrow_drop_down_rounded),
            //flex: 3,
            formatters: [
              // FilteringTextInputFormatter.deny(RegExp("[0-9]"))
            ],
            validator: Validations.override(Validations.requiredField, ""),
            controller: builderArgs.textController,
            focusNode: builderArgs.focusNode,
            formUtility: formUtility,
          );
        });*/
  }
}
