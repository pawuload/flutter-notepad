import 'package:app/common/widget/textfield/note_textfield/note_textfield_raw.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class NoteTextField extends HookWidget {
  final FieldState state;
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
