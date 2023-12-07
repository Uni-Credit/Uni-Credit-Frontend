

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/icon_action_card_button.dart';
import 'package:uni_credit/routes/router.gr.dart';
import 'package:uni_credit/theme/theme_colors.dart';
import 'package:uni_credit/views/make_transaction_page/make_transaction_page.dart';

import '../../../models/system/credit.dart';


enum CreditViewMode {
  singleCredit,
  manyCredits
}



class CreditView extends StatelessWidget {
  final CreditViewMode viewMode;
  final Credit credit;
  const CreditView({super.key, this.viewMode=CreditViewMode.manyCredits, required this.credit});

  @override
  Widget build(BuildContext context) {

    double cardHeight = 110;

    double cardTotalSize = min(280 + 80, context.width);

    double proportion = 0.74;
    if(viewMode == CreditViewMode.manyCredits) {
      return Row(
     //   mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Container(

              height: cardHeight,
              decoration: BoxDecoration(
                  color: cardColor(),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(radiusValue()),
                  bottomLeft: Radius.circular(radiusValue()),

                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(credit.name,
                  style: TextStyle(
                    fontSize: 20
                  ),),
                  Text(credit.value.toString(),
                  style: TextStyle(  fontWeight: FontWeight.bold,
                  fontSize: 28
                  ),),
                ],
              ),
            ),
          ),

          Padding(padding: EdgeInsets.only(left: 4)),

          Expanded(
            flex: 1,
            child: Container(
              height: cardHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(radiusValue()),
                  bottomRight: Radius.circular(radiusValue()),

                ),

                color: cardColor(),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconActionCardButton(
                    backgroundColor: ThemeColors.getActionColor(),
                    content: 'Transação',
                      icon: Icon(Icons.credit_card),
                  onPress: (){
                    Transaction(
                      construction: MakeTransactionConstruction(
                        credit: credit
                      )
                    ).push(context);
                  },
                  ),
                  Container(
                    height: 6,
                  ),
                  IconActionCardButton(
                    backgroundColor: ThemeColors.getActionColor(),

                    content: 'Anúncios',
                      icon: Icon(Icons.email),
                    onPress: (){
                      AnnouncementRoute().push(context);
                    },
                  ),

                ],
              ),
            ),
          )

        ],
      );
    }

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

  BorderRadius getBorderRadius() => BorderRadius.all(Radius.circular(radiusValue()));

  double radiusValue() => 12;

  cardColor() => ThemeColors.cardColor();
}
