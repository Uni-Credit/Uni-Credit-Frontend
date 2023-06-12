import 'package:flutter/cupertino.dart';
import 'package:framework/atech/models/language_read.dart';

enum UserType {
  healthProfessional,
  familiar,
  administrator,
  institutionAdministrator,
  patient,
  defaultValue
}

extension UserTypeExtension on UserType {
  string(BuildContext context) {
    return {
      UserType.patient: LR.of(context).patient,
      UserType.administrator: LR.of(context).administrator,
      UserType.familiar: LR.of(context).familiar,
      UserType.healthProfessional: LR.of(context).healthProfessional,
      UserType.institutionAdministrator: LR.of(context).institutionAdministrator
    }[this];
  }

  stringPlural(BuildContext context) {
    return {
      UserType.patient: LR.of(context).patients,
      UserType.administrator: LR.of(context).administrators,
      UserType.familiar: LR.of(context).familiars,
      UserType.healthProfessional: LR.of(context).healthProfessionals,
      UserType.institutionAdministrator:
          LR.of(context).institutionAdministrators
    }[this];
  }

  toKey() {
    return {
      UserType.patient: "",
      UserType.administrator: "",
      UserType.familiar: "",
      UserType.healthProfessional: "HealthcareProfessional",
      UserType.institutionAdministrator: ""
    }[this];
  }
}
