


import 'package:uni_credit/models/singletons/user_session/preferences_session_source.dart';

import 'session_saver.dart';

// simple instantiation
SessionSource getUserSession() {
  return UniCreditTemporaryUserSession(
    sessionDataManager: PreferencesSessionSource(),
  );
}

// Saves session data with a strategic source of data manager
// May define user type behaviour differentiation and validation
class UniCreditTemporaryUserSession implements SessionSource {

  Map<String, dynamic>? userInformation;

  // Decorator pattern
  SessionSource sessionDataManager;

  UniCreditTemporaryUserSession({
    required this.sessionDataManager,
  });

  @override
  bool isValidSessionData(Map<String, dynamic> confirmedSession) {
    return
      confirmedSession.isNotEmpty &&
      sessionDataManager.isValidSessionData(confirmedSession);
  }

  @override
  saveSession(confirmedSession) async {

    userInformation = confirmedSession;

    sessionDataManager.saveSession(userInformation!);

  }

  loadSession() async {
    return sessionDataManager.loadSession();
  }

  @override
  Future<bool> hasActiveSession() async {
    return userInformation != null;
  }

  @override
  void clearSession() {
    userInformation = null;
    sessionDataManager.clearSession();
  }




}



