import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';

enum ProfileAccessDisplay { profileIcon, button }

class ProfileAccessWidget extends StatelessWidget {
  final Function()? onPress;
  final ProfileAccessDisplay accessDisplay;
  const ProfileAccessWidget(
      {Key? key,
      this.accessDisplay = ProfileAccessDisplay.button,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 24;

    Widget widget = CircleAvatar(
        radius: size,
        backgroundColor: Colors.blueAccent,
        child: Icon(Icons.person, size: size));

    widget = MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPress ?? () {},
        child: widget,
      ),
    );

    if (accessDisplay == ProfileAccessDisplay.button) {
      widget = CardButtonV1(
          onPress: onPress,
          title: CardTextContent(content: "Perfil de paciente"));
    }

    return Padding(
      padding: const EdgeInsets.only(right: 12.0),
      child: widget,
    );
  }
}
