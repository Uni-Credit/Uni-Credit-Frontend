import 'package:framework/atech/views/metric_historic_page/widgets/metric_historic_element.dart';
import 'package:framework/shared_widgets/widgets/app_container.dart';
import 'package:flutter/material.dart';
import 'metric_historic_page.dart';

class MetricHistoricPageBody extends StatelessWidget {
  final MetricHistoricConstruction? construction;

  const MetricHistoricPageBody({Key? key, this.construction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MetricHistoricElement(
          content: 'Níveis elevados de XXX',
          date: 'XX:XX, xx/xx/xx',
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: MetricHistoricElement(
            content: 'Cuidador alertado',
            date: 'XX:XX, xx/xx/xx',
          ),
        ),
      ],
    );
  }
}
