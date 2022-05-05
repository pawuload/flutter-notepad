import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class DetailsScreenText extends HookWidget {
  final FieldState state;
  final String text;
  final double fontSize;
  final bool showBorder;

  const DetailsScreenText({
    Key? key,
    required this.state,
    required this.fontSize,
    required this.text,
    this.showBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.4,
            color: showBorder ? Colors.brown : Colors.transparent,
          ),
        ),
      ),
      child: Center(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.all(8),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );
  }
}
