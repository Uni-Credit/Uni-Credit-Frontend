
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/card_button/icon_action_card_button.dart';
import 'package:framework/shared_widgets/item_sizes.dart';
import 'package:uni_credit/theme/theme_colors.dart';

class ProfileIcon extends StatelessWidget {
  const ProfileIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return IconActionCardButton(content: '',
        mobileSize: ItemSize.unlimited,
        onPress: (){},
        forceMobile: true,
        backgroundColor: Colors.red,
        icon: Icon(Icons.person));
  }
}
