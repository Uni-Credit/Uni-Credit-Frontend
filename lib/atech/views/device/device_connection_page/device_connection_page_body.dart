import 'package:auto_route/auto_route.dart';
import 'package:framework/atech/models/device.dart';
import 'package:framework/atech/models/language_read.dart';
import 'package:framework/atech/models/patient_metrics.dart';
import 'package:framework/atech/protocols/device_protocol.dart';
import 'package:framework/atech/views/device/device_connection_page/widgets/device_id_input.dart';
import 'package:framework/models/extensions/for_widget.dart';
import 'package:framework/requests/request_process.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';
import 'package:framework/shared_widgets/form_components/linked_text_input.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/form_components/validation_form_controller.dart';
import 'package:framework/shared_widgets/item_sizes.dart';

import 'device_connection_page.dart';

class DeviceConnectionPageBody extends StatefulWidget {
  final DeviceConnectionConstruction construction;
  DeviceConnectionPageBody({Key? key, required this.construction})
      : super(key: key);

  @override
  State<DeviceConnectionPageBody> createState() =>
      _DeviceConnectionPageBodyState();
}

class _DeviceConnectionPageBodyState extends State<DeviceConnectionPageBody> {
  final FormValidationController formController = FormValidationController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    formController.onValidationChange((isValid) {
      setState(() {});
    });
  }

  void confirmDeviceConnectAction(BuildContext context) async {
    DeviceProtocol.deviceConnection(
        context: context,
        connectWithUser: widget.construction.toConnectWithUser);
  }

  @override
  Widget build(BuildContext context) {
    FormValidatorUtility formUtility = FormValidatorUtility(formController);

    CardButtonV1SizeResolver sizeResolver =
        CardButtonV1SizeResolver(ItemSize.normal);

    return Padding(
      padding: const EdgeInsets.only(top: 48.0),
      child: Container(
        width: sizeResolver.resolveWidth(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DeviceIdInput(formUtility: formUtility),
            CardButtonV1(
              title: CardTextContent(
                content: LR.of(context).add,
              ),
              active: formController.getValidationState(),
              pressEnabled: formController.getValidationState(),
              sizePadding: EdgeInsets.only(top: 1),
              onPress: () {
                confirmDeviceConnectAction(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
