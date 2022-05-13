import 'package:app/provider/auth/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class AuthStateProvider extends HookStateProviderWidget<AuthState> {
  const AuthStateProvider({Key? key}) : super(key: key);

  @override
  AuthState use() {
    final userState = useState<User?>(null);
    useStreamSubscription<User?>(
      useMemoized(() => FirebaseAuth.instance.authStateChanges()),
      (user) => userState.value = user,
    );

    return AuthState(
      user: userState.value,
    );
  }
}
