import 'package:flutter/cupertino.dart';

class InstitutionInformationView extends StatelessWidget {
  const InstitutionInformationView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Instituição responsável: '),
        Text('Contato: '),
      ],
    );
  }
}
