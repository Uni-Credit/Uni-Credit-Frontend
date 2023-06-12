import 'package:flutter/cupertino.dart';

import '../../../../../shared_widgets/form_components/form_controller_utility.dart';
import '../../../../../shared_widgets/form_components/linked_text_input.dart';
import '../../../../../shared_widgets/form_components/validations.dart';

class DeviceIdInput extends StatelessWidget {
  final FormValidatorUtility formUtility;
  const DeviceIdInput({Key? key, required this.formUtility}) : super(key: key);

  static String deviceIdKey = 'device_id';
  @override
  Widget build(BuildContext context) {
    return LinkedTextInput(
      formUtility: formUtility,
      name: deviceIdKey,
      displayName: 'Insira id de dispositivo',
      validator: Validations.requiredField,
    );
  }
}
