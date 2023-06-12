import 'package:flutter/cupertino.dart';
import 'package:framework/atech/models/patient.dart';

import '../../../../shared_widgets/widgets/title.dart';

class PatientInformationView extends StatelessWidget {
  final Patient patient;
  const PatientInformationView({Key? key, required this.patient})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TitleWidget(
      title: patient.patientData.name,
    );
  }
}
