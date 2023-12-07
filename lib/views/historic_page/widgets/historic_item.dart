


import 'dart:math';

import 'package:flexible_structures/widgets/display/date_display.dart';
import 'package:flutter/material.dart';
import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:uni_credit/theme/theme_colors.dart';

import '../../../models/system/transaction_model.dart';



class HistoricItem extends StatelessWidget {
  final TransactionModel transactionModel;
  const HistoricItem({super.key, required this.transactionModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow:  [
        /*  BoxShadow(
              color: Colors.purple,
              offset: Offset(2, -2),
              spreadRadius: 0,
              blurRadius: 0),*/
          BoxShadow(
              color: ThemeColors.getActionColor(),
              offset: Offset(0,4),
              spreadRadius: 0,
              blurRadius: 0)
        ]
      ),
      child: CardButtonV1(
          backgroundColor: ThemeColors.getFirstOverlayBackground(),

          borderRadius: 10,
          width: CardDimension(
            size: (context.width *0.8),
          ),
          height: CardDimension(
            size: 120,

          ),

          cardIntention: CardIntention.display,
         /* trailingIcon: CardIconData(
            size: 0,
            iconFlex: 0
          ),*/
          title: CardTextContent(
        content: Row(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(transactionModel.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,

                    ),
                    ),
                  ),
                  Spacer(),
                  Expanded(child: DateDisplay(time: transactionModel.dateTime)),

                ],
              ),
            ),

            Spacer(flex: 1,),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    color: ThemeColors.getVibrantGreen(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                      vertical: 6),
                      child: Text('\$'+transactionModel.transactionValue.toString()),
                    ),
                  )
                ],
              ),
            )
          ],
        )
      )),
    );
  }
}
