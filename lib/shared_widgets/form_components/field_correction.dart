

import 'package:flutter/cupertino.dart';

class FieldCorrection {

  static readFromTo(List<String> fields, Map info, String parentKey) {
    Map newInfo = {};
    for (String key in fields) {
      newInfo[key] = info[key];
    }

    info[parentKey] = newInfo;

    for (String key in fields) {
      info.remove(key);
    }
  }

  static remapValues(
      Map<String, String> keyRemapping, Map<String, dynamic> userInfo) {
    for (String key in keyRemapping.keys) {
      //debugPrint("remapping " + key + " to " + keyRemapping[key]! + " for value " +  userInfo[key].toString());
      userInfo[keyRemapping[key]!] = userInfo[key];
     // userInfo[key] = userInfo[keyRemapping[key]];
    }

    for (String key in keyRemapping.keys) {
      userInfo.remove(key);
    }

  }

  static void removeFields(List<String> fields, Map<String, dynamic> userInfo) {

    for(String field in fields) {
      userInfo.remove(field);
    }

  }

  static void setDefaultWhenNull(List<String> fieldsToDefault, userInfo, dynamic defaultValue) {

    for(String field in fieldsToDefault) {
      userInfo[field] ??= defaultValue;
    }

  }



  static void removeKeyWhenEmpty(List<String> fields, Map userInfo) {

    for(String field in fields) {
      if(userInfo[field] == null || userInfo[field] == "") {
        userInfo.remove(field);
      }
    }

  }

  static checkForHasList(userInfo, String listKey) {
    bool hasAList = (userInfo.containsKey(listKey) && userInfo[listKey] != null && userInfo[listKey].length != 0);
    //debugPrint("checking if " + listKey + " has a list. result: " + hasAList.toString());
    return hasAList;
  }

  static checkForHasValue(userInfo, String listKey) {
    bool hasAValue = (userInfo.containsKey(listKey) && userInfo[listKey] != null && (userInfo[listKey] is! List || userInfo[listKey].length != 0)  );
    debugPrint("checking if " + listKey + " has a value. result: " + hasAValue.toString());
    return hasAValue;
  }

}
