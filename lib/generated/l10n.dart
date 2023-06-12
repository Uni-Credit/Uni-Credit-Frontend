// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Testing in english`
  String get test {
    return Intl.message(
      'Testing in english',
      name: 'test',
      desc: '',
      args: [],
    );
  }

  /// `Select your language!`
  String get selectLanguageTitle {
    return Intl.message(
      'Select your language!',
      name: 'selectLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Forgot my password`
  String get forgotPassword {
    return Intl.message(
      'Forgot my password',
      name: 'forgotPassword',
      desc: '',
      args: [],
    );
  }

  /// `Insert`
  String get insertAction {
    return Intl.message(
      'Insert',
      name: 'insertAction',
      desc: '',
      args: [],
    );
  }

  /// `Confirm login`
  String get confirmLogin {
    return Intl.message(
      'Confirm login',
      name: 'confirmLogin',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirmAction {
    return Intl.message(
      'Confirm',
      name: 'confirmAction',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get registerAccount {
    return Intl.message(
      'Register',
      name: 'registerAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get invalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get waitFor {
    return Intl.message(
      'Loading...',
      name: 'waitFor',
      desc: '',
      args: [],
    );
  }

  /// `Insert device ID`
  String get insertDeviceId {
    return Intl.message(
      'Insert device ID',
      name: 'insertDeviceId',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Disconnect`
  String get disconnect {
    return Intl.message(
      'Disconnect',
      name: 'disconnect',
      desc: '',
      args: [],
    );
  }

  /// `device`
  String get device {
    return Intl.message(
      'device',
      name: 'device',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `administrator`
  String get administrator {
    return Intl.message(
      'administrator',
      name: 'administrator',
      desc: '',
      args: [],
    );
  }

  /// `patient`
  String get patient {
    return Intl.message(
      'patient',
      name: 'patient',
      desc: '',
      args: [],
    );
  }

  /// `familiar`
  String get familiar {
    return Intl.message(
      'familiar',
      name: 'familiar',
      desc: '',
      args: [],
    );
  }

  /// `health professional`
  String get healthProfessional {
    return Intl.message(
      'health professional',
      name: 'healthProfessional',
      desc: '',
      args: [],
    );
  }

  /// `institution administrator`
  String get institutionAdministrator {
    return Intl.message(
      'institution administrator',
      name: 'institutionAdministrator',
      desc: '',
      args: [],
    );
  }

  /// `administrators`
  String get administrators {
    return Intl.message(
      'administrators',
      name: 'administrators',
      desc: '',
      args: [],
    );
  }

  /// `patients`
  String get patients {
    return Intl.message(
      'patients',
      name: 'patients',
      desc: '',
      args: [],
    );
  }

  /// `familiars`
  String get familiars {
    return Intl.message(
      'familiars',
      name: 'familiars',
      desc: '',
      args: [],
    );
  }

  /// `health professionals`
  String get healthProfessionals {
    return Intl.message(
      'health professionals',
      name: 'healthProfessionals',
      desc: '',
      args: [],
    );
  }

  /// `institution administrators`
  String get institutionAdministrators {
    return Intl.message(
      'institution administrators',
      name: 'institutionAdministrators',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
