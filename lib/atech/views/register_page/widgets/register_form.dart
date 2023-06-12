import 'package:flutter/cupertino.dart';
import 'package:framework/atech/enums/user_type.dart';
import 'package:framework/atech/views/register_page/address_info/address_infos.dart';
import 'package:framework/atech/views/register_page/basic_info.dart';
import 'package:framework/atech/views/register_page/widgets/professional_info.dart';
import 'package:framework/shared_widgets/form_components/dropdown_field.dart';
import 'package:framework/shared_widgets/form_components/password_input.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';

import '../../../../shared_widgets/form_components/form_controller_utility.dart';
import '../../../../shared_widgets/form_components/linked_text_input.dart';
import '../../../../shared_widgets/form_components/validations.dart';

class RegisterForm extends StatelessWidget {
  final FormValidationController formController;
  final UserType? userType;
  const RegisterForm(
      {Key? key, required this.formController, required this.userType})
      : super(key: key);

  static String userKind = "kind";
  @override
  Widget build(BuildContext context) {
    FormValidatorUtility formUtility = FormValidatorUtility(
      formController,
    );

    bool usesCPF = userType != UserType.healthProfessional ||
        formController.readField(userKind) == "Nurse";

    return formUtility.InputLine(
      direction: Axis.vertical,
      ignoreLastSpacer: false,
      itemSpacing:
          const EdgeInsets.only(top: LinkedTextInput.defaultTopInputSpacing),
      children: [
        Visibility(
          visible: userType == UserType.healthProfessional,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: DropdownField(
                name: userKind,
                formController: formController,
                items: [
                  DropdownItem(value: "Medic", displayValue: "Médico(a)"),
                  DropdownItem(value: "Nurse", displayValue: "Enfermeira(o)")
                ]),
          ),
        ),
        Visibility(
          visible: usesCPF,
          child: LinkedTextInput(
            formUtility: formUtility,
            name: "cpf",
            displayName: "CPF",
          ),
        ),
        BasicInfo(
          formUtility: formUtility,
        ),
        Visibility(
            visible: userType == UserType.healthProfessional,
            child:
                ProfessionalInfo(formUtility: formUtility, usesCRM: !usesCPF)),
        AddressInfo(
          parentFormController: formUtility.formController,
          multiple: false,
          fieldName: "address",
          fieldMappers: const AddressFieldMappers(
            city: "city",
            complement: 'addressSecondLine',
            neighborhood: 'neighborhood',
            number: 'number',
            postalCode: 'cep',
            state: 'state',
            street: 'addressFirstLine',
          ),
        ),
      ],
    );
  }
}
