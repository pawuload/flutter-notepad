import 'package:app/models/note/note.dart';
import 'package:app/service/item_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class HomeScreenState {
  final RefreshableComputedState<List<Note>> noteState;

  const HomeScreenState({required this.noteState});
}

HomeScreenState useHomeScreenState() {
  final itemService = useInjected<ItemService>();
  final noteState = useAutoComputedState(
    compute: () async => await itemService.getAllItems(),
    keys: [],
  );

  return HomeScreenState(
    noteState: noteState,
  );
}
