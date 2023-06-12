import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../shared_widgets/base_template/go_back_button.dart';
import 'forgot_password_page_body.dart';

class ForgotPasswordConstruction {}

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        navbarConfig: NavbarConfiguration(
          navbar: GoBackButton(),
        ),
        body: ForgotPasswordPageBody());
  }
}
