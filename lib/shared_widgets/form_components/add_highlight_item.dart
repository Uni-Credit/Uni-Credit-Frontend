import 'package:flutter/cupertino.dart';

import '../widgets/highlighted_text.dart';

class AddHighlightItem extends StatelessWidget {
  final Function() onPress;
  final String label;
  const AddHighlightItem({Key? key, required this.onPress, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double topPadding = 20.0;

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 270),
            child: HighlightedText(
              topPadding: 0,
              onPressed: onPress,
              display: label,
              textStyle: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
