import 'package:flutter/cupertino.dart';

class InputSpacer extends StatelessWidget {
  final double multiply;
  const InputSpacer({Key? key, this.multiply=1 }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 32 * multiply;
    return SizedBox(
      width: size,
      height: size,
    );
  }
}
