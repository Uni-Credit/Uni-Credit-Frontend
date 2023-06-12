import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:framework/atech/requests/backend_response.dart';
import 'package:framework/atech/requests/device_requests.dart';
import 'package:framework/models/extensions/for_response.dart';
import 'package:framework/models/extensions/for_widget.dart';
import 'package:framework/requests/caller/arguments/list_argument_caller.dart';
import 'package:framework/requests/request_process.dart';

import '../../shared_widgets/popups/confirmation_popup.dart';
import '../../shared_widgets/popups/informative_popup.dart';
import '../../shared_widgets/popups/response_popup.dart';
import '../models/device.dart';
import '../models/patient_metrics.dart';
import '../views/device/device_connection_page/device_connection_controller.dart';

class DeviceProtocol {
  static Future<BackendResponse> loadDevices({
    required ListArgumentCaller? argument,
    required RequestStatusActionMapper? mapper,
    Function()? listReturnedEmpty,
    Function(Device)? listReturnedSingle,
    Function(BackendResponse)? listReturnedCompleted,
  }) async {
    BackendResponse response = await DeviceRequests.loadDevicesVisibleToUser(
      argument: argument,
    );

    List devices = response.data;

    if (!response.positiveStatus) {
      debugPrint("status negative!");
      mapper?.mapAction(status: RequestStatus.error, data: response);
      return response;
    }

    debugPrint("status positive!");
    mapper?.mapAction(status: RequestStatus.success, data: response);

    debugPrint("list return empty?");
    if (devices.isEmpty && listReturnedEmpty != null) {
      listReturnedEmpty();
      return response;
    }

    debugPrint("list return one?");

    if (devices.length == 1 && listReturnedSingle != null) {
      listReturnedSingle(devices[0]);
      return response;
    }

    debugPrint("list return all?");
    if (listReturnedCompleted != null) {
      listReturnedCompleted(response);
      return response;
    }

    return response;
  }

  static deviceConnection({required BuildContext context, connectWithUser}) {
    Device device = Device(
        status: MetricStatus.unknown,
        connectionStatus: DeviceConnected.notConnected);
    DeviceConnectionController connectionController =
        DeviceConnectionController(device: device);

    ResponsePopup(
      requestProcess: RequestProcess(connectionController.connectDevice(),
          StatusResolver.requestStatusResolver),
      successBuilder: (context, body) {
        if (connectionController.device.connectionStatus ==
            DeviceConnected.connected) {
          if (connectWithUser == null) {
            return InformativePopup(
              title: 'Conectado!',
              onClickAfterClosed: () {
                context.router.pop();
              },
            );
          }

          return ConfirmationPopup<bool>(
            title: Component(content: 'Anexar paciente ao dispositivo agora?'),
            onSelect: (selected) async {
              await context.router.pop();
              if (selected) {
                connectWithUser!(device);
              }
            },
          );
        }

        return InformativePopup(
          title: 'Não foi possível conectar.',
        );
      },
    ).showDialogWithWidget(context);
  }

  static void deviceDisconnection({required BuildContext context}) {
    //
  }
}
