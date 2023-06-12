import 'package:framework/atech/models/health_professional.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'health_professional_profile_page_body.dart';

class HealthProfessionalProfileConstruction {
  final HealthProfessional professional;
  HealthProfessionalProfileConstruction({
    required this.professional,
  });
}

class HealthProfessionalProfilePage extends StatelessWidget {
  final HealthProfessionalProfileConstruction construction;

  const HealthProfessionalProfilePage({Key? key, required this.construction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        body: HealthProfessionalProfilePageBody(construction: construction));
  }
}
