



import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';
import 'package:uni_credit/views/historic_page/historic_body.dart';



@RoutePage(name: 'historic')
class HistoricPage extends StatelessWidget {
  const HistoricPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        navbarConfig: NavbarConfiguration(
          usesDefaultNavbar: false,
        ),

        appbarConfig: AppbarConfiguration.withTitle(title: 'Histórico'),

        body: HistoricBody());
  }
}
