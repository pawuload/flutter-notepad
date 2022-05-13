import 'package:app/screens/login_screen/state/auth_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:app/common/widget/button/app_button.dart';
import 'package:app/screens/login_screen/widget/auth_screen_logo.dart';
import 'package:app/screens/login_screen/widget/auth_screen_card.dart';
import 'package:app/common/widget/app_snackbar.dart';

class AuthScreen extends HookWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useAuthScreenState();

    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: HookBuilder(
        builder: (context) {
          useStreamSubscription<String?>(
            state.showSnackBarEvents,
            (error) => _showSnackBar(context, error!),
          );
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              const AuthScreenLogo(),
              Expanded(
                flex: 4,
                child: AuthScreenCard(state: state),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: AppButton(
                  loading: state.loading,
                  title: 'Login',
                  onPressed: state.onButtonPressed,
                  enabled: state.isCheckboxOn,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showSnackBar(BuildContext context, String error) {
    Color snackBarColor;
    if (error == 'New user registered!') {
      snackBarColor = Colors.green.withOpacity(0.7);
    } else {
      snackBarColor = Colors.red.withOpacity(0.7);
    }
    AppSnackBar(
      backgroundColor: snackBarColor,
      content: error,
    ).show(context);
  }
}
