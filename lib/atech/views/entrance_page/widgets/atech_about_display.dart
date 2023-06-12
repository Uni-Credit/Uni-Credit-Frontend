import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/atech/language/language_dropdown.dart';

class ATechAboutDisplay extends StatelessWidget {
  const ATechAboutDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              'Atech V1',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
                width: 150,
                child: LanguageDropdown(
                    backgroundColor: Colors.grey.withAlpha(120))),
          )
        ],
      ),
    );
  }
}
