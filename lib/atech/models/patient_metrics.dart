//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/models/model.dart';

class PatientMetrics implements Model<Metric> {
  late Metric cardiacFrequency;
  late Metric breatheFrequency;
  late Metric temperature;
  late Metric oxygenConcentration;

  bool? patientHasFallen;

  PatientMetrics(
      {required cardiacFrequency,
      required breatheFrequency,
      required temperature,
      required oxygenConcentration,
      required this.patientHasFallen}) {
    this.cardiacFrequency = Metric(
        value: cardiacFrequency,
        metricSuffix: 'bpm',
        model: this,
        name: 'Frequencia cardiaca',
        abbreviation: "Fc");

    this.temperature = Metric(
        value: temperature,
        metricSuffix: 'C',
        model: this,
        name: 'Temperatura',
        abbreviation: "T");
    this.breatheFrequency = Metric(
        value: breatheFrequency,
        metricSuffix: 'mrm',
        model: this,
        name: 'Frequência de respiração',
        abbreviation: "Fr");
    this.oxygenConcentration = Metric(
        value: oxygenConcentration,
        model: this,
        metricSuffix: '%',
        abbreviation: "Ox",
        name: 'Oxigenação do sangue');
  }

  static String cardiacFrequencyKey = 'cardiacFrequency';
  static String temperatureKey = 'temperature';
  static String bloodOxygenConcentrationKey = 'bloodOxygenConcentration';
  static String patientHasFallenKey = 'patientHasFallen';
  static String breatheFrequencyKey = 'breatheFrequency';

  static PatientMetrics fromMap(Map<String, dynamic>? map) {
    //debugPrint(map[patientHasFallenKey].toString());
    return PatientMetrics(
        cardiacFrequency: map?[cardiacFrequencyKey],
        breatheFrequency: map?[breatheFrequencyKey],
        temperature: map?[temperatureKey],
        oxygenConcentration: map?[bloodOxygenConcentrationKey],
        patientHasFallen: map?[patientHasFallenKey]);
  }

  static PatientMetrics mockAverage() {
    return PatientMetrics(
        cardiacFrequency: {'value': 60, 'status': MetricStatus.normal},
        breatheFrequency: {'value': 20, 'status': MetricStatus.normal},
        temperature: {'value': 37, 'status': MetricStatus.normal},
        oxygenConcentration: {'value': 97, 'status': MetricStatus.normal},
        patientHasFallen: false);
  }

  @override
  List<Metric> elements = [];

  static mockByStatus(MetricStatus status) {
    PatientMetrics mockMetric = mockAverage();

    if (status == MetricStatus.lessThanExpected) {
      mockMetric.oxygenConcentration.value = 80;
    }

    if (status == MetricStatus.moreThanExpected) {
      mockMetric.temperature.value = 39;
    }

    return mockMetric;
  }
}

enum MetricStatus {
  lessThanExpected,
  moreThanExpected,
  alarmingHigh,
  alarmingLow,
  normal,
  nonActive,
  unknown
}

extension MetricStatusDisplay on MetricStatus {
  relatedColor() {
    return ({
          MetricStatus.normal: Colors.green,
          MetricStatus.moreThanExpected: Colors.red,
          MetricStatus.lessThanExpected: Colors.blueAccent
        }[this]) ??
        Colors.white;
  }
}

class Metric extends ModelElement {
  dynamic value;
  String metricSuffix;
  String name;
  String abbreviation;

  Metric(
      {required this.value,
      required this.metricSuffix,
      required this.name,
      required this.abbreviation,
      required super.model}) {
    debugPrint("setting $name with $value");
    if (value is! Map) {
      value = {"value": value, "status": MetricStatus.unknown};
    } else {
      value["status"] = (value["status"] is MetricStatus
          ? value["status"]
          : MetricStatus.values.firstWhere(
              (e) => e.toString() == 'MetricStatus.' + value["status"],
              orElse: () => MetricStatus.unknown));
    }

    debugPrint("setted $name   with $value");
  }

  @override
  String toString() {
    if (value == null) {
      return 'Desconhecido';
    }

    return getValue().toString() + metricSuffix;
  }

  MetricStatus get status => value['status'];

  getValue() {
    return value['value'];
  }
}
