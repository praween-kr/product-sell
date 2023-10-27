import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
import 'package:oninto_flutter/routes/app_routes.dart';
import 'package:oninto_flutter/routes/routes.dart';

import 'service/local/db_helper.dart';
import 'service/local/local_store_keys.dart';

void main() async {
  await GetStorage.init();
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
  String initialRoute = Routes.splashScreen;
  return initialRoute;
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp(this.initialRoute, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins', primaryColor: Colors.transparent),
      title: 'Flutter Demo',
      initialRoute: Routes.splashScreen,
      // onGenerateRoute: RoutesGenerator.generateRoute,
      // onGenerateInitialRoutes: (String initialRouteName) {
      //   return [
      //     RoutesGenerator.generateRoute(
      //         const RouteSettings(name: Routes.splashScreen)),
      //   ];
      // },
      getPages: AppRoutes.routes,
    );
  }

  static startFirstScreen(String? message) {
    DbHelper.deleteData(SharedPrefKeys.userInfo);
    //"UserStoredInfo().userInfo = null";
    NavigateTo.login();
    // SocketHelper().disconnectUser();
    Get.deleteAll(force: true);
    // AppLoader.hide();
  }
}
