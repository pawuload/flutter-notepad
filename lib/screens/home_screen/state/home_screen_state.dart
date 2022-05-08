import 'package:app/models/note/note.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/item_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class HomeScreenState {
  final RefreshableComputedState<List<Note>> noteState;
  final UserState userState;

  const HomeScreenState({required this.noteState, required this.userState});
}

HomeScreenState useHomeScreenState() {
  final itemService = useInjected<ItemService>();

  final userState = useProvided<UserState>();

  final noteState = useAutoComputedState(
    compute: () async => await itemService.getAllItems(),
    keys: [],
  );

  return HomeScreenState(
    userState: userState,
    noteState: noteState,
  );
}
