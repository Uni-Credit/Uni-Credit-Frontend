import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/atech/models/health_professional.dart';
import 'package:framework/atech/requests/backend_response.dart';
import 'package:framework/atech/requests/patient_requests.dart';
import 'package:framework/models/extensions/for_widget.dart';
import 'package:framework/requests/request_process.dart';
import 'package:framework/shared_widgets/popups/response_popup.dart';

import '../../../../../shared_widgets/popups/confirmation_popup.dart';
import '../../../../models/patient.dart';

class ConfirmConnectionPopup extends StatelessWidget {
  final HealthProfessional professional;
  final List<Patient> selectedPatients;
  const ConfirmConnectionPopup(
      {Key? key, required this.professional, required this.selectedPatients})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String names = "";
    selectedPatients.forEach((element) {
      names += "${element.patientData.name}, ";
    });

    names = names.substring(0, names.length - 2);

    return ConfirmationPopup<bool>(
      title: Component(content: "${professional.name} passará a monitorar:"),
      subtitle: names,
      onSelect: (v) {
        context.router.pop();
        if (v) {
          RequestProcess<BackendResponse> process = RequestProcess(
              PatientRequests.vinculateToDoctor(
                  //
                  argument: PatientVinculation(
                      patientsToVinculate: selectedPatients,
                      professionalsToVinculate: [professional])),
              StatusResolver.requestStatusResolver);

          ResponsePopup(requestProcess: process).showDialogWithWidget(context);
        }
      },
    );
  }
}
