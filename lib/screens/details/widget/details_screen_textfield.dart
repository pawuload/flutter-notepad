import 'package:app/common/widget/textfield/note_textfield/note_textfield.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class DetailsScreenTextField extends HookWidget {
  final FieldState state;
  final double fontSize;
  final bool showBorder;
  final bool isReadOnly;
  final int maxLines;
  final int limit;

  const DetailsScreenTextField({
    Key? key,
    required this.state,
    required this.fontSize,
    required this.showBorder,
    required this.isReadOnly,
    this.limit = 10000,
    this.maxLines = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NoteTextField(
      state: state,
      fontSize: fontSize,
      maxLines: maxLines,
      showBorder: showBorder,
      isReadOnly: isReadOnly,
    );
  }
}
