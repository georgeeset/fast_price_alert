/// Basic text validator class for validating input string

class Validator {
  /// Validate imput string with these functions
  /// All function sreturn null if it is ok
  String? validateString(String value) {
    if (value.length < 3) {
      return 'Data is too Short';
    }
    return null;
  }

  String? validatePassword(String val) {
    if (val.isEmpty) {
      return 'Password must not be empty';
    } else {
      if (val.length < 6) {
        return 'Your password is too short';
      }
      return null;
    }
  }

  String? validateEmail(String val) {
    if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val)) {
      return 'Invalid email';
    }

    return null;
  }

  String? validateUserName(String val) {
    //TODO for confirmation of username while signinup
    return null;
  }

  String? validateName(String name) {
    if (!RegExp(r"^[a-zA-Z]+$").hasMatch(name)) {
      return 'only Alphabets';
    }
    if (name.length < 2) {
      return 'Too short';
    }
    return null;
  }
}
