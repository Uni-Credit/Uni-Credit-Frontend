import 'package:framework/shared_widgets/card_button/icon_action_card_button.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/item_sizes.dart';
import 'package:framework/shared_widgets/listing/flexible_listing.dart';
import 'package:framework/shared_widgets/responsive/media_queries.dart';

import '../../../models/language_read.dart';
import 'entrance_actions_layout.dart';

class IconsEntranceActions extends EntranceActionsLayout {
  const IconsEntranceActions({required super.actionsController, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemSize desktopSize = ItemSize.normal;
    ItemSize mobileSize = ItemSize.normal;
    Color iconColor = Colors.white;
    bool useIconInDesktop = true;

    MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Flexible(
          flex: 6,
          child: FlexibleListing(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            deviceAxis: DeviceOption(
                defaultResult: Axis.vertical, mobile: Axis.horizontal),
            children: [
              Visibility(
                visible: actionsController.usesLogin(),
                child: IconActionCardButton(
                  content: LR.of(context).login,
                  desktopSize: desktopSize,
                  useIconInDesktop: useIconInDesktop,
                  mobileSize: mobileSize,
                  borderColor: Colors.blueAccent,
                  icon: Icon(
                    Icons.door_back_door,
                    color: iconColor,
                  ),
                  onPress: actionsController.onLogin,
                ),
              ),
              Container(
                width: 40,
                height: 20,
              ),
              Visibility(
                visible: actionsController.usesRegister(),
                child: IconActionCardButton(
                  content: LR.of(context).registerAccount,
                  desktopSize: desktopSize,
                  mobileSize: mobileSize,
                  borderColor: Colors.blueAccent,
                  useIconInDesktop: useIconInDesktop,
                  icon: Icon(
                    Icons.person,
                    color: iconColor,
                  ),
                  onPress: actionsController.onRegister,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
      ],
    );
  }
}
