import 'package:app/common/constans/app_color.dart';
import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {
  AppSnackBar({
    Key? key,
    Color backgroundColor = AppColors.lightBrown,
    required String content,
    Duration duration = const Duration(seconds: 4),
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          content: Builder(builder: (_) => Text(content)),
          duration: duration,
        );

  void show(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(this);
  }
}
