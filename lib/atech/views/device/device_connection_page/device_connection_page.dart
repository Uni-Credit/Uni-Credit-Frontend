import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';

import '../../../../shared_widgets/base_template/go_back_button.dart';
import '../../../models/device.dart';
import 'device_connection_page_body.dart';

class DeviceConnectionConstruction {
  final Function(Device)? toConnectWithUser;

  DeviceConnectionConstruction({
    this.toConnectWithUser,
  });
}

class DeviceConnectionPage extends StatelessWidget {
  final DeviceConnectionConstruction construction;
  const DeviceConnectionPage({Key? key, required this.construction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        navbarConfig: NavbarConfiguration(
          navbar: GoBackButton(),
        ),
        useDefaultPadding: true,
        body: DeviceConnectionPageBody(construction: construction));
  }
}
