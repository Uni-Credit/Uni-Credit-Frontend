

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Map<String, dynamic> info = {};

//sessionToken;

  static SharedPreferences? prefs;

  static PreferenceValue<bool> firstSession = PreferenceValue<bool>(name: 'firstSession',
  defaultValue: true);


  static Future<SharedPreferences> getPrefs() async {

    prefs ??= await SharedPreferences.getInstance();
    return prefs!;
  }
}




class PreferenceValue<T> {


  final String name;
  final T? defaultValue;

  PreferenceValue({required this.name, this.defaultValue});

  Future<T> getValue() async {

    SharedPreferences prefs =(await Session.getPrefs());

    // foi escrito com switch statements porque a biblioteca não implementa metodos inteligentes
    // para a distinção de tipo de dados

    T? value;
    switch (defaultValue.runtimeType) {
      case int:
        value= (prefs.getInt(name)) as T?;
        break;
      case String:
        value= (prefs.getString(name)) as T?;
        break;
      case bool:
        value = (prefs.getBool(name)) as T?;break;
      case List<String>:
        value = (prefs.getStringList(name)) as T?;break;
      case double:
        value = (prefs.getDouble(name)) as T?;break;
    }

    value ??= defaultValue;

    if(value != null) {
      return value;
    }

    throw Error();
  }

  setValue(T value) async {
    SharedPreferences prefs =(await Session.getPrefs());
    switch (value.runtimeType) {
      case int:
        return (prefs.setInt(name, value as int)) ;
      case String:
        return (prefs.setString(name, value as String)) ;
      case bool:
        return (prefs.setBool(name, value as bool)) ;
      case List<String>:
        return (prefs.setStringList(name, value as List<String>)) ;
      case double:
        return (prefs.setDouble(name, value as double)) ;
    }

  }

}








