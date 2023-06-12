import 'dart:js';

import 'package:auto_route/auto_route.dart';
import 'package:framework/models/extensions/for_auto_router.dart';
import 'package:framework/models/extensions/for_widget.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import '../../../shared_widgets/base_template/go_back_button.dart';
import '../../../shared_widgets/base_template/page_class.dart';
import '../../models/patient.dart';
import 'patient_profile_page_body.dart';

class PatientProfileConstruction {
  Patient patient;
  final Widget? additionalInformation;
  final bool showMetricHistoric;
  final Function()? onShowMetricHistoricClick;
  PatientProfileConstruction(
      {this.additionalInformation,
      required this.patient,
      this.onShowMetricHistoricClick,
      this.showMetricHistoric = true});
}

class PatientProfilePage extends PageClass<PatientProfileConstruction> {
  const PatientProfilePage({Key? key, PatientProfileConstruction? construction})
      : super(key: key, construction: construction);

  static Widget Function(PatientProfileConstruction, BuildContext)?
      patientActionsView;

  @override
  Widget buildWithConstructor(
      BuildContext context, PatientProfileConstruction construction) {
    return TemplateScaffold(
        useDefaultPadding: true,
        navbarConfig: NavbarConfiguration(
          navbar: GoBackButton(),
        ),
        body: PatientProfilePageBody(construction: construction));
  }

  @override
  Widget buildWithoutConstructor(BuildContext context) {
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      context.router.popOr(or: () {
        context.router.pushNamed("dashboard-page");
      });
    });
    return Container();
  }
}
