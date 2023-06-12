import 'package:framework/atech/models/device.dart';
import 'package:framework/atech/models/patient.dart';
import 'package:framework/shared_widgets/base_template/go_back_button.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'actions_widgets.dart';
import 'patient_page_body.dart';

class ViewPatientConstruction {
  final Widget? actionsWidget;
  final Widget? demonstrativeWidget;
  final Device device;
  ViewPatientConstruction(
      {this.demonstrativeWidget, required this.device, this.actionsWidget});
}

class ViewPatientPage extends StatelessWidget {
  final ViewPatientConstruction construction;
  const ViewPatientPage({Key? key, required this.construction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        useDefaultPadding: true,
        navbarConfig: NavbarConfiguration(navbar: GoBackButton()),
        body: PatientPageBody(construction: construction));
  }
}
