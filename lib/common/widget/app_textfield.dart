import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  final String hintText;
  final bool enabled;
  final bool obscure;
  final icon;
  final inputType;
  final validator;
  final onSaved;
  final formKey;

  const AppTextField({
    Key? key,
    required this.hintText,
    this.icon,
    required this.enabled,
    required this.inputType,
    required this.obscure,
    this.validator,
    this.onSaved,
    this.formKey,
  }) : super(key: key);

  get prefixIcon => null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: TextFormField(
            validator: validator,
            key: formKey,
            onSaved: onSaved,
            enabled: enabled,
            keyboardType: inputType,
            obscureText: obscure,
            decoration: InputDecoration(
              hintText: hintText,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              prefixIcon: prefixIcon ?? icon,
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
