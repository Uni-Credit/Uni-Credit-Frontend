import 'package:flutter/cupertino.dart';
import 'package:framework/atech/views/register_page/address_info/address_infos.dart';

class Address {
  final String cep;
  final String address;
  final String? district;
  final String state;
  final String city;
  String complement;
  dynamic number;

  Address({
    required this.cep,
    required this.address,
    required this.district,
    required this.state,
    required this.city,
    this.complement = "",
  });

  factory Address.fromJson(
      Map<String, dynamic> json, AddressFieldMappers mapper) {
    debugPrint(json.toString());
    Address address = Address(
      cep: json[mapper.postalCode]!,
      address: (json[mapper.street] ?? json["address"] ?? json['street'])!,
      district: json[mapper.neighborhood],
      state: json[mapper.state]!,
      city: json[mapper.city]!,
    );

    if (json.containsKey(mapper.number)) {
      address.number = json[mapper.number];
    }

    return address;
  }

  Map<String, dynamic> toJson(AddressFieldMappers mapper) {
    Map<String, dynamic> addressMap = {
      mapper.postalCode: cep,
      mapper.street: address,
      mapper.neighborhood: district,
      mapper.state: state,
      mapper.city: city,
      mapper.complement: complement
    };

    if (complement == '') {
      addressMap.remove(mapper.complement);
    }

    if (number != null) {
      addressMap[mapper.number] = number;
    }

    return addressMap;
  }

  @override
  String toString() {
    return "$cep | $address | $district | $state | $city | $complement";
  }
}
