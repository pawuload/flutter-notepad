import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'add_screen_textfield_raw.dart';

class AddScreenTextField extends HookWidget {
  final FieldState state;
  final String hint;
  final int limit;
  final int maxLines;
  final double fontSize;

  const AddScreenTextField({
    Key? key,
    required this.state,
    this.maxLines = 1,
    this.limit = 100000,
    required this.fontSize,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatelessTextEditingControllerWrapper(
      value: state.value,
      onChanged: state.onChanged,
      child: (controller) => AddScreenTextFieldRaw(
        controller: controller,
        limit: limit,
        fontSize: fontSize,
        maxLines: maxLines,
        hint: hint,
      ),
    );
  }
}
