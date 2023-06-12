import 'package:flutter/cupertino.dart';
import 'package:framework/layout_definition/layout.dart';
import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';

class LoginViewLayoutConstruction extends LayoutConstruction {
  final LoginViewBodyLayout elementLayout;
  final LoginConfirmationLayout confirmationLayout;

  LoginViewLayoutConstruction(
      {required this.confirmationLayout, required this.elementLayout});
}

abstract class LoginViewLayout extends Layout<LoginViewLayoutConstruction> {
  const LoginViewLayout({super.key, required super.construction});
}

abstract class LoginViewBodyLayout extends StatelessWidget {
  const LoginViewBodyLayout({super.key});
}

abstract class LoginConfirmationLayout extends StatelessWidget {
  const LoginConfirmationLayout({super.key});
}
