import 'package:app/screens/login_screen/state/auth_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:app/common/widget/textfield/app_textfield/app_textfield.dart';

class AuthScreenForm extends StatelessWidget {
  final AuthScreenState state;

  const AuthScreenForm({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          state: state.emailState,
          hint: 'Email',
          prefixIcon: Icons.account_circle,
          obscureText: false,
        ),
        AppTextField(
          state: state.passwordState,
          hint: 'Password',
          prefixIcon: Icons.lock,
          obscureText: true,
        ),
      ],
    );
  }
}
