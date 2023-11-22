



import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';


import 'configuration_body.dart';


@RoutePage(name: 'configuration')
class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(body: ConfigurationBody());
  }
}
