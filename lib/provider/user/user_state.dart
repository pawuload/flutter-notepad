import 'package:app/models/user/user_data.dart';

class UserState {
  final UserData? Function() getUser;
  final Future<UserData?> Function() refresh;

  const UserState({
    required this.getUser,
    required this.refresh,
  });

  UserData? get user => getUser();

  bool get isInitialized => user != null;
}
