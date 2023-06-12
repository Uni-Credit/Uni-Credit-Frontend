


import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../graphical_item/graphical_item.dart';

class CardIconTitle extends StatelessWidget {

  final GraphicalItem icon;
  final dynamic name;
  final dynamic description;
  const CardIconTitle({Key? key, required this.icon, this.name, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          renderIcon(
              icon,
              color: Colors.white, size: 24
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 24),),
                const Padding(padding: EdgeInsets.only(left: 52, top: 8)),
              description == null ? Container() :
              (description is Widget ? description : AutoSizeText(description, style: const TextStyle(fontSize: 14, color: Colors.white),))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
