import 'package:framework/atech/views/view_caretaker_information_page/widgets/caretaker_information.dart';
import 'package:framework/atech/views/view_caretaker_information_page/widgets/institution_information.dart';
import 'package:framework/shared_widgets/widgets/app_container.dart';
import 'package:flutter/material.dart';

class ViewCareTakerInformationPageBody extends StatelessWidget {
  const ViewCareTakerInformationPageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [CareTakerInformation(), InstitutionInformationView()],
    );
  }
}
