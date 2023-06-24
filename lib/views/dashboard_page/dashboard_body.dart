


import 'package:flutter/cupertino.dart';
import 'package:uni_credit/models/extensions/for_build_context.dart';
import 'package:uni_credit/views/dashboard_page/widgets/credits_view.dart';
import 'package:uni_credit/views/dashboard_page/widgets/last_transaction_card.dart';
import 'package:uni_credit/views/dashboard_page/widgets/profile_icon.dart';

import 'widgets/dashboard_buttons.dart';

class DashboardBody extends StatelessWidget {
  const DashboardBody({super.key});

  static double padding = 8;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(4),
      child: Container(
        width: context.width,
        child: Column(
          children: [
            Padding(
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
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: CreditView(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: padding),
              child: DashboardButtons(),
            ),



          ],
        ),
      ),
    );
  }
}
