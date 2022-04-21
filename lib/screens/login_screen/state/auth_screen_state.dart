import 'package:app/service/auth_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_arch/utopia_arch_extensions.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import '../../../util/helpers/input_validator.dart';

class AuthScreenState {
  final bool isCheckboxOn;
  final FieldState emailState;
  final FieldState passwordState;
  final Function() onButtonPressed;
  final Function() onCheckboxPressed;
  final Stream<void> showSnackBarEvents;
  final String? errorMessage;

  const AuthScreenState({
    required this.isCheckboxOn,
    required this.onButtonPressed,
    required this.emailState,
    required this.passwordState,
    required this.onCheckboxPressed,
    required this.showSnackBarEvents,
    required this.errorMessage,
  });
}

AuthScreenState useAuthScreenState() {
  final authService = useInjected<AuthService>();
  final isCheckboxOn = useState<bool>(false);
  final emailState = useFieldStateSimple();
  final passwordState = useFieldStateSimple();
  final showSnackBarEvents = useStreamController<void>();
  final errorState = useState<String?>(null);

  shouldSubmit() {
    final emailError = emailState.validate((value) => InputValidator.validateEmailInput(value));
    final passwordError = passwordState.validate((value) => InputValidator.validatePasswordConstraints(value));

    return emailError && passwordError && isCheckboxOn.value;
  }

  final submitState = useSubmitState(
    submit: (_) async {
      final result = await authService.submitAuthForm(
        email: emailState.value,
        password: passwordState.value,
      );
      if (result != null) {
        showSnackBarEvents.add(null);
        errorState.value = result;
      }
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
    showSnackBarEvents: showSnackBarEvents.stream,
    errorMessage: errorState.value,
  );
}
