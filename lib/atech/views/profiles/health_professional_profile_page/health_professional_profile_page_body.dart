import 'package:framework/shared_widgets/widgets/app_container.dart';
import 'package:flutter/material.dart';

import 'health_professional_profile_page.dart';

class HealthProfessionalProfilePageBody extends StatelessWidget {
  final HealthProfessionalProfileConstruction construction;

  const HealthProfessionalProfilePageBody(
      {Key? key, required this.construction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HealthProfessionalInformation(construction: construction);
  }
}

class HealthProfessionalInformation extends StatelessWidget {
  const HealthProfessionalInformation({
    super.key,
    required this.construction,
  });

  final HealthProfessionalProfileConstruction construction;

  @override
  Widget build(BuildContext context) {
    return Text(construction.professional.name);
  }
}
