import 'package:framework/shared_widgets/base_template/go_back_button.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'view_caretaker_information_page_body.dart';

class ViewCareTakerInformationPage extends StatelessWidget {
  const ViewCareTakerInformationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        navbarConfig: NavbarConfiguration(navbar: GoBackButton()),
        useDefaultPadding: true,
        body: ViewCareTakerInformationPageBody());
  }
}
