import 'package:dio/dio.dart';
import 'package:framework/models/extensions/for_response.dart';
import 'package:framework/requests/app_dio.dart';
import 'package:framework/requests/caller/arguments/free_form_argument_caller.dart';

import '../../requests/caller/arguments/argument_caller.dart';
import '../../requests/caller/arguments/list_argument_caller.dart';
import '../../requests/caller/request_caller.dart';
import '../../requests/caller/response_request_caller.dart';
import '../models/health_professional.dart';
import '../models/patient.dart';
import 'backend_response.dart';

class PatientRequests {
  static Future<BackendResponse> _editProfile(
      FreeFormArgumentCaller argumentCaller) async {
    Dio appDio = AppRequestDio();
    Response response =
        await appDio.post("editUser", data: argumentCaller.args);

    return BackendResponse(response);
  }

  static Future<BackendResponse> _vinculateToDoctor(
      PatientVinculation argumentCaller) async {
    Dio appDio = AppRequestDio();

    Map data = {
      "patients":
          argumentCaller.patientsToVinculate.map((e) => e.toIdentifier()),
      "professionals":
          argumentCaller.professionalsToVinculate.map((e) => e.toIdentifier())
    };
    Response response = await appDio.post("vinculateUsers", data: data);

    return BackendResponse(response);
  }

  static Future<BackendResponse> _loadPatients(
      PatientSearch argumentCaller) async {
    Dio appDio = AppRequestDio();

    Response response =
        await appDio.get("patients", data: {"name": argumentCaller.nameSearch});

    return BackendResponse(response);
  }

  static ResponseRequestCaller<FreeFormArgumentCaller> editProfile =
      ResponseRequestCaller(_editProfile);
  static ResponseRequestCaller<PatientVinculation> vinculateToDoctor =
      ResponseRequestCaller(_vinculateToDoctor);
  static ResponseRequestCaller<PatientSearch> loadPatients =
      ResponseRequestCaller(_loadPatients);
}

class PatientVinculation extends ArgumentCaller {
  List<Patient> patientsToVinculate;
  List<HealthProfessional> professionalsToVinculate;
  PatientVinculation(
      {required this.patientsToVinculate,
      required this.professionalsToVinculate});
}

class PatientSearch extends ArgumentCaller {
  String? nameSearch;

  PatientSearch({
    this.nameSearch,
  });
}
