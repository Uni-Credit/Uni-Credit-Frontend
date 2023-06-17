class Validations {




  static String? Function(String?) password(
      {minLength, showMinLength = false, checkRegex = true}) {
    return (String? v) {
      String? requiredValidationResult = requiredField(v);

      if (requiredValidationResult != null) {
        return requiredValidationResult;
      }

      if (minLength != null && v!.length < minLength) {
        return "Quantidade de dígitos incorreta! ${showMinLength ? "(No mínimo 8)" : ""}";
      }

      if (checkRegex) {
        RegExp atLeastOneLetterRegex = RegExp(r"(?=.*?[a-z])");
        if (!atLeastOneLetterRegex.hasMatch(v!)) {
          return "Deve conter pelo menos uma letra!";
        }

        RegExp atLeastOneNumberRegex = RegExp(r"(?=.*?[0-9])");
        if (!atLeastOneNumberRegex.hasMatch(v)) {
          return "Deve conter pelo menos um numero!";
        }
      }

      return null;
    };
  }

  static String? requiredField(String? v) {
    return (v == null || v == "") ? "Esse campo é obrigatório!" : null;
  }


  static String? idDeEstudante(String? v) {
    return v == null ? 'Obrigatório!' : (v.length == 6 ? null : 'Requer 6 dígitos!');
  }

  static String? email(String? v) {
    String? required = requiredField(v);
    if (required != null) {
      return required;
    }

    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(v!)) {
      return 'Email inválido';
    }

    return null;
  }

  static String? cpf(String? v) {
    String? required = requiredField(v);
    if (required != null) {
      return required;
    }

    String cleanText = v!.replaceAll(RegExp(r'[^a-zA-Z0-9]'), "");

    if (cleanText.length > 11) {
      return "Número de caracteres excedido!";
    }

    if (cleanText.length < 11) {
      return "CPF deve ter 11 dígitos!";
    }

    if (!ValidationCheck.isCPFValid(cleanText)) {
      return "CPF inválido!";
    }
  }

  static String? crm(String? v) {
    String? required = requiredField(v);
    if (required != null) {
      return required;
    }

    if (v!.length != 6) {
      return "Número de dígitos incorreto!";
    }

    return null;
  }

  static String? year(String? v) {
    String? required = requiredField(v);
    if (required != null) {
      return required;
    }

    if (v!.length != 4) {
      return "";
    }

    double yearDifference = (DateTime.now().year - double.parse(v));

    if (yearDifference < 0 || yearDifference > 100) {
      return "";
    }

    return null;
  }

  static String? Function(String?) grouped(
      List<String? Function(String?)> validators) {
    return (String? v) {
      for (String? Function(String?) validator in validators) {
        String? validatorResponse = validator(v);
        if (validatorResponse != null) {
          return validatorResponse;
        }
      }
      return null;
    };
  }

  static String? Function(String?) atLeastOneCorrect(
      List<String? Function(String?)> validators) {
    return (String? v) {
      for (String? Function(String?) validator in validators) {
        String? validatorResponse = validator(v);
        if (validatorResponse == null) {
          return validatorResponse;
        }
      }
      return "";
    };
  }

  static String? Function(String? v) override(
      String? Function(String? p1) validation, overrideString) {
    return (String? v) {
      String? validatedMessage = validation(v);
      return validatedMessage == null ? null : overrideString;
    };
  }

  static String? Function(String? v) minimalLetters(int minimal) {
    return (String? v) {
      if (v == null) {
        return "";
      }

      if (v.length < minimal) {
        return "Pelo menos $minimal Digitos";
      }

      return null;
    };
  }

  static differentFrom(data) {
    return (String? newValue) {
      if (data == newValue) {
        return "";
      }
    };
  }

  static equalTo(data) {
    return (String? newValue) {
      if (data != newValue) {
        return "";
      }
    };
  }

}

class ValidationCheck {
  static bool isCPFValid(String cpf) {
    List<String> blockList = [
      '00000000000',
      '11111111111',
      '22222222222',
      '33333333333',
      '44444444444',
      '55555555555',
      '66666666666',
      '77777777777',
      '88888888888',
      '99999999999',
      '12345678909'
    ];
    // CPF can't be blacklisted
    if (blockList.contains(cpf)) {
      return false;
    }

    var numbers = cpf.substring(0, 9);
    numbers += _verifierDigit(numbers).toString();
    numbers += _verifierDigit(numbers).toString();

    return numbers.substring(numbers.length - 2) ==
        cpf.substring(cpf.length - 2);
  }

  static int _verifierDigit(String cpf) {
    var numbers =
        cpf.split('').map((number) => int.parse(number, radix: 10)).toList();

    var modulus = numbers.length + 1;

    var multiplied = <int>[];

    for (var i = 0; i < numbers.length; i++) {
      multiplied.add(numbers[i] * (modulus - i));
    }

    var mod = multiplied.reduce((buffer, number) => buffer + number) % 11;

    return (mod < 2 ? 0 : 11 - mod);
  }
}
