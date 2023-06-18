


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/shared_widgets/form_components/template_dropdown.dart';

import '../../shared_widgets/form_components/dropdown_field.dart';
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

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 24.0, left: 32),
          child: DropdownField(items: [

            DropdownItem(value: 'Classe 1'),
            DropdownItem(value: 'Classe 2'),
            DropdownItem(value: 'Classe 3'),
            DropdownItem(value: 'Classe 4'),

          ],
          ),
        )
    );
  }
}

