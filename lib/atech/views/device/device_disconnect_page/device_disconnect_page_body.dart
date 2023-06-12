import 'package:framework/atech/models/language_read.dart';
import 'package:framework/atech/protocols/device_protocol.dart';
import 'package:framework/atech/views/device/device_connection_page/widgets/device_id_input.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';
import 'package:framework/shared_widgets/widgets/app_container.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/item_sizes.dart';
import 'device_disconnect_page.dart';

class DeviceDisconnectPageBody extends StatefulWidget {
  final DeviceDisconnectConstruction? construction;

  const DeviceDisconnectPageBody({Key? key, this.construction})
      : super(key: key);

  @override
  State<DeviceDisconnectPageBody> createState() =>
      _DeviceDisconnectPageBodyState();
}

class _DeviceDisconnectPageBodyState extends State<DeviceDisconnectPageBody> {
  final FormValidationController formController = FormValidationController();

  @override
  Widget build(BuildContext context) {
    FormValidatorUtility formUtility = FormValidatorUtility(formController);
    CardButtonV1SizeResolver sizeResolver =
        CardButtonV1SizeResolver(ItemSize.normal);

    return Container(
      width: sizeResolver.resolveWidth(context),
      child: Column(
        children: [
          DeviceIdInput(formUtility: formUtility),
          CardButtonV1(
            title: CardTextContent(
              content: LR.of(context).disconnect,
            ),
            active: formController.getValidationState(),
            pressEnabled: formController.getValidationState(),
            sizePadding: EdgeInsets.only(top: 1),
            onPress: () {
              DeviceProtocol.deviceDisconnection(context: context);
            },
          )
        ],
      ),
    );
  }
}
