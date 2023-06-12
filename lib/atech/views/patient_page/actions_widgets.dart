import 'package:flutter/cupertino.dart';

class ActionsWidgetsList extends StatelessWidget {
  final List<Widget> children;
  const ActionsWidgetsList({required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children
          .map((e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: e,
              ))
          .toList(),
    );
  }
}
