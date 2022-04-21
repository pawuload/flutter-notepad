import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../common/widget/app_button.dart';
import 'package:app/screens/login_screen/widget/auth_screen_logo.dart';
import 'package:app/screens/login_screen/widget/auth_screen_card.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  Future _submitAuthForm() async {
    String _message = '';
    bool _error = false;
    UserCredential _userCredential;
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail.trim(),
        password: userPassword,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _userCredential = await _auth.createUserWithEmailAndPassword(
          email: userEmail.trim(),
          password: userPassword,
        );
      } else if (e.code == 'wrong-password') {
        _message = 'The password is invalid.';
        _error = true;
      } else if (e.code == 'network-request-failed') {
        _message = 'A network error has occurred';
        _error = true;
      } else {
        _message = 'Error: logging in failed. Please, try again later';
        _error = true;
      }
      if (_error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 3),
            content: Text(
              _message,
              style: const TextStyle(color: Colors.red),
            ),
            action: SnackBarAction(
              label: 'OK',
              onPressed: () {},
            ),
          ),
        );
      }
    }
  }

  String userEmail = '';
  String userPassword = '';
  bool value = false;
  bool isChecked = true;
  bool isButtonActive = true;

  final emailKey = GlobalKey<FormState>();
  final passwordKey = GlobalKey<FormState>();

  void submit() {
    final isEmailValid = emailKey.currentState!.validate();
    final isPasswordValid = passwordKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    final isValid = isEmailValid && isPasswordValid;
    if (isValid) {
      emailKey.currentState!.save();
      passwordKey.currentState!.save();
    }

    if (isButtonActive && isValid) {
      _submitAuthForm();
    }
  }

  void setUserEmail(val) {
    userEmail = val;
  }

  void setUserPassword(val) {
    userPassword = val;
  }

  void onChanged(value) {
    setState(() {
      this.value = value!;
      isChecked = value;
      isButtonActive = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const AuthScreenLogo(),
          Expanded(
            flex: 4,
            child: AuthScreenCard(
              value: value,
              emailKey: emailKey,
              passwordKey: passwordKey,
              setUserEmail: setUserEmail,
              setUserPassword: setUserPassword,
              onChanged: onChanged,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: AppButton(
              title: 'Login',
              onPressed: submit,
            ),
          ),
        ],
      ),
    );
  }
}
