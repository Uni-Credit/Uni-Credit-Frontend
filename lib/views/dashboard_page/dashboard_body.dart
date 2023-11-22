


import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/models/extensions/for_build_context.dart';
import 'package:framework/shared_widgets/card_button/icon_action_card_button.dart';
import 'package:framework/shared_widgets/widgets/title.dart';
import 'package:uni_credit/views/dashboard_page/dashboard_page.dart';
import 'package:uni_credit/views/dashboard_page/widgets/credits_view.dart';
import 'package:uni_credit/views/dashboard_page/widgets/last_transaction_card.dart';


import '../../models/system/credit.dart';
import '../../routes/router.gr.dart';
import '../../theme/theme_colors.dart';
import 'widgets/dashboard_buttons.dart';

class DashboardBody extends StatelessWidget {
  final DashboardConstruction construction;
  const DashboardBody({super.key, required this.construction, });

  static double padding = 8;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(4),
      child: Container(
        width: context.width,
        child: Column(
          children: [
            //DashboardAppbar(padding: padding),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: TitleWidget(title: 'Créditos',

              ),
            ),
            CreditList(
              credits: construction.userInformation?.credits ??[],
            ),

            /*

            Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: DashboardButtons(),
            ),*/



          ],
        ),
      ),
    );
  }
}

class DashboardAppbar extends StatelessWidget {
  const DashboardAppbar({
    super.key,
     this.padding= 0,
  });

  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Container(
        height: 64,
        child: Row(
          children: [
            /*Flexible(child:
            ProfileIcon(),
            flex: 1,
            ),*/
            //Spacer(),
            Flexible(
              flex: 30,
              child: LastTransactionCard(),
            ),

            Spacer(flex: 1,),
            Flexible(
              flex: 8,
              child: IconActionCardButton(content: 'Configurações',
                icon: Icon(Icons.settings, size: 32 ,),
                iconSize: 60,
                  cardWidth: 120,
                backgroundColor: ThemeColors.getButtonColor(),//ThemeColors.getVibrantOrange(),
                onPress: (){
                  context.router.push(Configuration());
                },),
            ),

            Spacer(flex: 1,),

          ],
        ),
      ),
    );
  }
}


class CreditList extends StatelessWidget {
  final List<Credit> credits;
  const CreditList({super.key, required this.credits});

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        for(Credit credit in credits)
          Padding(
            padding: EdgeInsets.only(top: 16),
            child: CreditView(
              credit: credit,
            ),
          )
      ],
    );
  }
}

