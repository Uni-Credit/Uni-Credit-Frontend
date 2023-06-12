import 'package:framework/atech/models/patient.dart';
import 'package:framework/atech/models/patient_metrics.dart';

import '../enums/enum_helpers.dart';

class Device {
  Patient? linkedPatient;
  MetricStatus status;
  PatientMetrics? metrics;
  DeviceConnected connectionStatus;

  Device(
      {this.linkedPatient,
      this.metrics,
      required this.status,
      required this.connectionStatus});

  static String patientKey = 'patient';
  static String metricsKey = 'metrics';
  static String statusKey = 'status';
  static String connectionStatusKey = 'connectionStatus';

  static Device fromMap(Map<String, dynamic> item) {
    return Device(
      metrics: PatientMetrics.fromMap(item[metricsKey]),
      linkedPatient: Patient.fromMap(item[patientKey]),
      status: MetricStatus.values.firstWhere(
          (e) => e.toString() == 'MetricStatus.' + item[statusKey].toString(),
          orElse: () => MetricStatus.unknown),
      connectionStatus: DeviceConnected.values.firstWhere(
          (e) =>
              e.toString() ==
              'DeviceConnected.' + item[connectionStatusKey].toString(),
          orElse: () => DeviceConnected.unknown),
    );
  }
}

enum DeviceConnected {
  connected,
  connectionHasProblems,
  notIdentified,
  notConnected,
  unknown
}
