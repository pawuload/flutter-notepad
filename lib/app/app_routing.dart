import 'package:app/screens/add/add_screen.dart';
import 'package:app/screens/auth/auth_screen.dart';
import 'package:app/screens/details/details_screen.dart';
import 'package:app/screens/home/home_screen.dart';
import 'package:app/screens/splash/splash_screen.dart';

import 'package:utopia_arch/utopia_arch.dart';

class AppRouting {
  static final routes = <String, RouteConfig>{
    SplashScreen.route: SplashScreen.routeConfig,
    HomeScreen.route: HomeScreen.routeConfig,
    AuthScreen.route: AuthScreen.routeConfig,
    DetailsScreen.route: DetailsScreen.routeConfig,
    AddScreen.route: AddScreen.routeConfig,
  };

  static const initialRoute = SplashScreen.route;
}
