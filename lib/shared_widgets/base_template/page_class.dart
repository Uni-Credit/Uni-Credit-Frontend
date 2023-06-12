import 'package:flutter/cupertino.dart';

abstract class PageClass<T> extends StatelessWidget {
  final T? construction;

  const PageClass({Key? key, this.construction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (construction != null) {
      return buildWithConstructor(context, construction as T);
    }

    return buildWithoutConstructor(context);
  }

  Widget buildWithConstructor(BuildContext context, T construction);
  Widget buildWithoutConstructor(BuildContext context);
}
