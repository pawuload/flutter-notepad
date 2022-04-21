import 'package:app/service/auth_service.dart';
import 'package:injector/injector.dart';

class AppInjector {
  const AppInjector._();

  static Injector setup() {
    final injector = Injector();
    injector
      .registerSingleton(() => AuthService());

    return injector;
  }
}