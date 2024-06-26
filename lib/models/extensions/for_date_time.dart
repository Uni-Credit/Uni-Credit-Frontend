import 'package:uni_credit/models/extensions/basic_types/for_int.dart';

extension DateTimeExtension on DateTime {
  String toAmericanDisplay() {
    return "${year.leadZero()}-${month.leadZero()}-${day.leadZero()}";
  }
}
