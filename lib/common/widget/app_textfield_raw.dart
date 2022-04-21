import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

class AppTextFieldRaw extends HookWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String hint;
  final IconData prefixIcon;
  final Widget? error;


  const AppTextFieldRaw({
    Key? key,
    required this.controller,
    this.keyboardType,
    this.obscureText = false,
    required this.hint,
    required this.prefixIcon,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildField(context),
        if(error != null) error!,
      ],
    );
  }

  Widget _buildField(BuildContext context) {
    useListenable(controller);

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: _buildTextField(),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField() {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(13),
        ),
      ),
    );
  }
}
