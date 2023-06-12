import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'metric_historic_page_body.dart';

class MetricHistoricConstruction {}

class MetricHistoricPage extends StatelessWidget {
  final MetricHistoricConstruction? construction;

  const MetricHistoricPage({Key? key, this.construction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        body: MetricHistoricPageBody(construction: construction));
  }
}
