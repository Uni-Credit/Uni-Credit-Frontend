import 'package:flutter/material.dart';
//import 'package:intl/intl.dart';

import 'package:framework/models/extensions/for_date_time.dart';
import 'package:framework/shared_widgets/form_components/form_controller_utility.dart';

import '../card_button/input_like_card.dart';

class AdaptativeDatePicker extends StatefulWidget {
  final Function(DateTime)? onDateChanged;

  final bool limitWidth;
  final FormValidatorUtility? formUtility;
  final String? name;

  final String? displayName;

  const AdaptativeDatePicker({
    this.onDateChanged,
    this.limitWidth = true,
    this.displayName,
    Key? key,
    this.formUtility,
    this.name,
  }) : super(key: key);

  @override
  State<AdaptativeDatePicker> createState() => _AdaptativeDatePickerState();
}

class _AdaptativeDatePickerState extends State<AdaptativeDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.name != null && widget.formUtility != null) {
      widget.formUtility!.formController.insureRequirement(widget.name!);

      String? value = widget.formUtility!.formController
          .readField(widget.name!, defaultValue: null);

      if (value != null) {
        selectedDate = DateTime.tryParse(value);
      }
    }
  }

  _showDatePicker(BuildContext context) {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime.now(),
        builder: (context, widget) {
          return Theme(
              data: Theme.of(context).copyWith(
                  colorScheme: ColorScheme.light(
                    primary: Colors.blueAccent, // header background color
                    onPrimary: Colors.white, // header text color
                    onSurface: Colors.blueAccent, // body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.blueAccent),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ))),
              child: widget!);
        }).then((DateTime? pickedDate) {
      if (pickedDate == null) {
        return;
      }

      if (widget.formUtility != null && widget.name != null) {
        widget.formUtility!.formController
            .setData(widget.name!, pickedDate.toAmericanDisplay());
      }
      if (widget.onDateChanged != null) {
        widget.onDateChanged!(pickedDate);
      }

      setState(() {
        selectedDate = pickedDate;
      });
    });
  }

  String getText() {
    return selectedDate == null
        ? (widget.displayName ?? 'Selecionar Data')
        : "${selectedDate?.day.toString() as String}/${selectedDate?.month.toString() as String}/${selectedDate?.year.toString() as String}";
  }

  @override
  Widget build(BuildContext context) {
    return InputLikeCard(
      text: getText(),
      onPress: () => _showDatePicker(context),
      topLabel: selectedDate == null ? null : "Data de nascimento",
      nullifyWidth: !widget.limitWidth,
    );
    /*
    return CardButton(
      buttonSize: ItemSize.small,
      //heightMultiply: 1.2,
      cardWidth: widget.limitWidth ? null : double.infinity,
      cardIntention: CardIntention.action,
      backgroundColor: selectedDate == null ? BrandColors.studentYellow : null,
      title: getText(),
      onPress: () => _showDatePicker(context),
    );*/
  }
}
