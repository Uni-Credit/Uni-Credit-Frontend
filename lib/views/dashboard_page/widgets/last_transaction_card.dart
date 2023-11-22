

import 'package:flutter/cupertino.dart';
import 'package:uni_credit/theme/theme_colors.dart';

class LastTransactionCard extends StatelessWidget {
  const LastTransactionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.getDark(),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical:6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Ultima Transação'),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.0),
                  child: Text('CC - 12,40'),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6.0),
                  child: Text('Há 12 horas'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
