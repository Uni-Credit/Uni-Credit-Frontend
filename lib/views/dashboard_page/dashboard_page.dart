





import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_credit/shared_widgets/base_template/template_scaffold.dart';
import 'package:uni_credit/views/dashboard_page/dashboard_body.dart';

@RoutePage(name: 'dashboard')
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      useDefaultPadding: false,
        navbarConfig: NavbarConfiguration(ignoreNavbarPadding: true,),
         appbarConfig: AppbarConfiguration(ignorePadding: true,height: 0),
         body: DashboardBody());
  }
}
