

import 'package:flutter/cupertino.dart';
import 'package:uni_credit/shared_widgets/widgets/title.dart';
import 'package:uni_credit/views/dashboard_page/atualization_card.dart';

class AtualizationsWidget extends StatelessWidget {
  const AtualizationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: TitleWidget(title: 'Atualizações'),
        ),

        Padding(
          padding: EdgeInsets.only(top: 16),
          child: Column(
            children: [
              AtualizationCard(infoTitle: 'Cardápio do dia - RU 1',
                  atualizationTime: 2),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: AtualizationCard(infoTitle: 'Cardápio do dia - RU 2',
                    atualizationTime: 3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
