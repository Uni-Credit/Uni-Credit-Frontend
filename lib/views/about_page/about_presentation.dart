


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPresentationBody extends StatelessWidget {
  final Widget body;
  final ValueNotifier<int> index;
  final List<Widget> listWidgets;
  const AboutPresentationBody({super.key, required this.body, required this.index, required this.listWidgets});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      body,
      listWidgets[index.value] ?? Container()
    ],);
  }
}


class AboutPresentationFooter extends StatelessWidget {
  final ValueNotifier<int> selectedIndex;
  final List<NavigationDestination> destinations;
  const AboutPresentationFooter({super.key,
  required this.selectedIndex, required this.destinations,});

  @override
  Widget build(BuildContext context) {

    /*
    Widget icon = destinations[selectedIndex.value].icon;

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(),
      height: 100,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                clipBehavior: Clip.none,
                height: 100,
              ),
              icon,
            ],
          ),
        ],
      ),
    );*/
    return NavigationBar(
        selectedIndex: selectedIndex.value,
        onDestinationSelected: (int newDestination){

            selectedIndex.value = newDestination;
        },
        destinations:destinations);
  }
}
