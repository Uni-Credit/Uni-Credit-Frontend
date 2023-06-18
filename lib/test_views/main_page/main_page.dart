


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main_page_function.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  double x = 10;
  double y = 0;
  
  double multiplicador = 1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    move();

  }

  move() {
    Future.delayed(Duration(milliseconds: 25)).then((value) {
      setState(() {
        x +=0.4 * multiplicador;
        y += 0.4 * multiplicador;
      });

      move();
    });
  }

  @override
  Widget build(BuildContext context) {

    double size = 50;



    return Scaffold(
        body:

        true ?
        GestureDetector(
          onTap: (){
            setState(() {
              multiplicador *= -1;
            });
          },
          child: Container(
            margin: EdgeInsets.only(top: y, left: x),
            color: getContainerColorPositional(0, 1),
            width: size,
            height: size,
          ),

        ) :
        Row(
          children: [
            Container(
              margin: EdgeInsets.all(100),
              color: getContainerColorPositional(1, 0),
              width: 50,
              height: 50,
            ),Container(
              margin: EdgeInsets.all(100),
              color: Colors.black,
              width: 50,
              height: 50,
            ),
          ],
        )
    );
  }
}
