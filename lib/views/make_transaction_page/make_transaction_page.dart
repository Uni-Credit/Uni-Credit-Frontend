



import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';

import 'package:uni_credit/views/make_transaction_page/make_transaction_body.dart';


import '../../models/system/credit.dart';


class MakeTransactionConstruction {
  Credit credit;

  MakeTransactionConstruction({
    required this.credit,
});
}

@RoutePage(name: 'transaction')
class MakeTransactionPage extends StatelessWidget {
  final MakeTransactionConstruction construction;
  const MakeTransactionPage({super.key, required this.construction});

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      navbarConfig: NavbarConfiguration(usesDefaultNavbar: false),
        appbarConfig: AppbarConfiguration.withTitle(title: 'Transação'),
        body: MakeTransactionBody());
  }
}
