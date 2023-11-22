import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:framework/models/bloc/listenable_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../../models/singletons/user_session/session_saver.dart';
import '../data/interactors/login_interactor.dart';
import '../data/models/user_credentials.dart';
import 'login_form_events.dart';
import 'login_form_states.dart';

// Events

// Bussness Logic Component
class LoginFormBloc extends ListenableBloc<LoginFormEvent, LoginFormState> {


  LoginFormInteractor loginFormInteractor;

  Map<String, dynamic>? _formData = null;
  bool _loginIsValid = false;

  // on<Event> -> handler
  LoginFormBloc({required this.loginFormInteractor,}) :
        super(LoginInitial()) {

    on<LoginFormSubmitted>((event, emit) async => (
        await _authenticate(emit)));

    on<LoginFormInteracted>((event, emit) =>
        _readFormInteraction(event, emit)
    );

    on<EndLogin>((event, emit) => _loginEnd(emit, event));
  }


  bool loginIsValid() {
    return _loginIsValid;
  }

  void _readFormInteraction(LoginFormInteracted event, Emitter<LoginFormState> emit) {

    _loginIsValid = event.valid;

    emit(state is LoginFailure ? LoginInitial() :
    (_loginIsValid ? LoginValid() : (
        state is LoginValid ? LoginInitial() : state
    )));

    _formData = event.formData;
  }

  void _loginEnd(Emitter<LoginFormState> emit, EndLogin event) async {

    await GetIt.I.get<SessionSource>().saveSession(event.confirmedUserCredentials);
    emit(LoginEnded());
  }


  Future<void> _authenticate(Emitter<LoginFormState> emit) async {

    // Muda o estado pra carregando
    emit(LoginLoading());

    if(_formData == null) {
      emit(LoginInitial());
      return;
    }

    UserCredentials userCredentials = UserCredentials.fromJson(_formData!);

    final backendResponse = await loginFormInteractor
        .loginUserCredentials(userCredentials);

    // backend success -> state login success
    // backend failure -> state login failure



    if(backendResponse.positiveStatus == false) {
      String error = backendResponse.message;

      if(error.isEmpty) {
        error = 'Erro desconhecido';
      }

      emit(
          backendResponse.isSystemFailure ?
          LoginBackendFailure(error: error + " no sistema") :
          LoginFailure(error: error  ) );
      return;
    }

    bool sessionDataIsCorrect =
    GetIt.I.get<SessionSource>().isValidSessionData(backendResponse.data);

    if(!sessionDataIsCorrect) {
      emit(LoginBackendFailure(error: 'Dados de sessão não foram recebidos '
          'corretamente',
        resultReceived: backendResponse.data,
      ));
      return;
    }

    LoginFormState state =
    LoginSuccess(userData: backendResponse.data)
    ;

    emit(state);
  }




}