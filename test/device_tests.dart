import 'package:flutter_test/flutter_test.dart';
import 'package:framework/atech/models/device.dart';
import 'package:framework/atech/models/patient_metrics.dart';

void main() {
  test('Given no information, device should believe metric status is unknown',
      () {
    // Assemble
    // Arrange
    Device device = Device.fromMap({});

    //
    expect(device.status, MetricStatus.unknown);
  });
}
