

import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/routes/router.gr.dart';
import 'package:uni_credit/shared_widgets/card_button/icon_action_card_button.dart';
import 'package:uni_credit/theme/theme_colors.dart';

class DashboardButtons extends StatelessWidget {
  const DashboardButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeColors.getDarkGreen(),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconActionCardButton(content: 'Transacionar', icon: Icon(Icons.credit_card_sharp),
            backgroundColor: ThemeColors.getButtonColor(),// ThemeColors.getVibrantGreen(),
            onPress: (){
              context.router.push(Transaction());
            },),
            IconActionCardButton(content: 'Histórico', icon: Icon(Icons.file_present),
            backgroundColor: ThemeColors.getButtonColor(),//ThemeColors.getVibrantBlue(),
              onPress: (){

                context.router.push(Historic( ));
              },),
            IconActionCardButton(content: 'Configurações', icon: Icon(Icons.settings),
            backgroundColor: ThemeColors.getButtonColor(),//ThemeColors.getVibrantOrange(),
              onPress: (){
                context.router.push(Configuration());
              },),

          ],
        ),
      ),
    );
  }
}
