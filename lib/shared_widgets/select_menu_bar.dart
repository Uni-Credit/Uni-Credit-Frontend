import 'package:flutter/material.dart';


// #todo: Selected option should have a bar displayed below it, and there should be one selected by default
class SelectMenu extends StatefulWidget {

  final List<String> options;
  final Function(String selectedOption)? selectedOptionCallback;

  const SelectMenu({
    super.key,
    required this.options,
    this.selectedOptionCallback
  });

  @override
  State<SelectMenu> createState() => _SelectMenuState();
}

class _SelectMenuState extends State<SelectMenu> {

  String selectedOption = "pendentes";
 /* _SelectMenuState(){

  }*/

  @override
  void initState() {
    selectedOption = widget.options[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {




    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.15,
          right: MediaQuery.of(context).size.width * 0.15,
          bottom: MediaQuery.of(context).size.height * 0.05,
        ),
      child: Builder(builder: (context){

        List<Widget> widgets = [];

        for(String option in widget.options) {
          widgets.add(Flexible(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                  border:
                  selectedOption == option ? Border(bottom: BorderSide(width: 2, color: const Color.fromRGBO(13, 151, 173, 1)))
                      : null
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: TextButton(

                  onPressed: () {
                    setState(() {
                      selectedOption = option;
                      if(widget.selectedOptionCallback != null) {
                        widget.selectedOptionCallback!(selectedOption);
                      }

                    });
                  },
                  child: Text(option,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: selectedOption == option
                          ? const Color.fromRGBO(13, 151, 173, 1)
                          : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ));
          if(option != widget.options.last) {
            widgets.add(const Spacer(flex: 2));
          }
        }


        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgets);
      }),
    );
  }
}
