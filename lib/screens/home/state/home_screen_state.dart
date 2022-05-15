import 'package:app/models/note/note.dart';
import 'package:app/models/premium_dialog/premium_dialog_item.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/auth_service.dart';
import 'package:app/service/item_service.dart';
import 'package:app/service/user_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class HomeScreenState {
  final RefreshableComputedState<List<Note>> noteState;
  final UserState userState;
  final Function(Note) onItemPressed;
  final Function() switchPremium;
  final Function() onButtonPressed;
  final Function() onAddButtonPressed;
  final Function() onSignOutPressed;

  const HomeScreenState({
    required this.noteState,
    required this.userState,
    required this.switchPremium,
    required this.onItemPressed,
    required this.onButtonPressed,
    required this.onAddButtonPressed,
    required this.onSignOutPressed,
  });
}

HomeScreenState useHomeScreenState({
  required Function(Note) navigateToDetails,
  required Future<bool?> Function(PremiumDialogItem) showPremiumDialog,
  required Function() navigateToAdd,
  required Function() navigateToAuth,
}) {
  final itemService = useInjected<ItemService>();
  final userService = useInjected<UserService>();
  final authService = useInjected<AuthService>();
  final userState = useProvided<UserState>();
  final isPremium = useState<bool>(userState.user!.details.isPremium);

  Future<void> switchPremium() async {
    isPremium.value = !isPremium.value;
    await userService.switchPremium(
      email: userState.user!.details.email,
      id: userState.user!.id,
      isPremium: isPremium.value,
    );
    userState.refresh();
  }

  final noteState = useAutoComputedState(
    compute: () async => await itemService.getAllItems(),
    keys: [],
  );

  Future<void> logout() async {
    authService.signOut();
    navigateToAuth();
  }

  return HomeScreenState(
    userState: userState,
    noteState: noteState,
    switchPremium: () => switchPremium(),
    onItemPressed: (note) async {
      final result = await navigateToDetails(note);
      if (result == true) noteState.refresh();
    },
    onButtonPressed: () async {
      if (userState.user!.details.isPremium == false) {
        final result = await showPremiumDialog(PremiumDialogItem.off);
        if (result == true) {
          switchPremium();
        }
      } else {
        final result = await showPremiumDialog(PremiumDialogItem.on);
        if (result == true) {
          switchPremium();
        }
      }
    },
    onAddButtonPressed: () async {
      final result = await navigateToAdd();
      if (result == true) {
        noteState.refresh();
      }
    },
    onSignOutPressed: () => logout(),
  );
}
