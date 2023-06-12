import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:framework/atech/views/device/device_listing/summarized_patient_metrics.dart';
import 'package:framework/atech/views/patient_page/metrics_list.dart';
import 'package:framework/models/extensions/for_widget.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/item_sizes.dart';
import 'package:framework/shared_widgets/listing/flexible_listing.dart';
import 'package:framework/shared_widgets/responsive/media_queries.dart';

import '../../../../shared_widgets/popups/confirmation_popup.dart';
import '../../../models/device.dart';
import '../../../models/patient_metrics.dart';

class DeviceItem extends StatefulWidget {
  final Device device;
  final Function() onPress;
  const DeviceItem({Key? key, required this.device, required this.onPress})
      : super(key: key);

  @override
  State<DeviceItem> createState() => _DeviceItemState();
}

class _DeviceItemState extends State<DeviceItem> {
  getBackgroundColor() {
    return {
      MetricStatus.normal: Colors.green,
      MetricStatus.lessThanExpected: Colors.blue,
      MetricStatus.moreThanExpected: Colors.red,
      MetricStatus.nonActive: Colors.grey
    }[widget.device.status];
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black45;
    MediaQuery.of(context).size.width;
    return CardButtonV1(
      //backgroundColor:,
      backgroundColor: Colors.white,
      borderColor: getBackgroundColor(),
      stripColor: getBackgroundColor(),
      usesNeumorphic: true,
      usesInk: false,
      onPress: widget.onPress,
      leadingIcon: isMobile()
          ? null
          : CardIconData(
              iconFlex: 1,
              icon: Icon(
                Icons.person,
                color: textColor,
              )),

      buttonSize: ItemSize.large,
      trailingIcon: CardIconData(
          icon: Icons.highlight_remove,
          color: textColor,
          press: () {
            ConfirmationPopup(
              title: Component(
                  content:
                      ('Tem certeza que quer desativar conexão com este wearable?')),
              buttonColor: CancelConfirmButtons.defaultImportantColors,
              onSelect: (bool confirm) {
                context.router.pop();

                if (confirm) {
                  setState(() {
                    widget.device.status = MetricStatus.nonActive;
                  });
                }
              },
            ).showDialogWithWidget(context);
          }),
      title: CardTextContent(
          flex: 18,
          alignment: Alignment.centerLeft,
          content: FlexibleListing(
            deviceAxis: DeviceOption(
                defaultResult: Axis.vertical, desktop: Axis.horizontal),
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.device.linkedPatient!.patientData.name,
                style: TextStyle(color: textColor, fontSize: 16),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24),
                child: Align(
                    alignment: Alignment.bottomRight,
                    child: MetricsList(
                      metrics: widget.device.metrics!,
                      metricItemSummarized: true,
                      listAxis: DeviceOption(defaultResult: Axis.horizontal),
                    )),
              )
            ],
          )),
    );
  }
}
