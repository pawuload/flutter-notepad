import 'package:app/service/item_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AddScreenState {
  final FieldState titleState;
  final FieldState descriptionState;
  final Function() onSaveBtn;

  const AddScreenState({
    required this.titleState,
    required this.descriptionState,
    required this.onSaveBtn,
  });
}

AddScreenState useAddScreenState() {
  final itemService = useInjected<ItemService>();
  final titleState = useFieldStateSimple();
  final descriptionState = useFieldStateSimple();

  final save = useSubmitState(
    submit: (_) async => await itemService.saveItem(
      title: titleState.value,
      description: descriptionState.value,
    ),
  );

  return AddScreenState(
    onSaveBtn: () {
      if (titleState.value != '') {
        save.submitWithInput(null);
      }
    },
    titleState: titleState,
    descriptionState: descriptionState,
  );
}
