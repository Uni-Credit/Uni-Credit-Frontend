import 'package:flutter/cupertino.dart';

import 'entrance_actions_controller.dart';

abstract class EntranceActionsLayout extends StatelessWidget {
  final EntranceActionsController actionsController;

  const EntranceActionsLayout({super.key, required this.actionsController});
}
