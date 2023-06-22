import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:oninto_flutter/routes/routes.dart';
import 'package:oninto_flutter/routes/routes_generator.dart';

void main() async {
  String initialRoute = await findIntialRoute();
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
  //   systemNavigationBarColor: Colors.grey, // navigation bar color
  //   statusBarColor: Colors.black,
  //   statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
  //   statusBarBrightness: Brightness.light,
  //   // status bar color
  // ));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(MyApp(initialRoute)));
}

Future<String> findIntialRoute() async {
  String initialRoute = Routes.bottomScreen;
  return initialRoute;
}

class MyApp extends StatelessWidget {
  String initialRoute;

  MyApp(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: Center(child: child),
        );
      },
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        fontFamily: "Poppins",
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.bottomScreen,
      //initialRoute: Routes.languageScreen,
      // navigatorObservers: [ClearFocusOnPush()],
      onGenerateRoute: RoutesGenerator.generateRoute,
      onGenerateInitialRoutes: (String initialRouteName) {
        return [
          RoutesGenerator.generateRoute(RouteSettings(name: initialRoute)),
        ];
      },
    );
  }
}
