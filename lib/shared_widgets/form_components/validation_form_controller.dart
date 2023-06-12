import 'package:flutter/material.dart';

class FormValidationController {
  List<FormValidationController> childValidators = [];

  Map<String, bool> fieldsValidated = {};

  Map<String, Function(String? v)?> fieldValidators = {};

  Map<String, dynamic> _fieldsData = {};
  Map<String, TextEditingController> textControllers = {};

  List<Function(bool isValid)> validationListeners = [];
  Map<String, List<Function(bool isValid)>> validationTargetListeners = {};

  List<Function()> dataListeners = [];
  Map<String, List<Function()>> targetDataListeners = {};

  bool _lastValidationState = false;

  Map<String, String>? validationErrorResponses;

  bool ignoreValidation = false;

  String? Function(String? value, String? validation)? wrapFunction;

  Map<String, List<dynamic Function(dynamic data)>> readConverters = {};

  bool getValidationState({bool emptyDefault = false}) {
    if (fieldsValidated.isEmpty) {
      return emptyDefault;
    }

    for (bool validated in fieldsValidated.values) {
      if (!validated) {
        return false;
      }
    }

    return true;
  }

  bool getLastValidationState() {
    return _lastValidationState;
  }

  void notifyValidationChange() {
    for (Function(bool isValid) validationListener in validationListeners) {
      validationListener(_lastValidationState);
    }
  }

  void updateValidationState(
      {bool? validationState,
      bool notifyListeners = false,
      bool ignoreUpdate = false}) {
    bool currentValidationState = validationState ?? getValidationState();

    if (_lastValidationState != currentValidationState || notifyListeners) {
      _lastValidationState = currentValidationState;

      if (!ignoreUpdate) {
        notifyValidationChange();
      }
    }
  }

  updateToNewValidationState() {
    for (String key in fieldValidators.keys) {
      fieldsValidated[key] =
          fieldValidators[key]!(textControllers[key]!.value.text) == null;
    }
    updateValidationState();
  }

  TextEditingController? getLinkedController(validator, name,
      {String? initialValue, AutovalidateMode? validateMode}) {
    if (!fieldsValidated.containsKey(name)) {
      fieldsValidated[name] = validator == null;
    }

    if (validator != null) {
      fieldValidators[name] = validator;
    }

    TextEditingController? textController;

    if (textControllers.containsKey(name)) {
      textController = textControllers[name] as TextEditingController;
    } else {
      textController = TextEditingController();
      textController.text = initialValue ?? readField(name) ?? "";
      setController(name, textController, validator,
          validateMode: validateMode);
    }

    return textController;
  }

  bool updatingControllers = false;
  setController(name, textController, validator,
      {AutovalidateMode? validateMode}) {
    if (validator != null) {
      fieldValidators[name] = validator;
      fieldsValidated[name] = validator(textController.text) == null;
    }
    if (textControllers.containsKey(name) &&
        textControllers[name] == textController) {
      return;
    }

    textControllers[name] = textController;

    textController.addListener(() {
      if (updatingControllers) {
        return;
      }

      String? v = textController!.text;

      if (v == "" && readField(name) == "") {
        return;
      }

      debugPrint(" validate mode: " + validateMode.toString());
      setData(name, v,
          validator: validator,
          updateValidation: validateMode != AutovalidateMode.disabled);
    });

    return textController;
  }

  bool checkValidationState() {
    for (String key in fieldValidators.keys) {
      if (fieldValidators[key]!(textControllers[key]?.text) != null) {
        return false;
      }
    }
    return true;
  }

  String? Function(String?) getLinkedValidator(validator, String name) {
    String? validatorFunction(String? v) {
      if (ignoreValidation) {
        return null;
      }

      if (validationErrorResponses != null &&
          validationErrorResponses!.containsKey(name) &&
          validationErrorResponses?[name] != null) {
        return validationErrorResponses?[name];
      }

      return validator(v);
    }

    if (wrapFunction != null) {
      return (String? v) => wrapFunction!(v, validatorFunction(v));
    }

    return validatorFunction;
  }

  bool isValid(String name) {
    if (!fieldsValidated.containsKey(name)) {
      return true;
    }

    return fieldsValidated[name] as bool;
  }

  void onValidationChange(Function(bool isValid) validationObserver,
      {String? targetData}) {
    if (targetData == null) {
      validationListeners.add(validationObserver);
      return;
    }

    if (!validationTargetListeners.containsKey(targetData)) {
      validationTargetListeners[targetData] = [];
    }
    validationTargetListeners[targetData]?.add((validationObserver));
  }

  void onDataChange(Function() dataObserver,
      {once = false, String? targetData, bool callIfNotNull = false}) {
    if (targetData != null) {
      if (!targetDataListeners.containsKey(targetData)) {
        targetDataListeners[targetData] = [];
      }

      targetDataListeners[targetData]!.add(dataObserver);

      return;
    }

    if (once) {
      Function() onceDataObserver = () {};
      onceDataObserver = () {
        dataObserver();
        dataListeners.remove(onceDataObserver);
      };
      dataListeners.add(onceDataObserver);
      return;
    }

    dataListeners.add(dataObserver);

    if (callIfNotNull && readField(targetData!) != '') {
      dataObserver();
    }
  }

  Map<String, dynamic> readFields() {
    return _fieldsData.map((key, value) => MapEntry(key, value));
  }

  dynamic readField(String key, {defaultValue = ""}) {
    return _fieldsData.containsKey(key) ? _fieldsData[key] : defaultValue;
  }

  updateValidationFunction(key, value, {validator, isValid, updateValidation}) {
    validator ??= fieldValidators[key];

    String? validationResponse = validator != null
        ? validator(value)
        : isValid == null || isValid
            ? null
            : "";

    bool validation = validationResponse == null;
    fieldsValidated[key] = validation;

    if (updateValidation) {
      updatedValidation(key);
    }
  }

  updatedValidation(key) {
    bool? validation = fieldsValidated[key];
    if (validation == null) {
      return;
    }

    if (validationTargetListeners.containsKey(key)) {
      for (Function(bool) listener in validationTargetListeners[key]!) {
        listener(validation);
      }
    }
  }

  setData(String key, dynamic value,
      {bool updateController = false,
      updateValidation = true,
      validator,
      isValid,
      bool hasUpdatedValue = false}) {
    debugPrint("going to validate: " + _fieldsData.toString());
    updateValidationFunction(key, value,
        validator: validator,
        isValid: isValid,
        updateValidation: updateValidation);

    //debugPrint(fieldsValidated.toString());

    dynamic oldValue = _fieldsData[key];

    _fieldsData[key] = value;

    if (updateController && textControllers.containsKey(key)) {
      updatingControllers = true;
      if (value == null || value == "") {
        textControllers[key]!.clear();
      } else {
        textControllers[key]!.value = TextEditingValue(
          text: value,
        );
        textControllers[key]!.text = value;
      }
      updatingControllers = false;
    }

    if (updateValidation) {
      updateValidationState();
    }

    if (validationErrorResponses != null &&
        validationErrorResponses!.containsKey(key)) {
      validationErrorResponses!.remove(key);
    }

    if (oldValue != value || hasUpdatedValue) {
      for (Function() listener in dataListeners) {
        listener();
      }
      List<Function()>? listeners = targetDataListeners[key];

      if (listeners != null) {
        for (Function() listener in listeners) {
          listener();
        }
      }
    }
  }

  updateFields({List<String>? keys}) {
    keys ??= textControllers.keys.cast<String>().toList();

    for (String key in keys) {
      textControllers[key]!.text = _fieldsData[key];
    }
  }

  void clearTextFields({List? fields}) {
    fields ??= textControllers.keys.cast<String>().toList();

    for (String field in fields) {
      setData(field, "", updateValidation: false);
      textControllers[field]!.clear();
      textControllers[field]!.clearComposing();
    }
  }

  invalidateFields({skipNullValidators}) {
    for (String key in fieldsValidated.keys) {
      fieldsValidated[key] =
          skipNullValidators ? !fieldValidators.containsKey(key) : false;
    }

    updateValidationState();
  }

  void mapResponseErrors(Map<String, String> response) {
    validationErrorResponses = response;
  }

  void insureRequirement(String s) {
    if (!_fieldsData.containsKey(s)) {
      _fieldsData[s] = null;
    }
    if (!fieldsValidated.containsKey(s)) {
      fieldsValidated[s] = false;
    }
  }

  void mapData(dynamic map, {updateFields = false, updateValidation = true}) {
    for (String key in map.keys) {
      setData(key, map[key],
          updateController: updateFields, updateValidation: updateValidation);
    }
  }

  void resetData({setDataAll = true}) {
    if (setDataAll) {
      List<String> keys = _fieldsData.keys.toList();

      for (String key in keys) {
        setData(key, null, updateController: true, hasUpdatedValue: true);
      }
    }

    _fieldsData = {};
  }

  void resetValidation() {
    fieldsValidated = {};
    fieldValidators = {};
  }

  List<Function()> resetListeners = [];
  void reset({resetChildren = true}) {
    if (resetChildren) {
      for (FormValidationController validatorChildController
          in childValidators) {
        validatorChildController.reset();
      }
    }

    _lastValidationState = false;

    resetData();

    resetValidation();

    notifyOnReset();
  }

  hasField(String key, {bool nullCheck = false}) {
    return _fieldsData.containsKey(key) &&
        (!nullCheck || _fieldsData[key] != null);
  }

  void onReset(Null Function() func) {
    resetListeners.add(func);
  }

  void notifyOnReset() {
    for (Function() listener in resetListeners) {
      listener();
    }
  }

  void changeValidationState(String key, bool validation) {
    fieldsValidated[key] = validation;
  }

  void reportDataChange() {
    debugPrint("form data change");
    debugPrint(readFields().toString());
    debugPrint(fieldsValidated.toString());

    debugPrint(getValidationState().toString());
  }

  void dispose() {
    for (var controller in textControllers.values) {
      controller.dispose();
    }
  }
}
