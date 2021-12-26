import 'package:pagination/ui/home/home_screen.dart';
import 'package:pagination/ui/splash_screen.dart';
import 'package:pagination/utils/strings.dart';

class AppRoutes {
  static final routes = {
    splashRoute: (context) => const SplashScreen(),
    homeRoute: (context) => const HomeScreen(),
  };
}
