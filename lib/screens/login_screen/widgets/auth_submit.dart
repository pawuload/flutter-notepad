import 'package:flutter/material.dart';
import 'auth_form.dart';

String userEmail = '';
String userPassword = '';

bool isChecked = true;
bool isButtonActive = false;

final emailKey = GlobalKey<FormState>();
final passwordKey = GlobalKey<FormState>();

void submit() {
  final isEmailValid = emailKey.currentState!.validate();
  final isPasswordValid = passwordKey.currentState!.validate();

  if (isEmailValid) {
    emailKey.currentState!.save();

  }
  if (isPasswordValid) {
    passwordKey.currentState!.save();

  }
}
