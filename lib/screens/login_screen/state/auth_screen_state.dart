import 'package:app/service/auth_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_arch/utopia_arch_extensions.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:app/util/helpers/input_validator.dart';

class AuthScreenState {
  final bool isCheckboxOn;
  final FieldState emailState;
  final FieldState passwordState;
  final Function() onButtonPressed;
  final Function() onCheckboxPressed;
  final Stream<String?> showSnackBarEvents;
  final bool loading;

  const AuthScreenState({
    required this.isCheckboxOn,
    required this.onButtonPressed,
    required this.emailState,
    required this.passwordState,
    required this.onCheckboxPressed,
    required this.showSnackBarEvents,
    required this.loading,
  });
}

AuthScreenState useAuthScreenState() {
  final authService = useInjected<AuthService>();
  final isCheckboxOn = useState<bool>(false);
  final emailState = useFieldStateSimple();
  final passwordState = useFieldStateSimple();
  final showSnackBarEvents = useStreamController<String?>();
  final isLoading = useState<bool>(false);

  shouldSubmit() {
    final emailError = emailState.validate((value) => InputValidator.validateEmailInput(value));
    final passwordError = passwordState.validate((value) => InputValidator.validatePasswordConstraints(value));

    return emailError && passwordError && isCheckboxOn.value;
  }

  final submitState = useSubmitState(
    submit: (_) async {
      isLoading.value = !isLoading.value;
      final result = await authService.submitAuthForm(
        email: emailState.value,
        password: passwordState.value,
      );
      if (result != null) {
        showSnackBarEvents.add(result);
        isLoading.value = !isLoading.value;
      }
    },
    shouldSubmit: (_) => shouldSubmit(),
  );

  return AuthScreenState(
    onButtonPressed: () {
      submitState.submitWithInput(null);
    },
    loading: isLoading.value,
    isCheckboxOn: isCheckboxOn.value,
    passwordState: passwordState,
    emailState: emailState,
    onCheckboxPressed: () => isCheckboxOn.value = !isCheckboxOn.value,
    showSnackBarEvents: showSnackBarEvents.stream,
  );
}
