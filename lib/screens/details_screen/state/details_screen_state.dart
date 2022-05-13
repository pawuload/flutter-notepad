import 'package:app/models/note/note.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/item_service.dart';
import 'package:app/service/user_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class DetailsScreenState {
  final FieldState titleFieldState;
  final FieldState descriptionFieldState;
  final UserState userState;
  final bool isReadOnlyState;
  final bool isPremium;
  final Function() onSaveButtonPressed;
  final Function() onDeleteBtn;
  final Function() switchPremium;
  final Function() switchReadOnly;

  const DetailsScreenState({
    required this.isReadOnlyState,
    required this.isPremium,
    required this.onSaveButtonPressed,
    required this.titleFieldState,
    required this.descriptionFieldState,
    required this.switchPremium,
    required this.switchReadOnly,
    required this.onDeleteBtn,
    required this.userState,
  });
}

DetailsScreenState useDetailsScreenState({required Note note}) {
  final itemService = useInjected<ItemService>();
  final userService = useInjected<UserService>();
  final userState = useProvided<UserState>();
  final isPremium = useState<bool>(userState.user!.details.isPremium);
  final isReadOnlyState = useState<bool>(true);
  final titleFieldState = useFieldStateSimple(initialValue: note.details.title);
  final descriptionFieldState = useFieldStateSimple(initialValue: note.details.description);

  final save = useSubmitState(
    submit: (_) async => await itemService.updateItem(
      title: titleFieldState.value,
      description: descriptionFieldState.value,
      id: note.id,
      imageUrl: '',
    ),
  );

  final delete = useSubmitState(
    submit: (_) async => await itemService.deleteItem(id: note.id),
  );

  final switchPremium = useSubmitState(submit: (_) async {
    isPremium.value = !isPremium.value;
    await userService.switchPremium(email: userState.user!.details.email, id: userState.user!.id, isPremium: isPremium.value);
  });

  final switchReadOnly = useSubmitState(submit: (_) async => isReadOnlyState.value = !isReadOnlyState.value);

  return DetailsScreenState(
    onSaveButtonPressed: () {
      if (titleFieldState.value != '') {
        save.submitWithInput(null);
      }
    },
    onDeleteBtn: () {
      delete.submitWithInput(null);
    },
    switchReadOnly: () {
      switchReadOnly.submitWithInput(null);
    },
    isReadOnlyState: isReadOnlyState.value,
    descriptionFieldState: descriptionFieldState,
    titleFieldState: titleFieldState,
    switchPremium: () {
      switchPremium.submitWithInput(null);
    },
    userState: userState,
    isPremium: isPremium.value,
  );
}
