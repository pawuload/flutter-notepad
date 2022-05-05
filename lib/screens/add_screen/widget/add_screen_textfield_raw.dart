import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddScreenTextFieldRaw extends HookWidget {
  final TextEditingController controller;
  final String hint;
  final double fontSize;
  final int maxLines;
  final int limit;

  const AddScreenTextFieldRaw({
    Key? key,
    required this.controller,
    this.hint = '',
    required this.fontSize,
    required this.limit,
    this.maxLines = 1,
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
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.4,
            color: Colors.brown,
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: TextField(
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
