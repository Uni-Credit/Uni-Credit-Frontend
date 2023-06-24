



import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:uni_credit/shared_widgets/base_template/go_back_button.dart';
import 'package:uni_credit/shared_widgets/base_template/template_scaffold.dart';
import 'package:uni_credit/views/make_transaction_page/make_transaction_body.dart';


@RoutePage(name: 'historic')
class HistoricPage extends StatelessWidget {
  const HistoricPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        navbarConfig: NavbarConfiguration(
          navbar: GoBackButton()
        ),
        body: MakeTransactionBody());
  }
}
