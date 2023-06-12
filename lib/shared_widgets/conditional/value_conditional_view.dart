import 'package:flutter/cupertino.dart';

class ValueConditionalView<T> extends StatelessWidget {
  final Map<T, Widget> conditionalMap;
  final T value;
  final Widget defaultValue;
  const ValueConditionalView(
      {Key? key,
      required this.value,
      required this.defaultValue,
      required this.conditionalMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return conditionalMap[value] ?? defaultValue;
  }
}
