import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/bottom_navbar_screen.dart';
import 'package:oninto_flutter/choose_plan.dart';
import 'package:oninto_flutter/home_screen.dart';
import 'package:oninto_flutter/routes/routes.dart';

class RoutesGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget widgetScreen;
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.bottomScreen:
        widgetScreen = BottomScreen();
        break;
      case Routes.homeScreen:
        widgetScreen = const HomeScreen();
        break;
      case Routes.chooseScreen:
        widgetScreen = const ChooseplanScreen();
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
