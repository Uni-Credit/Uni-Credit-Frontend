import 'dart:math';

import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InProgress extends StatefulWidget {
  final TemplateScaffold templateScaffold;

  static bool inView = true;

  const InProgress({Key? key, required this.templateScaffold})
      : super(key: key);

  @override
  State<InProgress> createState() => _InProgressState();
}

class _InProgressState extends State<InProgress>
    with SingleTickerProviderStateMixin {
  Animation<Color?>? animation;
  AnimationController? controller;

  bool toggled = false;

  static Duration duration = const Duration(seconds: 1);

  static bool doesAnimation = false;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(duration: duration, vsync: this);
    animation = ColorTween(begin: Colors.pinkAccent, end: Color(0xffD27FBB))
        .animate(controller!)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });

    if (doesAnimation) {
      animateColor();
    }
  }

  void animateColor() async {
    if (toggled) {
      controller?.forward();
    } else {
      controller?.reverse();
    }
    toggled = !toggled;

    await Future.delayed(Duration(seconds: (duration.inSeconds).toInt()));
    animateColor();
  }

  double rotation = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedRotation(
              turns: rotation,
              onEnd: () {
                rotation += pi;
                setState(() {});
              },
              duration: Duration(seconds: 4),
              child: SvgPicture.asset(
                "assets/icons/in_progress.svg",
                color: doesAnimation ? animation?.value : Colors.pinkAccent,
                width: MediaQuery.of(context).size.width * 0.3,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Column(
                children: [
                  Text(
                    "Versão MOBILE",
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                        fontSize: 18),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Text(
                      "Em construção!",
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
