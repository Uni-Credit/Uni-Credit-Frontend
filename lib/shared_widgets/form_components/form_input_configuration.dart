// used to pass information of a particular field
import 'package:uni_credit/shared_widgets/form_components/validation_form_controller.dart';

class FormInputConfiguration {
  final String fieldName;
  final FormValidationController formController;
  late bool required;

  FormInputConfiguration(
      {required this.fieldName,
      required this.formController,
      bool isRequired = false}) {
    required = isRequired;

    if (required) {
      formController.insureRequirement(fieldName);
    }
  }

  read() {
    return formController.readField(fieldName);
  }
}
