import 'package:uni_credit/shared_widgets/widgets/app_container.dart';
import 'package:flutter/material.dart';

class TestPageBody extends StatefulWidget {
   TestPageBody({Key? key}) : super(key: key);

  @override
  State<TestPageBody> createState() => _TestPageBodyState();
}

class _TestPageBodyState extends State<TestPageBody> {
int var1= 0;

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          Text("Oi, mundo"),
          ElevatedButton(onPressed: () {
            setState(() {
              var1++;
            });
            }, child: Text("Flutter"),),
          Text(var1.toString()),
          for(int i=0; i<=var1; i++ )
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Bloquinho(),
            )
        ],
      ),
    );
  }
}

class Bloquinho extends StatelessWidget {
   Bloquinho({
    super.key,
  });
double width1=40;
double height1=40;
  @override
  Widget build(BuildContext context) {
    return Container(width: width1,height: height1,decoration: BoxDecoration(color: Colors.red),);
  }
}
