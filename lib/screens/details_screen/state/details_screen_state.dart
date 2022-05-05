import 'package:app/models/note/note.dart';
import 'package:app/service/item_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class DetailsScreenState {
  final FieldState titleState;
  final FieldState descriptionState;


  const DetailsScreenState({
    required this.titleState,
    required this.descriptionState,
});
}

DetailsScreenState useDetailsScreenState() {
  final titleState = useFieldStateSimple();
  final descriptionState = useFieldStateSimple();

  return DetailsScreenState(
    titleState: titleState,
    descriptionState: descriptionState,
  );
}
