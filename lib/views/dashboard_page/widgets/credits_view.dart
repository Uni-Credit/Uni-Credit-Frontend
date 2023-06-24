

import 'package:flutter/cupertino.dart';
import 'package:uni_credit/theme/theme_colors.dart';

class CreditView extends StatelessWidget {
  const CreditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      color: ThemeColors.getGreen(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Text('XXX.XXX', style: TextStyle(
          color: ThemeColors.getLightGreen(),
          fontSize: 32
        ),),
      ),
    );
  }
}
