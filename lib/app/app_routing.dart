import 'package:app/screens/auth/auth_screen.dart';
import 'package:app/screens/details_screen/details_screen.dart';
import 'package:app/screens/home_screen/home_screen.dart';
import 'package:app/screens/splash_screen/splash_screen.dart';
import 'package:utopia_arch/utopia_arch.dart';

class AppRouting {
  static final routes = <String, RouteConfig>{
    SplashScreen.route: SplashScreen.routeConfig,
    HomeScreen.route: HomeScreen.routeConfig,
    AuthScreen.route: AuthScreen.routeConfig,
    DetailsScreen.route: DetailsScreen.routeConfig,
  };

  static const initialRoute = SplashScreen.route;
}
