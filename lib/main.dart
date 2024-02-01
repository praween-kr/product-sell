import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:oninto_flutter/common_controller/auth/auth_controller.dart';
import 'package:oninto_flutter/push_notification_services/push_notification_services.dart';
import 'package:oninto_flutter/routes/routes.dart';

import 'firebase_options.dart';
import 'routes/app_routes.dart';
import 'service/local/db_helper.dart';
import 'service/local/local_store_keys.dart';
import 'utils/color_constant.dart';
import 'utils/helper/stripe_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await FirebaseMessaging.instance.requestPermission();
  await NotificationService().init();
  StripePaymentService().init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: Brightness.light,
  ));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => hideKeyboard(context),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          fontFamily: 'Poppins',
          primaryColor: Colors.transparent,
          // Colors
          dialogTheme: const DialogTheme(elevation: 1),
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColor.appColor,
            secondary: AppColor.appColor,
            primary: AppColor.appColor,
          ),
          // colorScheme: ThemeData().colorScheme.copyWith(
          //       secondary: AppColor.appColor,
          //       primary: AppColor.appColor,
          //     ),
          progressIndicatorTheme:
              const ProgressIndicatorThemeData(color: AppColor.themeColor),
        ),
        title: 'Flutter Demo',
        initialRoute: Routes.splashScreen,
        supportedLocales: const [
          Locale("en"),
        ],
        localizationsDelegates: const [
          CountryLocalizations.delegate,
        ],
        getPages: AppRoutes.routes,
        navigatorObservers: [ClearFocusOnPush()],
      ),
    );
  }

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
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

class ClearFocusOnPush extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    final focus = FocusManager.instance.primaryFocus;
    focus?.unfocus();
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
