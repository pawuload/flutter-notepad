import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:injector/injector.dart';
import 'package:provider/provider.dart';
import 'package:utopia_arch/utopia_arch.dart';
import 'app/app_injector.dart';
import 'screens/home_screen/home_screen.dart';
import 'screens/login_screen/auth_screen.dart';
import 'common/constans/app_images.dart';
import 'common/constans/app_color.dart';

final injector = Injector.appInstance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // injector.registerSingleton<AuthService>(() => AuthService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MyAppWrapper();
  }
}

class MyAppWrapper extends HookWidget{
  const MyAppWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [InjectorProvider(setupInjector: () => AppInjector.setup()),],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'notepad',
        home: AnimatedSplashScreen(
          splash: AppImages.logo,
          nextScreen: const MyHomePage(),
          backgroundColor: AppColors.lightestBrown,
          duration: 1000,
        ),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'notepad',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: StreamBuilder<dynamic>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData) {
            return const HomeScreen();
          }
          return const AuthScreen();
        },
      ),
    );
  }
}