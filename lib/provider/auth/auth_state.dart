import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthState {
  final User? user;

  AuthState({Key? key, required this.user});

  bool get isInitialized => user != null;

}