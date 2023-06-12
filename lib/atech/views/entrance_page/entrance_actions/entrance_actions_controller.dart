// Controls which actions must be displayed
abstract class EntranceActionsController {
  void onLogin();
  void onRegister();
  bool usesLogin();
  bool usesRegister();
}
