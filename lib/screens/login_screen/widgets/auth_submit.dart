// import 'package:flutter/material.dart';
//
// String userEmail = '';
// String userPassword = '';
//
// bool isChecked = true;
// bool isButtonActive = false;
//
// final emailKey = GlobalKey<FormState>();
// final passwordKey = GlobalKey<FormState>();
//
// void submit() {
//   final isEmailValid = emailKey.currentState!.validate();
//   final isPasswordValid = passwordKey.currentState!.validate();
//   // FocusScope.of(context).unfocus();
//
//   final isValid = isEmailValid && isPasswordValid;
//   if (isValid) {
//     emailKey.currentState!.save();
//     passwordKey.currentState!.save();
//     print(userEmail);
//     print(userPassword);
//   }
//
//   // if(isButtonActive && isValid){
//   //   Navigator.push(
//   //     context,
//   //     MaterialPageRoute(builder: (context) => const HomeScreen()),
//   //   );
//   }
// // }