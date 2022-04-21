import 'package:flutter/material.dart';
import '../../../common/widget/app_textfield.dart';

class AuthScreenForm extends StatelessWidget {
  const AuthScreenForm({
    Key? key,
    required this.value,
    required this.passwordKey,
    required this.emailKey,
    required this.onSavedEmail,
    required this.onSavedPassword,
  }) : super(key: key);
  final value;
  final emailKey;
  final passwordKey;
  final Function onSavedEmail;
  final Function onSavedPassword;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Form(
          key: emailKey,
          child: AppTextField(
            hintText: 'Email',
            icon: const Icon(Icons.account_circle),
            enabled: value,
            inputType: TextInputType.emailAddress,
            obscure: false,
            onSaved: onSavedEmail,
            validator: (input) {
              if (input == null ||
                  !input.contains('@') ||
                  !input.contains('.')) {
                return 'Please enter a valid email address.';
              }
              return null;
            },
          ),
        ),
        Form(
          key: passwordKey,
          child: AppTextField(
            hintText: 'Password',
            icon: const Icon(Icons.lock),
            enabled: value,
            inputType: TextInputType.visiblePassword,
            obscure: true,
            onSaved: onSavedPassword,
            validator: (input) {
              if (input == null || input.length < 7) {
                return 'Password must be at least 7 characters long';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
