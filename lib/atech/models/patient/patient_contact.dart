import '../../../models/field.dart';

class PatientContact {
  Field userEmail;
  Field userTelephone;

  PatientContact({required this.userEmail, required this.userTelephone});

  static String emailKey = 'email';
  static String telephoneKey = 'telephone';

  static PatientContact fromMap(item) {
    return PatientContact(
        userEmail: Field(item?[emailKey], whenNull: 'Desconhecido'),
        userTelephone: Field(item?[telephoneKey], whenNull: 'Desconhecido'));
  }
}
