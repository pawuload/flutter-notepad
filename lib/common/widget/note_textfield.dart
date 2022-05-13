import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'note_textfield_raw.dart';

class NoteTextField extends HookWidget {
  final FieldState state;
  final Function() onTap;
  final String? hint;
  final int limit;
  final int maxLines;
  final double fontSize;
  final bool showBorder;
  final bool isReadOnly;

  const NoteTextField({
    Key? key,
    required this.state,
    required this.fontSize,
    required this.onTap,
    required this.showBorder,
    required this.maxLines,
    required this.isReadOnly,
    this.limit = 10000,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatelessTextEditingControllerWrapper(
      value: state.value,
      onChanged: state.onChanged,
      child: (controller) => NoteTextFieldRaw(
        onTap: onTap,
        controller: controller,
        limit: limit,
        fontSize: fontSize,
        maxLines: maxLines,
        hint: hint,
        showBorder: showBorder,
        isReadOnly: isReadOnly,
      ),
    );
  }
}
