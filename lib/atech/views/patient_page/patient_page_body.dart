import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:framework/atech/views/patient_page/metrics_list.dart';
import 'package:framework/atech/views/patient_page/patient_page.dart';
import 'package:framework/atech/views/patient_page/widgets/patient_metric_graphic.dart';
import 'package:framework/shared_widgets/widgets/app_container.dart';
import 'package:flutter/material.dart';

class PatientPageBody extends StatelessWidget {
  final ViewPatientConstruction construction;
  const PatientPageBody({Key? key, required this.construction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: construction.actionsWidget ?? Container(),
        ),
        Flexible(
            child: construction.demonstrativeWidget ??
                Container() //PatientMetricGraphic(device: construction.device),
            ),
        Flexible(flex: 2, child: _MetricDisplay(construction: construction)),
      ],
    );
  }
}

class _MetricDisplay extends StatelessWidget {
  const _MetricDisplay({
    super.key,
    required this.construction,
  });

  final ViewPatientConstruction construction;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Medições",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: AppContainer(
                child: MetricsList(
              metrics: construction.device.metrics!,
            )),
          ),
          /*Container(
            height: 10,
            //width: double.maxFinite,
            color: Colors.blue,
          ),*/
        ],
      ),
    );
  }
}
