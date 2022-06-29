import 'dart:async';
import 'package:app/app/app.dart';
import 'package:app/models/note/note.dart';
import 'package:app/provider/auth/auth_state.dart';
import 'package:app/provider/auth/auth_state_provider.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/service/item_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class ItemStateModel {
  final Set<Note> note;

  ItemStateModel({required this.note});
}

class ItemStateProvider extends HookStateProviderWidget<ItemStateModel> {
  const ItemStateProvider({Key? key}) : super(key: key);

  @override
  ItemStateModel use() {
    final itemService = injector.get<ItemService>();
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
    return ItemStateModel(
      note: itemDataState.data,
    );
  }
}
