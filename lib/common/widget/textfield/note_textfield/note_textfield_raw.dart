import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class NoteTextFieldRaw extends HookWidget {
  final TextEditingController controller;
  final String? hint;
  final double fontSize;
  final int maxLines;
  final int limit;
  final bool showBorder;
  final bool isReadOnly;

  const NoteTextFieldRaw({
    Key? key,
    required this.controller,
    required this.showBorder,
    required this.fontSize,
    required this.limit,
    required this.maxLines,
    required this.isReadOnly,
    this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField(context),
      ],
    );
  }

  Widget _buildField(BuildContext context) {
    useListenable(controller);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.7,
            color: showBorder ? Colors.brown : Colors.transparent,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: TextField(
            readOnly: isReadOnly,
            maxLines: maxLines,
            controller: controller,
            inputFormatters: [
              LengthLimitingTextInputFormatter(limit),
            ],
            decoration: _buildInputDecoration(),
            style: TextStyle(fontSize: fontSize),
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration.collapsed(
      hintText: hint,
      hintStyle: TextStyle(
        fontSize: fontSize,
        color: Colors.grey,
      ),
    );
  }
}
