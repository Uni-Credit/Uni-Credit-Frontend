



import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uni_credit/shared_widgets/widgets/title.dart';
import 'package:uni_credit/theme/theme_colors.dart';

class AtualizationCard extends StatelessWidget {
  final String infoTitle;
  final int atualizationTime;
  const AtualizationCard({super.key, required this.infoTitle, required this.atualizationTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),

        color: Colors.black54,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TitleWidget(title: infoTitle),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 12),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text('Atualizado há $atualizationTime horas'),
            ),
          )
        ],
      ), 
    );
  }
}
