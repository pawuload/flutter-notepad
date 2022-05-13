import 'package:app/models/note/note.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/item_service.dart';
import 'package:app/service/user_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class HomeScreenState {
  final RefreshableComputedState<List<Note>> noteState;
  final UserState userState;
  final Function() switchPremium;

  const HomeScreenState({
    required this.noteState,
    required this.userState,
    required this.switchPremium,
  });
}

HomeScreenState useHomeScreenState() {
  final itemService = useInjected<ItemService>();
  final userService = useInjected<UserService>();
  final userState = useProvided<UserState>();
  final isPremium = useState<bool>(userState.user!.details.isPremium);

  final switchPremium = useSubmitState(submit: (_) async {
    isPremium.value = !isPremium.value;
    await userService.switchPremium(email: userState.user!.details.email, id: userState.user!.id, isPremium: isPremium.value);
  });

  final noteState = useAutoComputedState(
    compute: () async => await itemService.getAllItems(),
    keys: [],
  );

  return HomeScreenState(
    userState: userState,
    noteState: noteState,
    switchPremium: () {
      switchPremium.submitWithInput(null);
    },
  );
}
