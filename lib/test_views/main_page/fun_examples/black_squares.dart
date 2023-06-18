

import 'package:flutter/cupertino.dart';

import '../main_page_function.dart';

class BlackSquares extends StatelessWidget {
  const BlackSquares({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(int i in [1,2,3])
          Row(
            children: [
              BlackSquare(),

              BlackSquare(),
              BlackSquare(),
              BlackSquare(),
              BlackSquare(),
            ], ),
      ],
    );
  }
}

class BlackSquare extends StatefulWidget {
  const BlackSquare({
    super.key,
  });

  @override
  State<BlackSquare> createState() => _BlackSquareState();
}

class _BlackSquareState extends State<BlackSquare> {

  bool wasClicked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: (){
        setState(() {
          wasClicked = !wasClicked;
        });
      },
      child: Container(
        margin: EdgeInsets.all(100),
        color: wasClicked ? null :  getContainerColorPositional(1, 0),
        width: 50,
        height: 50,
      ),
    );
  }
}
