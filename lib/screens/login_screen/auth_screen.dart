import 'package:flutter/material.dart';
import 'package:app/common/constans/app_images.dart';
import './widgets/auth_form.dart';
import './widgets/auth_submit.dart';
import '../../common/widgets/app_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  // void onPressed() {
  //   isButtonActive ? submit : null;
  //   FocusScope.of(context).unfocus();
  // }
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  void _submitAuthForm(
    String email,
    String password,
  ) {
    _auth.signInWithEmailAndPassword(email: email, password: password);
  }

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
          AuthForm(_submitAuthForm),
          const AppButton(
            title: 'Login',
            onPressed: submit,
          ),
        ],
      ),
    );
  }
}
