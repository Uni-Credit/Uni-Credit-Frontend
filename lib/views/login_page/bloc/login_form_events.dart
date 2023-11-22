



import '../data/models/user_credentials.dart';

abstract class LoginFormEvent {}

class LoginFormInteracted extends LoginFormEvent {
  final Map<String, dynamic> formData;
  final bool valid;
  LoginFormInteracted({required this.formData, required this.valid,});
}

class EndLogin extends LoginFormEvent {
  final Map<String, dynamic> confirmedUserCredentials;
  EndLogin({
    required this.confirmedUserCredentials,
  });
}

class LoginFormSubmitted extends LoginFormEvent {
  LoginFormSubmitted();
}


