import 'package:flutter/cupertino.dart';
import 'package:framework/atech/models/language_read.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        LR.of(context).login,
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
      ),
    );
  }
}
