import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/router_controller.dart';

abstract class ApplicationInterfacer {
  void buildPage();
  String getName();

  static int _id = 0;
  late int id;
  ApplicationInterfacer() {
    id = _id;
    _id++;
  }

  RouterController getRouterController();

  int getAmmountOfPages() {
    RouterController routerController = getRouterController();
    return routerController.getRoutes().length;
  }

  String? getIcon() {
    return null;
  }

  Color getRelatedColor() {
    return Colors.blueAccent;
  }
}
