import 'package:framework/atech/models/patient/patient_contact.dart';
import 'package:framework/atech/models/patient_data.dart';

class Patient {
  PatientData patientData;
  PatientContact patientContact;

  Patient({required this.patientData, required this.patientContact});

  static String dataKey = 'data';
  static String contactKey = 'contact';

  static Patient fromMap(item) {
    Map<String, dynamic> t = {};

    return Patient(
        patientData: PatientData.fromMap(
          item?[dataKey],
        ),
        patientContact: PatientContact.fromMap(item?[contactKey]));
  }

  static List<Patient> mock() {
    return [
      Patient.fromMap({
        Patient.dataKey: {PatientData.patientName: 'Carlos'}
      }),
      Patient.fromMap({
        Patient.dataKey: {PatientData.patientName: 'Rodrigo'}
      }),
    ];
  }

  @override
  String toString() {
    return "Paciente $patientData";
  }

  toIdentifier() {
    return 1;
  }
}
