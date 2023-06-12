import 'package:auto_route/auto_route.dart';
import 'package:framework/atech/views/patient_profile_page/patient_profile_page.dart';
import 'package:framework/atech/views/patient_profile_page/widgets/patient_information_view.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/item_sizes.dart';
import 'package:framework/shared_widgets/widgets/app_container.dart';
import 'package:flutter/material.dart';

import '../../models/patient.dart';

class PatientProfilePageBody extends StatelessWidget {
  final PatientProfileConstruction construction;
  const PatientProfilePageBody({Key? key, required this.construction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppContainer(
            child: PatientInformationView(
          patient: construction.patient,
        )),
        PersonalFamiliarInformationView(
          patient: construction.patient,
        ),
        PatientProfilePage.patientActionsView == null
            ? Container()
            : PatientProfilePage.patientActionsView!(construction, context),
        Visibility(
          visible: construction.showMetricHistoric,
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: CardButtonV1(
              title: CardTextContent(
                content: 'Histórico de medições',
              ),
              onPress: construction.onShowMetricHistoricClick ??
                  () {
                    context.router.pushNamed('metric-historic-page');
                  },
            ),
          ),
        ),
        construction.additionalInformation ?? Container()
      ],
    );
  }
}

class PersonalFamiliarInformationView extends StatelessWidget {
  final Patient patient;
  const PersonalFamiliarInformationView({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        PatientInformationElement(
          nameLabel: "Telefone principal registrado para contato",
          data: patient.patientContact.userTelephone.data,
        ),
        PatientInformationElement(
          nameLabel: "Email de contato",
          data: patient.patientContact.userEmail.data,
        ),
        PatientInformationElement(
          nameLabel: "Endereço registrado",
          data: patient.patientData.address,
        ),
      ],
    );
  }
}

class PatientInformationElement extends StatelessWidget {
  final String nameLabel;
  final dynamic data;
  const PatientInformationElement({
    Key? key,
    required this.data,
    required this.nameLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double textSize = 12;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            nameLabel + ": ",
            style: TextStyle(fontSize: textSize + 2),
          ),
          Text(
            data.toString(),
            style: TextStyle(fontSize: textSize),
          )
        ],
      ),
    );
  }
}
