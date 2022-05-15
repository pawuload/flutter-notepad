import 'package:app/screens/auth/state/auth_screen_state.dart';
import 'package:app/screens/auth/view/auth_screen_view.dart';
import 'package:app/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AuthScreen extends HookWidget {
  static const route = '/auth';
  static final routeConfig = RouteConfig.material(() => const AuthScreen());

  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final navigator = useScopedNavigator();
    final state = useAuthScreenState(navigateToHome: () => navigator.pushReplacementNamed(HomeScreen.route));

    return AuthScreenView(state: state);
  }
}
