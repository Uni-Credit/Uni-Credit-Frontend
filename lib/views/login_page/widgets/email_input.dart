
import 'package:flutter/cupertino.dart';

import '../../../shared_widgets/form_components/form_controller_utility.dart';
import '../../../shared_widgets/form_components/linked_text_input.dart';
import '../../../shared_widgets/form_components/validations.dart';

class EmailInput extends StatelessWidget {
  const EmailInput({
    super.key,
    required this.formUtility,
  });

  final FormValidatorUtility formUtility;

  @override
  Widget build(BuildContext context) {
    return LinkedTextInput(
        formUtility: formUtility,
        name: 'email',
        displayName: 'Inserir email',
        validator: Validations.override(
            Validations.email, 'Email inválido!'));
  }
}

