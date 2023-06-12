import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'device_disconnect_page_body.dart';

class DeviceDisconnectConstruction {}

class DeviceDisconnectPage extends StatelessWidget {
  final DeviceDisconnectConstruction? construction;

  const DeviceDisconnectPage({Key? key, this.construction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TemplateScaffold(
        body: DeviceDisconnectPageBody(construction: construction));
  }
}
