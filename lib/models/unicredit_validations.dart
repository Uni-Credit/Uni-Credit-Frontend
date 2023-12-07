



class UniCreditValidations {

  static String? Function(String? v) idEstudante() {
    return (String? v) {
      if (v == null) {
        return "";
      }

      if (v.length != 6) {
        return "6 Digitos";
      }


      return null;
    };
  }

}