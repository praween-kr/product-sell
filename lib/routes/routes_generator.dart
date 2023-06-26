import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/setting.dart';
import '../splash_screen.dart';
import '../views/authscreens/login_screen.dart';
import '../views/home/bottom_navbar_screen.dart';
import '../views/home/home_screen.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;
    final args = settings.arguments;
    switch (settings.name) {
      case Routes.splashScreen:
        widgetScreen = SplashScreen();
        break;
      case Routes.loginScreen:
        widgetScreen = LoginScreen();
        break;
      case Routes.homeScreen:
        widgetScreen = HomeScreen();
        break;
      case Routes.bottomScreen:
        widgetScreen = BottomScreen();
        break;
      case Routes.settingScreen:
        widgetScreen = SettingScreen();
        break;

      default:
        widgetScreen = _errorRoute();
    }
    return GetPageRoute(
        routeName: settings.name,
        page: () => widgetScreen,
        transition: Transition.rightToLeft,
        settings: settings);
  }

  static Widget _errorRoute() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: const Center(
        child: Text('No Such screen found in route generator'),
      ),
    );
  }
}
