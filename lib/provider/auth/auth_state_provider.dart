import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AuthState {
  final AuthStatus status;

  AuthState({Key? key, required this.status});
}

enum AuthStatus { unknown, authorized, none }

class AuthStateProvider extends HookStateProviderWidget<AuthState> {
  const AuthStateProvider({Key? key}) : super(key: key);

  @override
  AuthState use() {
    final statusState = useState<AuthStatus>(AuthStatus.unknown);

    useStreamSubscription<User?>(
      useMemoized(() => FirebaseAuth.instance.authStateChanges()),
      (user) {
        if (user != null) {
          statusState.value = AuthStatus.authorized;
        }
        if (user == null) {
          statusState.value = AuthStatus.none;
        }
      },
    );

    return AuthState(
      status: statusState.value,
    );
  }
}
