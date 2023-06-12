import 'package:auto_route/auto_route.dart';

extension RouterStackExtension on StackRouter {
  popOr({required Function() or}) async {
    if (await pop()) {
      return;
    }

    or();
  }
}
