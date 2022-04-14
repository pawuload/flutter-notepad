import 'package:flutter/material.dart';
import 'colors.dart';

@immutable
class AppTheme{
  static const colors = AppColors();

  const AppTheme._();

  static ThemeData define(){
    return ThemeData(
      primaryColor: const Color(0xffFFBF7E),
      accentColor: const Color(0xff755335),
      focusColor: const Color(0xff5d2f07),
    );
  }
}