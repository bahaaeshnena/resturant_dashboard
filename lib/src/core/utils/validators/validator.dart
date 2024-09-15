class Validator {
  static String? validateEmptyText(String? fieldName, String? value) {
    if (value == null || value.isEmpty) {
      // ignore: prefer_adjacent_string_concatenation, unnecessary_brace_in_string_interps
      return '${fieldName} is Required';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email Is Required';
    }

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (!emailRegExp.hasMatch(value)) {
      return 'invalid Email Address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password Is Required';
    }

    if (value.length < 6) {
      return 'error Password';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'error Password2';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'error Password3';
    }

    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'error Password4';
    }
    return null;
  }

  static String? validatPhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'phone Is Required';
    }
    final phoneRegExp = RegExp(r'^\d{10}$');
    if (!phoneRegExp.hasMatch(value)) {
      return 'error Phone';
    }
    return null;
  }
}
