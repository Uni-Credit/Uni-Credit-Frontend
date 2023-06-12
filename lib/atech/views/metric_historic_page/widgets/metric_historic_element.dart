import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';

import '../../../../shared_widgets/item_sizes.dart';

class MetricHistoricElement extends StatelessWidget {
  final String content;
  final String date;
  const MetricHistoricElement(
      {Key? key, required this.content, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(color: Colors.white);
    return CardButtonV1(
      title: CardTextContent(content: 'Item em histórico'),
      height: CardDimension(itemSize: ItemSize.big),
      subtitle: CardTextContent(
          content: Row(
        children: [
          Text(
            content,
            style: textStyle,
          ),
          Text(
            date,
            style: textStyle,
          ),
        ],
      )),
    );
  }
}
