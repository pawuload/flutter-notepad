import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';

class InputValidator {
  static String Function(BuildContext)? validateEmailInput(String email) {
    if (!EmailValidator.validate(email)) return (_) => 'Please enter a valid email adress';
    return null;
  }

  static String Function(BuildContext)? validatePasswordConstraints(String password) {
    if (password.length < 6) return (_) => 'Password must be at least 7 characters long';
    return null;
  }
}
