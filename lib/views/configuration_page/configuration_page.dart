



import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';


import 'configuration_body.dart';


@RoutePage(name: 'configuration')
class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(body: ConfigurationBody());
  }
}
