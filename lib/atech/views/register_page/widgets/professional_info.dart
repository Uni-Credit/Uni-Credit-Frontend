import 'package:flutter/cupertino.dart';
import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';
import 'package:framework/shared_widgets/form_components/linked_text_input.dart';
import 'package:framework/shared_widgets/form_components/validations.dart';
import 'package:framework/shared_widgets/responsive/media_queries.dart';

class ProfessionalInfo extends StatelessWidget {
  final FormValidatorUtility formUtility;
  final bool usesCRM;
  const ProfessionalInfo(
      {Key? key, required this.formUtility, required this.usesCRM})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return formUtility.InputLine(
      itemSpacing:
          const EdgeInsets.only(top: LinkedTextInput.defaultTopInputSpacing),
      deviceAxis: DeviceOption(defaultResult: Axis.vertical),
      children: [
        Visibility(
          visible: usesCRM,
          child: LinkedTextInput(
            formUtility: formUtility,
            name: "crm",
            displayName: "CRM",
            validator: Validations.crm,
          ),
        ),
        LinkedTextInput(
          formUtility: formUtility,
          name: "institution",
          displayName: "Instituição",
        ),
        LinkedTextInput(
          formUtility: formUtility,
          name: "speciality",
          displayName: "Especialidade",
        ),
      ],
    );
  }
}
