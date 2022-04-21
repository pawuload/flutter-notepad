import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future submitAuthForm({
    required String email,
    required String password,
  }) async {
    String _message = '';
    bool _error = false;
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
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
      // if (_error) {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       duration: const Duration(seconds: 3),
      //       content: Text(
      //         _message,
      //         style: const TextStyle(color: Colors.red),
      //       ),
      //       action: SnackBarAction(
      //         label: 'OK',
      //         onPressed: () {},
      //       ),
      //     ),
      //   );
      // }
    }
  }
}
