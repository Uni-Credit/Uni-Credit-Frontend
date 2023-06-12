import 'package:flutter/cupertino.dart';
import 'package:framework/models/extensions/for_build_context.dart';
import 'package:framework/requests/request_process.dart';

import '../../../../shared_widgets/listing/lazy_load_list.dart';
import '../../../../shared_widgets/listing/listing_model.dart';
import '../../../models/device.dart';
import 'device_list.dart';

class LazyLoadDeviceList extends StatelessWidget {
  final Function(BuildContext)? onAddDevice;
  final LoadListProcess<Device> loadListProcess;
  final Function(BuildContext, Device) selectPatientDevice;

  const LazyLoadDeviceList(
      {Key? key,
      this.onAddDevice,
      required this.selectPatientDevice,
      required this.loadListProcess})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        onAddDevice == null
            ? Container()
            : AddNewDeviceButton(addDevicePress: () => onAddDevice!(context)),
        LazyLoadList(
          loadListProcess: loadListProcess,
          width: context.width,
          height: context.height * 0.6,
          loadListDisplay: LoadListDisplay(builder: () {
            return DevicesList(
                deviceListing: Listing(
                    items: loadListProcess.items.value,
                    onPress: (Device device) =>
                        selectPatientDevice(context, device)));
          }),
        ),
      ],
    );
  }
}
