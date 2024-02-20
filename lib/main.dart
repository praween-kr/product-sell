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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await FirebaseMessaging.instance.requestPermission();
  PushNotification().initNotification();
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

/**
 * 
 * 
* -----Done-----
1. Sign In, Signup & verification and Logout
2. Profile view and edit
3. Add and view shipping address(with google search and pick by google map)
4. Change password
 
2. Add Product (Action, Fixed Price and Share Product)
3. Show Product listing and also details
    -My Buy products
    -My Sell products, 
    -My products(Co-owner(share), Physical) --for selling
    -Filte products
4. Edit product info

5. Home screen searching and filtering
6. show products categories by category and near by
7. Fiexed price product 
   -buy with payment(stripe) and shipping address
   -connect with chat to vendor
9. Biding-
   -Biding functionlity
   -Show biding histories
   -After bid buy product
   -connect with chat to vendor
10. Co-owner(Share product)
   -buy share
   -Connect with group chat
11. My favourite
12. Message
   -Community chat(Share product group) and also poll functionality
   -One to one chat(to ventor)
 

*-----Pending-----
1. Co-owner product
   -Add stripe (Buy shares)
   -Show share info and need to manage it
2. Manage amount/prices during paymement(price and changes)
3. Normal info change in product details screen
4. Subscription
5. Social Login
6. Push Notification


*-----Discuss On-----
1. Bid
   -After biding end, that products will be show publicly or not
   -If user bid product history, will be show in user account?(got or not got products)
2. Product
 *  -biding issue change details sreen to fiexed price product
 *  -After Buy product--> how can update status of product delivering- (pedding, ongoing or completed)
 *   because need to show and in seller side and as well as recieve payment of product by admin
 * 



-->>> 1
1. My bought share product listing
2. 

*/