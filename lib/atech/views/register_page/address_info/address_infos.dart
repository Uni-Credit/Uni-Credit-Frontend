import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framework/atech/views/register_page/address_info/uf_field.dart';
import 'package:framework/models/extensions/for_build_context.dart';
import 'package:framework/models/extensions/for_response.dart';
import 'package:framework/shared_widgets/widgets/title.dart';
import '../../../../shared_widgets/form_components/add_highlight_item.dart';
import '../../../../shared_widgets/form_components/form_controller_utility.dart';
import '../../../../shared_widgets/form_components/grouped_info.dart';
import '../../../../shared_widgets/form_components/linked_text_input.dart';
import '../../../../shared_widgets/form_components/validation_form_controller.dart';
import '../../../../shared_widgets/form_components/validations.dart';
import '../../../../shared_widgets/responsive/media_queries.dart';
import '../requests/address_requests.dart';
import 'address.dart';
import 'address_info_item.dart';

// TODO (Button "Send Image"): Button title to file name

class AddressFieldMappers {
  final String complement;
  final String street;
  final String number;
  final String postalCode;
  final String neighborhood;
  final String city;
  final String state;

  const AddressFieldMappers(
      {required this.city,
      required this.complement,
      required this.neighborhood,
      required this.number,
      required this.postalCode,
      required this.state,
      required this.street});
}

class AddressInfo extends StatefulWidget {
  final EdgeInsetsGeometry? inputPadding;

  final bool multiple;
  final bool showTitle;
  final bool useLineSpacing;
  final String fieldName;
  final bool useGroup;
  final AddressFieldMappers fieldMappers;

  final FormValidationController parentFormController;

  AddressInfo(
      {Key? key,
      this.inputPadding,
      this.fieldMappers = const AddressFieldMappers(
          city: 'city',
          complement: 'complement',
          neighborhood: 'district',
          number: 'number',
          postalCode: 'postalCode',
          state: 'state',
          street: 'address'),
      this.multiple = true,
      this.useLineSpacing = false,
      this.fieldName = "addresses",
      this.showTitle = true,
      this.useGroup = true,
      required this.parentFormController})
      : super(key: key);

  @override
  State<AddressInfo> createState() => _AddressInfoState();
}

class _AddressInfoState extends State<AddressInfo> {
  Address currentAddressInfos = Address(
    cep: "",
    address: "",
    district: "",
    state: "",
    city: "",
  );

  List<Map<String, dynamic>> addresses = [];

  bool loaded = false;

  Future<Address?> getAddressInformation(
      String cep,
      FormValidatorUtility formUtility,
      FormValidationController formController) async {
    Response response = await AddressRequests.getAddressInformation(cep: cep);
    debugPrint(response.statusCode.toString());

    if (response.positiveStatus) {
      showLoadedAddressInputs(response, cep, formController, formUtility);
    } else {
      setState(() {
        formUtility.fieldsEnabled = true;

        formController.mapResponseErrors(
            {widget.fieldMappers.postalCode: "CEP inválido!"});
      });
    }

    return null;
  }

  void showLoadedAddressInputs(
      Response<dynamic> response,
      String cep,
      FormValidationController formController,
      FormValidatorUtility formUtility) {
    Map<String, String> parsedResponse =
        jsonDecode(response.data).cast<String, String>();

    setState(() {
      Map<String, String> data = {
        widget.fieldMappers.postalCode: cep,
        widget.fieldMappers.city: parsedResponse['city']!,
        widget.fieldMappers.neighborhood: parsedResponse['district']!,
        widget.fieldMappers.state: parsedResponse['state']!,
        widget.fieldMappers.street: parsedResponse['address']!
      };

      currentAddressInfos = Address.fromJson(data, widget.fieldMappers);

      data.remove(widget.fieldMappers.postalCode);
      // maps to inputs
      formController.mapData(
        data,
        updateFields: true,
      );

      formUtility.fieldsEnabled = true;
    });
  }

  String? lastCep;

  FormValidationController validatorController = FormValidationController();
  bool firstUpdate = true;

  final _formKey = GlobalKey<FormState>();

  bool testing = false;

  bool checkCurrentFieldsValidation() {
    testing = true;

    bool state = validatorController.checkValidationState();

    testing = false;

    return state;
  }

  FormValidationController getInputController(
      FormValidationController? parentValidatorController) {
    return validatorController;
    if (widget.multiple) {
      return validatorController;
    }

    return parentValidatorController ?? validatorController;
  }

  onAddAddress() {
    if (!checkCurrentFieldsValidation()) {
      return;
    }

    setState(() {
      Map<String, dynamic> formData = validatorController.readFields();
      debugPrint(formData.toString());

      addresses.add(formData);

      currentAddressInfos = Address(
        cep: "",
        address: "",
        district: "",
        state: "",
        city: "",
      );

      validatorController.reset();
    });
  }

  onDeleteAddress(address, parentValidatorController) {
    setState(() {
      int addressIndex = addresses.indexOf(address);

      addresses.removeAt(addressIndex);

      if (addresses.isEmpty) {
        parentValidatorController.setData(widget.fieldName, null);
        parentValidatorController.updateValidationState(validationState: false);
        validatorController.setData(widget.fieldName, null);
        validatorController.updateValidationState(validationState: false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.useGroup) {
      validatorController = widget.parentFormController;
    } else {
      widget.parentFormController.insureRequirement(widget.fieldName);
    }

    if (!loaded && widget.useGroup) {
      loaded = true;

      dynamic loadedAddresses =
          widget.parentFormController.readField(widget.fieldName);

      if (loadedAddresses != null) {
        if (!widget.multiple && loadedAddresses is Map) {
          for (String key in loadedAddresses.keys) {
            // # todo remember: it didnt work by setting the value directly,
            // blocking the input. solve that.
            validatorController.textControllers[key] =
                TextEditingController(text: loadedAddresses[key]);
          }
        } else {
          addresses = loadedAddresses;
        }
      }
    }

    FormValidatorUtility formUtility = FormValidatorUtility(
      getInputController(widget.parentFormController),
      storeNames: true,
      defaultValidateMode: AutovalidateMode.onUserInteraction,
    );

    formUtility.inputLineItemPadding = widget.inputPadding ??
        EdgeInsets.only(right: LinkedTextInput.defaultTopInputSpacing);

    EdgeInsetsGeometry inputLinePadding = EdgeInsets.only(
        top: min(MediaQuery.of(context).size.height * 0.05, 40));

    formUtility.inputLinePadding = inputLinePadding;

    if (widget.multiple) {
      formUtility.wrapperFunction = (String? value, String? functionResponse) {
        if (addresses.isEmpty || testing) {
          return functionResponse;
        }

        return (value == "" || value == null) ? null : functionResponse;
      };
    }

    Widget child = _AddressInfoBody(
      parent: this,
      addAddress: onAddAddress,
      formUtility: formUtility,
      addresses: addresses,
      parentValidatorController: widget.parentFormController,
      widget: widget,
      onDeleteAddress: (address) =>
          onDeleteAddress(address, widget.parentFormController),
    );

    if (widget.useGroup) {
      child = GroupedInfo(
          list: widget.multiple ? addresses : addresses,
          isList: widget.multiple,
          parentValidatorController: widget.parentFormController,
          validatorController: validatorController,
          currentFieldsValidation: checkCurrentFieldsValidation,
          groupLabel: widget.fieldName,
          child: child);
    }

    return Container(
      //color: Colors.red,
      child: Form(key: _formKey, child: child),
    );
  }
}

class _AddressInfoBody extends StatelessWidget {
  final FormValidatorUtility formUtility;
  final List<Map<String, dynamic>> addresses;
  final AddressInfo widget;
  final Function() addAddress;
  final Function(Map<String, dynamic>) onDeleteAddress;
  final FormValidationController parentValidatorController;
  final _AddressInfoState parent;

  const _AddressInfoBody({
    Key? key,
    required this.formUtility,
    required this.addresses,
    required this.parentValidatorController,
    required this.widget,
    required this.addAddress,
    required this.onDeleteAddress,
    required this.parent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Visibility(
              visible: widget.showTitle,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 50,
                ),
                child: TitleWidget(
                  title: "Endereço(s) de Atendimento",
                  alignment: MainAxisAlignment.start,
                  icon: Icons.location_pin,
                ),
              )),
          Visibility(
            visible: addresses.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.025,
              ),
              child: Column(
                children: addresses
                    .map((Map<String, dynamic> address) {
                      return AddressInfoItem(
                          cep: address[widget.fieldMappers.postalCode],
                          fu: address[widget.fieldMappers.state],
                          city: address[widget.fieldMappers.city],
                          district: address[widget.fieldMappers.neighborhood],
                          address: address[widget.fieldMappers.street],
                          complement: address[widget.fieldMappers.complement],
                          number: address[widget.fieldMappers.number],
                          onDeleted: () => onDeleteAddress(address));
                    })
                    .cast<Widget>()
                    .toList(),
              ),
            ),
          ),
          AddressInfoMainLine(
            formUtility: formUtility,
            parent: parent,
            mapper: widget.fieldMappers,
            parentFormController: parentValidatorController,
            useLineSpacing: widget.useLineSpacing,
          ),
          formUtility.InputLine(children: [
            formUtility.linkedInput(widget.fieldMappers.street,
                flex: 10,
                displayName: "Endereço",
                validator: Validations.requiredField),
          ]),
          formUtility.InputLine(
            children: <Widget>[
              formUtility.linkedInput(widget.fieldMappers.neighborhood,
                  flex: 10,
                  displayName: "Bairro",
                  validator: Validations.requiredField),
              formUtility.linkedInput(widget.fieldMappers.city,
                  flex: 10,
                  displayName: "Cidade",
                  validator: Validations.requiredField),
            ],
          ),
          formUtility.InputLine(children: [
            formUtility.linkedInput(
              widget.fieldMappers.complement,
              flex: 1,
              displayName: "Complemento",
              validator: null,
            )
          ]),
          Visibility(
              visible: widget.multiple,
              child: AddHighlightItem(
                onPress: addAddress,
                label: "+ Adicionar endereço",
              )),
        ],
      ),
    );
  }
}

class AddressInfoMainLine extends StatelessWidget {
  final FormValidationController? parentFormController;
  final FormValidatorUtility formUtility;
  final bool useLineSpacing;
  final _AddressInfoState parent;
  final AddressFieldMappers mapper;

  const AddressInfoMainLine(
      {Key? key,
      required this.formUtility,
      required this.parent,
      required this.mapper,
      required this.useLineSpacing,
      this.parentFormController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
//    FormValidatorUtility

    //FormValidatorUtility formRowUtility =

    int ufFlex = 4;
    int numberFlex = 6;
    int cepLineFlex = 1;

    int flexSum = 0;

    if (isMobile()) {
      ufFlex = numberFlex;
    }

    flexSum += (numberFlex + ufFlex);

    double flexRelation = ufFlex / flexSum;

    double containerWidth = context.width;

    if (!isMobile()) {
      containerWidth /= 2;
    }

    double dropdownSize = containerWidth * flexRelation;

    dropdownSize -= 20;
    //dropdownSize -= RegisterPage.pageWidth(context);

    if (isMobile()) {
      // find better solution
      dropdownSize -= MediaQuery.of(context).size.width * 0.061;
    }

    return Container(
      // color: Colors.green,
      child: formUtility.InputLine(
          deviceAxis: DeviceOption(
              defaultResult: Axis.horizontal, mobile: Axis.vertical),
          mainAxisSize: MainAxisSize.min,
          usesLineSpacing: useLineSpacing,
          children: [
            LinkedFlex(
              flex: cepLineFlex,
              formUtility: formUtility,
              child: formUtility.InputLine(
                usesLineSpacing: false,
                direction: Axis.horizontal,
                children: [
                  formUtility.linkedInput(mapper.postalCode,
                      flex: 11,
                      displayName: "CEP",
                      formatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        //CepInputFormatter(),

                        //LengthLimitingTextInputFormatter(8),
                      ],
                      validator: Validations.grouped([
                        Validations.requiredField,
                        (String? value) {
                          value =
                              value!.replaceAll(".", "").replaceAll("-", "");
                          if (value != null && value.length == 8) {
                            if (value != parent.lastCep) {
                              parent.lastCep = value;
                              parent.getAddressInformation(
                                  value,
                                  formUtility,
                                  parent.getInputController(
                                      parentFormController));
                            }

                            return null;
                          }
                          return "Incompleto";
                        }
                      ])),
                ],
              ),
            ),
            LinkedFlex(
              formUtility: formUtility,
              flex: 1,
              child: formUtility.InputLine(
                usesLineSpacing: isMobile(),
                direction: Axis.horizontal,
                children: [
                  formUtility.linkedInput(mapper.number,
                      flex: numberFlex,
                      displayName: "Número",
                      validator: Validations.requiredField),
                  LinkedFlex(
                      formUtility: formUtility,
                      flex: ufFlex,
                      child: UFField(
                          dropdownWidth: dropdownSize,
                          formUtility: formUtility,
                          name: mapper.state)),
                ],
              ),
            ),
          ]),
    );
  }
}
