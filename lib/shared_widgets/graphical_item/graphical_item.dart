import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

enum Graphical { image, icon, svg }

class GraphicalItem {
  final dynamic item;
  final Graphical type;
  final Map<String, dynamic>? info;

  GraphicalItem({required this.item, required this.type, this.info});
}

renderIcon(GraphicalItem item,
    {Color? color, double? size, EdgeInsets? padding}) {
  if (item.info != null) {
    color = item.info!['color'] ?? color;
    size = item.info!['size'] ?? size;
    padding = item.info!['padding'] ?? padding;
  }

  Widget element;
  switch (item.type) {
    case Graphical.icon:
      element = Icon(
        item.item,
        color: color,
        size: size,
      );
      break;
    case Graphical.svg:
      if (item.item is Widget) {
        element = item.item;
        break;
      }
      element = SvgPicture.asset(
        item.item,
        color: color,
        width: size,
      );
      break;
    case Graphical.image:
      element = Image.asset(item.item);
  }

  return Padding(
    padding: padding ?? EdgeInsets.zero,
    child: element,
  );
}
