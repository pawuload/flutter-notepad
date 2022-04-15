import 'package:app/common/constans/app_images.dart';
import 'package:flutter/material.dart';

import 'widgets/auth_form.dart';
import '../../common/widgets/app_button.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            height: 200,
            child: Hero(
              tag: 'logo',
              child: Image.asset(AppImages.logo),
            ),
          ),
          const AuthForm(),
          const AppButton(
            title: 'Login',
          ),
        ],
      ),
    );
  }
}
