import 'package:app/common/widget/textfield/app_textfield/app_textfield_raw.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

class AppTextField extends HookWidget {
  final FieldState state;
  final TextInputType? keyboardType;
  final String hint;
  final IconData prefixIcon;
  final bool obscureText;

  const AppTextField({
    Key? key,
    required this.state,
    this.keyboardType,
    required this.hint,
    required this.prefixIcon,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatelessTextEditingControllerWrapper(
      value: state.value,
      onChanged: state.onChanged,
      child: (controller) => AppTextFieldRaw(
        error: state.errorMessage?.let(
          (it) => Text(
            it(context),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.red,
            ),
          ),
        ),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        hint: hint,
        prefixIcon: prefixIcon,
        focusNode: state.focusNode,
      ),
    );
  }
}
