import 'package:app/service/auth/auth_service.dart';
import 'package:app/service/item/item_service.dart';
import 'package:app/service/storage/storage_service.dart';
import 'package:app/service/user/user_service.dart';
import 'package:injector/injector.dart';

class AppInjector {
  const AppInjector._();

  static Injector setup() {
    final injector = Injector();
    injector
      ..registerSingleton(() => AuthService())
      ..registerSingleton(() => ItemService(injector.get()))
      ..registerSingleton(() => UserService())
      ..registerSingleton(() => StorageService());

    return injector;
  }
}
