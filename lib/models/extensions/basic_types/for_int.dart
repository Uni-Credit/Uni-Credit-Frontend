import 'package:intl/intl.dart';

NumberFormat formatter = new NumberFormat("00");

extension IntExtension on int {
  String leadZero() {
    return formatter.format(this);
  }
}
