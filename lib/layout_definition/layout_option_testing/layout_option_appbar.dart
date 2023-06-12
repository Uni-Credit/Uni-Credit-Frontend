import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared_widgets/widgets/app_container.dart';
import '../../shared_widgets/base_template/widgets/card_button_v1.dart';
import '../../shared_widgets/item_sizes.dart';

class LayoutOptionsAppbar extends StatelessWidget {
  final ValueNotifier<int> designOption;
  const LayoutOptionsAppbar({Key? key, required this.designOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: AppContainer(
          color: Colors.yellowAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [LayoutOptionsButton(designOption: designOption)],
          ),
        ),
      ),
    );
  }
}

class LayoutOptionsButton extends StatelessWidget {
  const LayoutOptionsButton({
    super.key,
    required this.designOption,
  });

  final ValueNotifier<int> designOption;

  @override
  Widget build(BuildContext context) {
    return CardButtonV1(
      title: CardTextContent(
        content: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
      onPress: () {
        designOption.value += 1;
      },
      buttonSize: ItemSize.minimal,
    );
  }
}
