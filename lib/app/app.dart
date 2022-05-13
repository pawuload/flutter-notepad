import 'package:app/provider/auth/auth_state_provider.dart';
import 'package:app/provider/setup/setup_state_provider.dart';
import 'package:app/provider/user/user_state_provider.dart';
import 'package:app/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'package:utopia_hooks/utopia_hooks.dart';
import 'package:utopia_utils/utopia_utils.dart';

import 'app_injector.dart';
import 'app_reporter.dart';

final injector = Injector.appInstance;

class App extends HookWidget {
  const App({Key? key}) : super(key: key);

  static void run() {
    UtopiaHooks.reporter = appReporter;
    runAppWithReporter(appReporter, const App());
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        InjectorProvider(setupInjector: () => AppInjector.setup()),
        const SetupStateProvider(),
        const UserStateProvider(),
        const AuthStateProvider(),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.brown,
        ),
        debugShowCheckedModeBanner: false,
        title: 'notepad',
        home: const SplashScreen(),
      ),
    );
  }
}
