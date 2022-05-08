import 'package:app/models/note/note.dart';
import 'package:app/models/user/user_data.dart';
import 'package:app/service/item_service.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class DetailsScreenState {
  final FieldState titleFieldState;
  final FieldState descriptionFieldState;
  final bool isReadOnlyState;
  final Function() onSaveBtn;
  final Function() onDeleteBtn;
  final Function() switchPremium;

  const DetailsScreenState({
    required this.isReadOnlyState,
    required this.onSaveBtn,
    required this.titleFieldState,
    required this.descriptionFieldState,
    required this.switchPremium,
    required this.onDeleteBtn,
  });
}

DetailsScreenState useDetailsScreenState({required Note note}) {
  final itemService = useInjected<ItemService>();
  final isReadOnlyState = useState<bool>(true);
  final titleFieldState = useFieldStateSimple(initialValue: note.title);
  final descriptionFieldState = useFieldStateSimple(initialValue: note.description);

  final save = useSubmitState(
    submit: (_) async => await itemService.saveItem(
      title: titleFieldState.value,
      description: descriptionFieldState.value,
    ),
  );

  final delete = useSubmitState(
    submit: (_) async => await itemService.deleteItem(),
  );

  final switchPremium = useSubmitState(submit: (_) async {
    isReadOnlyState.value = !isReadOnlyState.value;

  });

  return DetailsScreenState(
    onSaveBtn: () {
      if (titleFieldState.value != '') {
        save.submitWithInput(null);
      }
    },
    onDeleteBtn: () {
      delete.submitWithInput(null);
    },
    isReadOnlyState: isReadOnlyState.value,
    descriptionFieldState: descriptionFieldState,
    titleFieldState: titleFieldState,
    switchPremium: () {
      switchPremium.submitWithInput(null);
    },
  );
}
