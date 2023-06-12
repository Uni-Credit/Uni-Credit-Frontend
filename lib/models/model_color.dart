import 'dart:ui';

class ModelColor {
  Color color;
  late Color contrast;

  ModelColor({required this.color, Color? contrastColor}) {
    contrast = contrastColor ?? color;
  }
}
