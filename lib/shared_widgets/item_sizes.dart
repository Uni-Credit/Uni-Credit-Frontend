import 'package:flutter/cupertino.dart';

import 'responsive/media_queries.dart';

enum ItemSize {
  minimal,
  verySmall,
  smallish,
  small,

  normal,
  big,

  large,
  unlimited,
}

extension ItemSizeExtension on ItemSize {
  bool isBigger(ItemSize itemSize) {
    return ItemSize.values.indexOf(this) > ItemSize.values.indexOf(itemSize);
  }

  ItemSize whenMobile(ItemSize mobileSize) {
    return isMobile() ? mobileSize : this;
  }
}

abstract class ItemSizeResolver {
  final ItemSize itemSize;

  ItemSizeResolver(this.itemSize);

  double? resolveWidth(BuildContext context, {dynamic widget});
  double? resolveHeight(BuildContext context, {dynamic widget});
}
