import 'package:flutter/cupertino.dart';

class ListenerWidget extends StatefulWidget {
  final Listenable listenable;
  final Widget child;
  final Function() onUpdate;
  const ListenerWidget(
      {Key? key,
      required this.listenable,
      required this.child,
      required this.onUpdate})
      : super(key: key);

  @override
  State<ListenerWidget> createState() => _ListenerWidgetState();
}

class _ListenerWidgetState extends State<ListenerWidget> {
  update() {
    widget.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    widget.listenable.addListener(update);
  }

  @override
  void dispose() {
    super.dispose();
    widget.listenable.removeListener(update);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
