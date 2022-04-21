import 'package:app/common/widget/app_textfield_raw.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils_extensions.dart';

class AppTextField extends HookWidget {
  final FieldState state;
  final TextInputType? keyboardType;
  final String hint;
  final IconData prefixIcon;

  const AppTextField({
    Key? key,
    required this.state,
    this.keyboardType,
    required this.hint,
    required this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StatelessTextEditingControllerWrapper(
      value: state.value,
      onChanged: state.onChanged,
      child: (controller) => AppTextFieldRaw(
        error: state.errorMessage?.let((it) => Text(it(context))),
        controller: controller,
        keyboardType: keyboardType,
        obscureText: state.isObscured == true,
        hint: hint,
        prefixIcon: prefixIcon,
      ),
    );
  }

  Widget _buildObscuredSuffix(BuildContext context, bool isObscured) {
    return IconButton(
      onPressed: state.onIsObscuredChanged,
      icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off),
    );
  }
}
