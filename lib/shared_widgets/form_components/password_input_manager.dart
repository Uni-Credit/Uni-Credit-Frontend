import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
class PasswordInputConfiguration {
  bool obscuredText;
  IconButton passwordIcon;

}*/

class PasswordInputManager extends StatefulWidget {
  PasswordInputManager(
      {Key? key,
      required this.inputBuilder,
      this.iconSize = 20,
      this.iconItem,
      this.iconColor})
      : super(key: key);

  final Widget Function(bool obscuredText, IconButton passwordIcon)
      inputBuilder;
  final double iconSize;
  final Icon? iconItem;
  final Color? iconColor;
  bool obscureMode = true;
  static IconData eye = Icons.remove_red_eye_outlined;
  static IconData eyeSlash = Icons.remove_red_eye_rounded;

  @override
  State<PasswordInputManager> createState() => _PasswordInputManagerState();
}

class _PasswordInputManagerState extends State<PasswordInputManager> {
  bool obscureMode = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.inputBuilder(
        obscureMode,
        IconButton(
          //focusNode: FocusNode(skipTraversal: true, canRequestFocus: false),
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          iconSize: widget.iconSize,
          onPressed: () {
            setState(() => {obscureMode = !obscureMode});
          },
          icon: widget.iconItem ??
              Icon(
                getIcon(),
                color: widget.iconColor  ?? Theme.of(context).colorScheme.background,
              ),
        ));
  }

  IconData getIcon() {
    return obscureMode
        ? PasswordInputManager.eye
        : PasswordInputManager.eyeSlash;
  }
}
