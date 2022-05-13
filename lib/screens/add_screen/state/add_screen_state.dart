import 'dart:async';

import 'package:app/provider/user/user_state.dart';
import 'package:app/service/item_service.dart';
import 'package:app/service/user_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AddScreenState {
  final FieldState titleState;
  final FieldState descriptionState;
  final Function() onSaveButtonPressed;
  final Function() timer;
  final Function() switchPremium;
  final Function() switchReadOnly;
  final bool isReadOnlyState;
  final UserState userState;
  final int timeLeft;

  const AddScreenState({
    required this.titleState,
    required this.descriptionState,
    required this.onSaveButtonPressed,
    required this.timer,
    required this.isReadOnlyState,
    required this.userState,
    required this.timeLeft,
    required this.switchPremium,
    required this.switchReadOnly,
  });
}

AddScreenState useAddScreenState() {
  final itemService = useInjected<ItemService>();
  final userService = useInjected<UserService>();
  final titleState = useFieldStateSimple();
  final descriptionState = useFieldStateSimple();
  final userState = useProvided<UserState>();
  final isPremium = useState<bool>(userState.user!.details.isPremium);
  final isReadOnlyState = useState<bool>(false);
  final timeLeft = useState<int>(45);

  final save = useSubmitState(
    submit: (_) async => await itemService.saveItem(
      title: titleState.value,
      description: descriptionState.value,
      imageUrl: '',
    ),
  );

  void startCountDown() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (timeLeft.value > 0) {
          timeLeft.value--;
        } else {
          timer.cancel();
        }
      }
    );
  }

  final switchPremium = useSubmitState(submit: (_) async {
    isPremium.value = !isPremium.value;
    await userService.switchPremium(email: userState.user!.details.email, id: userState.user!.id, isPremium: isPremium.value);
  });

  final switchReadOnly = useSubmitState(submit: (_) async => isReadOnlyState.value = !isReadOnlyState.value);

  return AddScreenState(
    onSaveButtonPressed: () {
      if (titleState.value != '') {
        save.submitWithInput(null);
      }
    },
    switchReadOnly: () {
      switchReadOnly.submitWithInput(null);
    },
    titleState: titleState,
    descriptionState: descriptionState,
    userState: userState,
    timeLeft: timeLeft.value,
    isReadOnlyState: isReadOnlyState.value,
    timer: () => startCountDown(),
    switchPremium: () {
      switchPremium.submitWithInput(null);
    },
  );
}
