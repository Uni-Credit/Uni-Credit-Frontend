import 'package:flutter/material.dart';
import '../../../models/patient_metrics.dart';

class SummarizedPatientMetrics extends StatelessWidget {
  final PatientMetrics metrics;
  final TextStyle? textStyle;
  const SummarizedPatientMetrics(
      {Key? key, required this.metrics, this.textStyle})
      : super(key: key);

  String getText() {
    return metrics.elements
        .map((e) => '${e.name}:$e')
        .reduce((value, element) => '$value, $element');
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      getText(),
      style: textStyle ?? TextStyle(color: Colors.white, fontSize: 12),
    );
  }
}
