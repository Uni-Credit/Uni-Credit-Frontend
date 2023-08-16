

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/theme/theme_colors.dart';

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


    if(viewMode == CreditViewMode.manyCredits) {
      return Container(

        width: 210,
        height: 110,
        decoration: BoxDecoration(
            color: ThemeColors.getSpecialColor(),
          borderRadius: BorderRadius.all(Radius.circular(12))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(credit.name),
            Text(credit.value.toString(),
            style: TextStyle(color: ThemeColors.getDark(), fontWeight: FontWeight.bold,
            fontSize: 20
            ),),
          ],
        ),
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
}
