


import 'package:flutter/cupertino.dart';
import 'package:uni_credit/shared_widgets/item_sizes.dart';

class AppLogo extends StatelessWidget {
  final ItemSize itemSize;
  const AppLogo({
    this.itemSize=ItemSize.normal,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset('assets/logo.png',
    height: itemSize == ItemSize.small ? 100 : 160,
      fit: BoxFit.fill,
    );
  }
}
