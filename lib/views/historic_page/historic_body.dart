


import 'package:flutter/cupertino.dart';
import 'package:uni_credit/models/system/transaction_model.dart';
import 'package:uni_credit/views/historic_page/widgets/historic_item.dart';

class HistoricBody extends StatelessWidget {
  const HistoricBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        for(TransactionModel transaction in [
          TransactionModel(name: 'RU 1',
              dateTime: DateTime(
                2023, 06, 06, 12, 32
              ), transactionValue: 3),
          TransactionModel(name: 'RU 2',
              dateTime: DateTime(
                2023, 06, 05, 13, 32
              ), transactionValue: 3),

        ])
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: HistoricItem(transactionModel: transaction),
          )

 ]
    );
  }
}
