import 'package:app/common/constans/app_color.dart';
import 'package:app/common/constans/app_images.dart';
import 'package:app/provider/auth/auth_state.dart';
import 'package:app/provider/user/user_state.dart';
import 'package:app/screens/home_screen/home_screen.dart';
import 'package:app/screens/login_screen/auth_screen.dart';
import 'package:app/util/hooks/setup_state_hooks.dart';
import 'package:flutter/material.dart';
import 'package:utopia_hooks/utopia_hooks.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userState = useProvided<UserState>();
    final authState = useProvided<AuthState>();

    useAsyncEffectAfterSetup(() async {
      if (userState.isInitialized && authState.isInitialized) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
      if (authState.isInitialized == false) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const AuthScreen(),
          ),
        );
      }
    }, [
      userState.isInitialized,
      authState.isInitialized,
    ]);

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.lightestBrown,
        child: Center(
          child: Image.asset(
            AppImages.logo,
            width: 100,
          ),
        ),
      ),
    );
  }
}
