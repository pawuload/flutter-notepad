import 'package:app/screens/login_screen/state/auth_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/widget/app_button.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app/screens/login_screen/widget/auth_screen_logo.dart';
import 'package:app/screens/login_screen/widget/auth_screen_card.dart';

class AuthScreen extends HookWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useAuthScreenState();

    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const AuthScreenLogo(),
          Expanded(
            flex: 4,
            child: AuthScreenCard(
              state: state,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppButton(
              title: 'Login',
              onPressed: state.onButtonPressed,
              enabled: state.isCheckboxOn,
            ),
          ),
        ],
      ),
    );
  }
}
