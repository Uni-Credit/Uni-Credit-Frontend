


import 'package:flutter/cupertino.dart';
import 'package:uni_credit/models/extensions/for_build_context.dart';
import 'package:uni_credit/shared_widgets/widgets/title.dart';
import 'package:uni_credit/views/dashboard_page/dashboard_page.dart';
import 'package:uni_credit/views/dashboard_page/widgets/credits_view.dart';
import 'package:uni_credit/views/dashboard_page/widgets/last_transaction_card.dart';
import 'package:uni_credit/views/dashboard_page/widgets/profile_icon.dart';

import '../../models/system/credit.dart';
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
     this.padding= 12,
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
            Flexible(child:
            ProfileIcon(),
            flex: 1,
            ),
            //Spacer(),
            Flexible(
              flex: 3,
              child: LastTransactionCard(),
            )

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

