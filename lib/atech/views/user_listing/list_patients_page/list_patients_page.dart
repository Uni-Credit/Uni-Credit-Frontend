import 'package:framework/atech/requests/patient_requests.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/base_template/widgets/card_button_v1.dart';
import 'package:framework/shared_widgets/item_sizes.dart';
import 'package:framework/shared_widgets/list_value_notifier.dart';
import '../../../../shared_widgets/listing/view/item_selection.dart';
import '../../../../shared_widgets/listing/view/item_view.dart';
import '../../../../shared_widgets/listing/view/item_view_card.dart';
import '../../../../shared_widgets/listing/view/item_view_interaction_page.dart';
import '../../../models/patient.dart';
import '../list_health_professional_page/list_health_professional_page.dart';
import '../user_search_mechanism.dart';

class ListPatientsConstruction {
  late ItemsSelection<Patient> patientSelection;
  List<Patient>? patients;

  ListPatientsConstruction(
      {ItemsSelection<Patient>? patientSelection, this.patients}) {
    this.patientSelection = patientSelection ?? ItemsSelection<Patient>();
  }
}

class ListPatientsPage extends StatefulWidget {
  late ListPatientsConstruction construction;
  ListPatientsPage({Key? key, ListPatientsConstruction? construction})
      : super(key: key) {
    this.construction = construction ?? ListPatientsConstruction();
  }

  @override
  State<ListPatientsPage> createState() => _ListPatientsPageState();
}

class _ListPatientsPageState extends State<ListPatientsPage> {
  ListValueNotifier<Patient> patients = ListValueNotifier([]);

  loadPatients() async {
    //await PatientRequests.loadPatients();
    patients.value = widget.construction.patients ?? Patient.mock();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.construction.patientSelection.itemsToggled.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return ItemViewInteractionPage<Patient>(
      construction: ItemsViewInteractionConstruction<Patient>(
          loadItems: loadPatients,
          itemSelection: widget.construction.patientSelection,
          itemBuilder: (patient) {
            return ItemView<Patient>(
                itemsSelection: widget.construction.patientSelection,
                item: patient,
                cardBuilder: (args) {
                  return ItemViewDefaultCard(
                    args: args,
                    title: CardTextContent(content: patient.patientData.name),
                  );
                });
          },
          items: patients,
          labelForVinculation: 'Vincular a médico'),
    );
  }
}
