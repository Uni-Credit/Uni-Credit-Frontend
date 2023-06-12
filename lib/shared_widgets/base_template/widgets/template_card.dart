


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemplateCard extends StatelessWidget {

  final Widget child;
  final Function() onTap;
  final Color color;
  final double? width;
  final double? height;

  const TemplateCard({required this.child,
    this.width, this.height,
    this.color=Colors.transparent,
    Key? key, required this.onTap, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration:  BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(10) ),
          color: color
        ),
        child: child,

      ),
    );
  }
}
