import 'package:app/common/widget/dialog/app_alert_dialog.dart';
import 'package:app/screens/details_screen/details_screen.dart';
import 'package:app/screens/details_screen/details_screen_args.dart';
import 'package:app/screens/home_screen/state/home_screen_state.dart';
import 'package:app/screens/home_screen/view/home_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

import '../auth/auth_screen.dart';

class HomeScreen extends HookWidget {
  static const route = '/home';
  static final routeConfig = RouteConfig.material(() => const HomeScreen());

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useHomeScreenState(
      navigateToDetails: (note) => navigator.pushNamed(
        DetailsScreen.route,
        arguments: DetailsScreenArgs(note: note),
      ),
      showPremiumDialog: (item) async => await AppAlertDialog.showPremium(context, item: item),
      navigateToAdd: () => navigator.pushNamed(AuthScreen.route), //TODO
    );

    return HomeScreenView(state: state);
  }
}
