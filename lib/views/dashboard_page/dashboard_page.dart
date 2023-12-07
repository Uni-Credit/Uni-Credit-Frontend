





import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';
import 'package:uni_credit/default_footer.dart';
import 'package:uni_credit/models/system/user_information.dart';
import 'package:uni_credit/views/dashboard_page/dashboard_body.dart';

import '../../models/system/credit.dart';

class DashboardConstruction {
  UserInformation? userInformation;
  DashboardConstruction({
    this.userInformation,
});
}
@RoutePage(name: 'dashboard')
class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  DashboardConstruction construction = DashboardConstruction(
    userInformation: UserInformation.fromMap({'credits':  [
      Credit(value: 'XXX.XXX', name: 'RU 1'),
      Credit(value: 'XXX.XXX', name: 'RU 2'),
    ]})
  );


  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      /**/footer: [
        DefaultFooter()
      ],
      backgroundColor: Color(0xff212020),
      useDefaultPadding: false,
        navbarConfig: NavbarConfiguration.empty(),
        //appbarConfig: AppbarConfiguration.empty(),
         appbarConfig: AppbarConfiguration(
           height: 80, //ignorePadding: true,
         content: DashboardAppbar()),
         body: DashboardBody(
           construction: construction
         ));
  }
}
