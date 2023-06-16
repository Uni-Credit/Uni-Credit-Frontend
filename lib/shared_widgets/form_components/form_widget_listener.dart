import 'package:flutter/cupertino.dart';
import 'package:uni_credit/shared_widgets/form_components/validation_form_controller.dart';

class FormWidgetListener extends StatefulWidget {
  final Function() builder;
  final FormValidationController formController;
  const FormWidgetListener(
      {Key? key, required this.builder, required this.formController})
      : super(key: key);

  @override
  State<FormWidgetListener> createState() => _FormWidgetListenerState();
}

class _FormWidgetListenerState extends State<FormWidgetListener> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.formController.onValidationChange((isValid) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }
}
