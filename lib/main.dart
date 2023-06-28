import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/routes/routes_generator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String initialRoute = await findIntialRoute();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp(initialRoute)));
}

Future<String> findIntialRoute() async {
  String initialRoute = Routes.onboardingScreen;
  return initialRoute;
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp(this.initialRoute, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primaryColor: Colors.white),
      title: 'Flutter Demo',
      initialRoute: Routes.onboardingScreen,
      onGenerateRoute: RoutesGenerator.generateRoute,
      onGenerateInitialRoutes: (String initialRouteName) {
        return [
          RoutesGenerator.generateRoute(
              const RouteSettings(name: Routes.onboardingScreen)),
        ];
      },
    );
  }
}
