import 'package:app/models/user/user_data.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/user_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class UserStateProvider extends HookStateProviderWidget<UserState> {
  const UserStateProvider({Key? key}) : super(key: key);

  @override
  UserState use() {
    final userService = useInjected<UserService>();

    final computedState = useAutoComputedState<UserData>(
      compute: () async => await userService.getUser(),
      keys: [],
    );

    return useMemoized(
      () => UserState(
        getUser: () => computedState.valueOrPreviousOrNull,
        refresh: () async => await computedState.tryRefresh(),
      ),
    );
  }
}
