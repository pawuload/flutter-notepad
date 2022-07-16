import 'package:app/models/note/note.dart';
import 'package:app/models/premium_dialog/premium_dialog_item.dart';
import 'package:app/provider/item/item_state_provider.dart';
import 'package:app/provider/user/user_state_provider.dart';
import 'package:app/service/auth/auth_service.dart';
import 'package:app/service/user/user_service.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class HomeScreenState {
  final ItemState noteStream;
  final UserState userState;
  final Function(Note) onItemPressed;
  final Function() switchPremium;
  final Function() onPremiumPressed;
  final Function() onAddButtonPressed;
  final Function() onSignOutPressed;

  const HomeScreenState({
    required this.noteStream,
    required this.userState,
    required this.switchPremium,
    required this.onItemPressed,
    required this.onPremiumPressed,
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
  final userService = useInjected<UserService>();
  final authService = useInjected<AuthService>();
  final userState = useProvided<UserState>();
  final noteStream = useProvided<ItemState>();
  final isPremium = useState<bool>(userState.user!.details.isPremium);

  Future<void> switchPremium() async {
    isPremium.value = !userState.user!.details.isPremium;
    await userService.switchPremium(
      email: userState.user!.details.email,
      id: userState.user!.id,
      isPremium: isPremium.value,
    );
    userState.refresh();
  }

  Future<void> logout() async {
    authService.signOut();
    navigateToAuth();
  }

  return HomeScreenState(
    userState: userState,
    noteStream: noteStream,
    switchPremium: () => switchPremium(),
    onItemPressed: (note) => navigateToDetails(note),
    onPremiumPressed: () async {
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
    onAddButtonPressed: () => navigateToAdd(),
    onSignOutPressed: () => logout(),
  );
}
