import 'package:app/provider/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

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
