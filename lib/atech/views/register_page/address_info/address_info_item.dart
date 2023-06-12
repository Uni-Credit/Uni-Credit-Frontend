import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../../shared_widgets/card_button/informative_card.dart';
import '../../../../shared_widgets/item_sizes.dart';

class AddressInfoItem extends StatelessWidget {
  final String? cep;
  final String? fu;
  final String? city;
  final String? district;
  final String? address;
  final VoidCallback onDeleted;
  final String? complement;
  final String? number;

  const AddressInfoItem({
    super.key,
    required this.cep,
    required this.fu,
    required this.city,
    required this.number,
    this.district,
    required this.address,
    required this.onDeleted,
    this.complement = "",
  });

  String get locationData {
    String content = "$district, $city/$fu";

    return complement != null && complement!.isNotEmpty
        ? "$content - $complement"
        : content;
  }

  @override
  Widget build(BuildContext context) {
    Color mainColor = Colors.white; //getIceWhite();
    Color secondaryColor = Colors.black;

    return InformativeCard(
      title: "$address $number, $cep",
      subtitle: AutoSizeText(locationData,
          maxLines: 2, overflow: TextOverflow.ellipsis),
      leading: Icons.domain,
      trailingPress: onDeleted,
    );
  }
}
