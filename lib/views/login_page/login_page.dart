

import 'package:flutter/cupertino.dart';
import 'package:uni_credit/shared_widgets/base_template/template_scaffold.dart';

import 'login_page_body.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
      useDefaultPadding: false,
      appbarConfig: AppbarConfiguration(
        ignorePadding: true
      ),
        body:   LoginPageBody());
  }
}
