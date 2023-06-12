import 'package:dio/dio.dart';

import '../../../models/device.dart';
import '../../../requests/backend_response.dart';

class DeviceConnectionController {
  final Device device;
  DeviceConnectionController({required this.device});
  //

  Future<BackendResponse> connectDevice() async {
    await Future.delayed(Duration(seconds: 2));
    device.connectionStatus = DeviceConnected.connected;
    Response response =
        Response(requestOptions: RequestOptions(), statusCode: 200);
    return BackendResponse(response);
  }
}
