





import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/default_footer.dart';
import 'package:uni_credit/models/extensions/for_build_context.dart';
import 'package:uni_credit/models/system/user_information.dart';
import 'package:uni_credit/shared_widgets/base_template/template_scaffold.dart';
import 'package:uni_credit/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:uni_credit/shared_widgets/item_sizes.dart';
import 'package:uni_credit/theme/theme_colors.dart';
import 'package:uni_credit/views/dashboard_page/dashboard_body.dart';
import 'package:uni_credit/views/dashboard_page/widgets/dashboard_buttons.dart';

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
      footer: [
        DefaultFooter()
      ],
      useDefaultPadding: false,
        navbarConfig: NavbarConfiguration(ignoreNavbarPadding: true,),
         appbarConfig: AppbarConfiguration(
           height: 80,
         content: DashboardAppbar()),
         body: DashboardBody(
           construction: construction
         ));
  }
}
