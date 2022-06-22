import 'package:app/service/auth_service.dart';
import 'package:app/service/item_service.dart';
import 'package:app/service/storage_service.dart';
import 'package:app/service/user_service.dart';
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
