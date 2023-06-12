import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/card_button/icon_action_card_button.dart';
import 'package:framework/shared_widgets/popups/action_content_popup.dart';

import '../../models/patient.dart';

class MedicalAlertPopup extends StatelessWidget {
  final Patient patient;
  const MedicalAlertPopup({Key? key, required this.patient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ActionContentPopup(content: [
      Text('Alerta recebido de Paciente ${patient.patientData.name}!')
    ], actions: [
      IconActionCardButton(
          content: '',
          forceMobile: true,
          icon: Icon(Icons.close),
          onPress: () {
            context.router.pop();
          })
    ]);
  }
}
