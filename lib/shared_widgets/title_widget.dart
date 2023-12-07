import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({Key? key, required   this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(title,

    style: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white
    ),
    );
  }
}
