class Information {
  static bool informationIsEmpty(dynamic information) {
    return information == null ||
        ((information is List || information is String) &&
            (information.isEmpty));
  }
}
