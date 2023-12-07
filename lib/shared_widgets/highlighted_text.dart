import 'package:flutter/material.dart';


enum HighlightType {
  normal, subtle
}

class HighlightedText extends StatelessWidget {


  final Function() onPressed;
  final HighlightType highlightType;
  final String display;
  const HighlightedText({Key? key,

  required this.onPressed,
     this.highlightType = HighlightType.normal,
    required  this.display,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      display,
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight:
        highlightType == HighlightType.normal ?
            FontWeight.normal :
        FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
