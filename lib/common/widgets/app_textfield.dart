import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  final String hintText;
  final icon;
  final inputType;
  final bool enabled;
  final bool obscure;
  final validator;

  const Field({
    Key? key,
    required this.hintText,
    this.icon,
    required this.enabled,
    required this.inputType,
    required this.obscure,
    this.validator,
  }) : super(key: key);

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  get prefixIcon => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            validator: widget.validator,
            enabled: widget.enabled,
            keyboardType: widget.inputType,
            obscureText: widget.obscure,
            decoration: InputDecoration(
              hintText: widget.hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              prefixIcon: prefixIcon ?? widget.icon,
              hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
              ),
            ),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
