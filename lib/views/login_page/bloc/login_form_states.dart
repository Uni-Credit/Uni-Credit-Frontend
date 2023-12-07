


// States
import 'package:request_states/process/request_process.dart';

abstract class LoginFormState implements RequestStatusProvider {
  @override
  RequestStatus? getStatus() {
    return null;
  }
}


class LoginInitial extends LoginFormState {}
class LoginLoading extends LoginFormState {}

class LoginValid extends LoginFormState {
}

class LoginEnded extends LoginFormState {}

class LoginSuccess extends LoginFormState {
  final Map<String, dynamic> userData;
  LoginSuccess({ required this.userData});
  @override
  RequestStatus? getStatus() {
    return RequestStatus.success;
  }
}

class LoginFailure extends LoginFormState {
  final String error;
  LoginFailure({required this.error});

  @override
  RequestStatus? getStatus() {
    return RequestStatus.invalid;
  }
}


class LoginBackendFailure extends LoginFormState {

  final String error;
  final Map<String, dynamic>? resultReceived;

  LoginBackendFailure({required this.error, this.resultReceived});

  @override
  RequestStatus? getStatus() {
    return RequestStatus.error;
  }
}