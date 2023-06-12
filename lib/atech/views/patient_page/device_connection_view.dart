import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/atech/models/device.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';

class DeviceConnectionView extends StatelessWidget {
  final Device device;
  const DeviceConnectionView({Key? key, required this.device})
      : super(key: key);

  Color getBackgroundColor() {
    return {
          DeviceConnected.connected: Colors.lightGreen,
          DeviceConnected.connectionHasProblems: Colors.yellowAccent,
          DeviceConnected.notConnected: Colors.blueAccent,
          DeviceConnected.notIdentified: Colors.redAccent,
        }[device.connectionStatus] ??
        Colors.grey;
  }

  @override
  Widget build(BuildContext context) {
    return CardButtonV1(
        backgroundColor: getBackgroundColor(),
        title: CardTextContent(
          content: Icon(Icons.add),
        ),
        borderShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))));
  }
}
