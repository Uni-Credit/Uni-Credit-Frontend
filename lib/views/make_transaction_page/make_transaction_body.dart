


import 'package:flutter/cupertino.dart';
import 'package:uni_credit/shared_widgets/base_template/widgets/card_button_v1.dart';

class MakeTransactionBody extends StatelessWidget {
  const MakeTransactionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        CardButtonV1(title: CardTextContent(content: 'Confirmar'))
      ],
    );
  }
}
