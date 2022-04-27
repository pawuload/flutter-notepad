import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AppTextFieldRaw extends HookWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String hint;
  final IconData prefixIcon;
  final Widget? error;
  final FocusNode? focusNode;

  const AppTextFieldRaw({
    Key? key,
    required this.controller,
    this.keyboardType,
    required this.obscureText,
    required this.hint,
    required this.prefixIcon,
    required this.error,
    required this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildField(context),
        if (error != null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: error!,
          ),
      ],
    );
  }

  Widget _buildField(BuildContext context) {
    useListenable(controller);
    useListenable(focusNode);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          border: Border.all(
            width: 2,
            color: _buildColor(),
          ),
        ),
        child: _buildTextField(),
      ),
    );
  }

  Color _buildColor() {
    if (error != null) {
      return Colors.red;
    } else if (focusNode!.hasFocus) {
      return Colors.brown;
    } else {
      return Colors.grey;
    }
  }

  Widget _buildTextField() {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: const TextStyle(fontSize: 16),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 13, color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(vertical: 4),
        border: const OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
