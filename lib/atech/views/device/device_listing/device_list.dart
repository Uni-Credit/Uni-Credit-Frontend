import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/card_button/icon_action_card_button.dart';
import 'package:framework/shared_widgets/listing/listing_model.dart';
import '../../../models/device.dart';
import 'device_item.dart';

class DevicesList extends StatelessWidget {
  final Listing<Device> deviceListing;
  final Function()? addDevicePress;
  const DevicesList(
      {Key? key, required this.deviceListing, this.addDevicePress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      addDevicePress == null
          ? Container()
          : AddNewDeviceButton(addDevicePress: addDevicePress),
      ...deviceListing.items
          .map((device) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: DeviceItem(
                  onPress: () => deviceListing.onPress(device),
                  device: device,
                ),
              ))
          .toList()
    ]);
  }
}

class AddNewDeviceButton extends StatelessWidget {
  const AddNewDeviceButton({
    super.key,
    required this.addDevicePress,
  });

  final Function()? addDevicePress;

  @override
  Widget build(BuildContext context) {
    return IconActionCardButton(
      numberOfIcons: 1.5,
      icon: Row(
        children: [
          NeumorphicIcon(Icons.add),
          NeumorphicIcon(Icons.watch),
        ],
      ),
      onPress: addDevicePress,
      content: 'Conectar a dispositivo',
      forceMobile: true,
    );
  }
}
