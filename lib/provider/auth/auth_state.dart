import 'package:flutter/cupertino.dart';
import 'auth_state_provider.dart';

class AuthState {
  final AuthStatus status;

  AuthState({Key? key, required this.status});
}