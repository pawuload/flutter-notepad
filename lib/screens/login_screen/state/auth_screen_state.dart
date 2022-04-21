import 'package:app/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_arch/utopia_arch_extensions.dart';
import 'package:utopia_hooks/hooks.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../../../util/helpers/input_validator.dart';

class AuthScreenState {
  final bool isCheckboxOn;
  final FieldState emailState;
  final FieldState passwordState;
  final Function() onButtonPressed;
  final Function() onCheckboxPressed;

  const AuthScreenState({
    required this.isCheckboxOn,
    required this.onButtonPressed,
    required this.emailState,
    required this.passwordState,
    required this.onCheckboxPressed,
  });
}

AuthScreenState useAuthScreenState() {
  final authService = useInjected<AuthService>();
  final isCheckboxOn = useState<bool>(false);
  final emailState = useFieldStateSimple();
  final passwordState = useFieldStateSimple();
  shouldSubmit() {
    final emailError = emailState.validate((value) => InputValidator.validateEmailInput(value));
    final passwordError = passwordState.validate((value) => InputValidator.validatePasswordConstraints(value));

    return emailError && passwordError && isCheckboxOn.value;
  }

  final submitState = useSubmitState(
    submit: (_) async {
      await authService.submitAuthForm(
        email: emailState.value,
        password: passwordState.value,
      );
    },
    shouldSubmit: (_) => shouldSubmit(),
  );

  return AuthScreenState(
    onButtonPressed: () {
      submitState.submitWithInput(null);
    },
    isCheckboxOn: isCheckboxOn.value,
    passwordState: passwordState,
    emailState: emailState,
    onCheckboxPressed: () => isCheckboxOn.value = !isCheckboxOn.value,
  );
}
