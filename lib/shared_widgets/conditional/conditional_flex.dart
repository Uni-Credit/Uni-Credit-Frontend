

import 'package:flutter/cupertino.dart';

class ConditionalFlex extends StatelessWidget {

  final Widget child;
  final bool usingFlex;
  final int flex;
  const ConditionalFlex({Key? key, required this.child, required this.usingFlex, required this.flex}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if(!usingFlex) {
      return child;
    }

    return Flexible(
      child: child,
        flex: flex
    );
  }
}
