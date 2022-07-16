import 'dart:async';

import 'package:app/models/note/note.dart';
import 'package:app/provider/auth/auth_state_provider.dart';
import 'package:app/provider/user/user_state_provider.dart';
import 'package:app/service/item/item_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class ItemState {
  final List<Note>? note;

  ItemState({required this.note});
}

class ItemStateProvider extends HookStateProviderWidget<ItemState> {
  const ItemStateProvider({Key? key}) : super(key: key);

  @override
  ItemState use() {
    final itemService = useInjected<ItemService>();
    final userState = useProvided<UserState>();
    final authState = useProvided<AuthState>();
    final itemDataState = useStream(
      useMemoized(() {
        if (userState.isInitialized && authState.status == AuthStatus.authorized) {
          return itemService.itemDataStream();
        } else {
          return StreamController().stream;
        }
      }, [
        userState.isInitialized,
        authState.status,
      ]),
    );
    return ItemState(
      note: itemDataState.data,
    );
  }
}
