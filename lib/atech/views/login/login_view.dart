import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/atech/views/login/layouts/login_view_layout.dart';
import 'package:framework/models/extensions/for_build_context.dart';

import 'login_form.dart';
import 'login_title.dart';

class LoginView extends LoginViewLayout {
  const LoginView({Key? key, required super.construction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: SizedBox(
        height: context.height * 0.8,
        width: context.width * 0.4,
        child: Column(
          children: [
            LoginTitle(),
            Flexible(child: construction.elementLayout),
            construction.confirmationLayout
          ],
        ),
      ),
    );
  }
}
